import 'package:cloud_firestore/cloud_firestore.dart';

class MessageChat {
  int idFrom;
  int idTo;
  String? timestamp;
  String content;
  int type;
  String role;

  MessageChat({
    required this.idFrom,
    required this.idTo,
    this.timestamp,
    required this.content,
    required this.type,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      "idFrom": this.idFrom,
      "idTo": this.idTo,
      "timestamp": this.timestamp,
      "content": this.content,
      "type": this.type,
      "role": this.role,
    };
  }

  factory MessageChat.fromDocument(DocumentSnapshot doc) {
    int idFrom = doc.get("idFrom");
    int idTo = doc.get("idTo");
    int type = doc.get("type");
    String content = doc.get("content");
    String role = doc.get("role");

    return MessageChat(
      idFrom: idFrom,
      idTo: idTo,
      content: content,
      type: type,
      role: role,
    );
  }
}
