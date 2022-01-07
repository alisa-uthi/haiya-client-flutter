import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RequestConsulProvider {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  final String _collectionName = "consultation";
  final String _collectionPath = "consultationRequest";

  RequestConsulProvider({
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  Future<void> updateDataFirestore(
      String docId, Map<String, dynamic> dataNeedUpdate) {
    return firebaseFirestore
        .collection(_collectionName)
        .doc(_collectionPath)
        .collection(_collectionPath)
        .doc(docId)
        .update(dataNeedUpdate);
  }

  Stream<QuerySnapshot> getConsultRoomStream(int currentUserId) {
    return firebaseFirestore
        .collection(_collectionName)
        .doc(_collectionPath)
        .collection(_collectionPath)
        .where("patientId", isEqualTo: currentUserId)
        .where(
      "requestStatus",
      whereIn: ["requested", "accepted", "declined"],
    ).snapshots();
  }

  void sendRequest(int currentUserId, int pharmacyId) {
    DocumentReference documentReference = firebaseFirestore
        .collection(_collectionName)
        .doc(_collectionPath)
        .collection(_collectionPath)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference, {
        "requestStatus": "requested",
        "patientId": currentUserId,
        "pharmacyId": pharmacyId,
        "room": "",
        "remark": "",
        "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      });
    });
  }
}
