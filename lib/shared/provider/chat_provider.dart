import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:haiya_client/shared/models/message_chat.dart';

class ChatProvider {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  ChatProvider({
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  UploadTask uploadFile(File image, String fileName) {
    Reference reference = firebaseStorage.ref().child("chat/" + fileName);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  Future<void> updateDataFirestore(String collectionPath, String docPath,
      Map<String, dynamic> dataNeedUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(docPath)
        .update(dataNeedUpdate);
  }

  Stream<QuerySnapshot> getChatStream(
      String groupChatId, int limit, String role) {
    return firebaseFirestore
        .collection("messages")
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy("timestamp", descending: true)
        .limit(limit)
        .snapshots();
  }

  void sendMessage(
    String content,
    int type,
    String groupChatId,
    int currentUserId,
    int peerId,
    String role,
  ) {
    DocumentReference documentReference = firebaseFirestore
        .collection("messages")
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().toString());

    MessageChat messageChat = MessageChat(
      idFrom: currentUserId,
      idTo: peerId,
      timestamp: DateTime.now().toString(),
      content: content,
      type: type,
      role: role,
    );
    print(messageChat.toJson());
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        messageChat.toJson(),
      );
    });
  }
}

class TypeMessage {
  static const text = 0;
  static const image = 1;
}
