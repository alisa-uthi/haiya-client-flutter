import 'package:cloud_firestore/cloud_firestore.dart';

class MessageChat {
  int idFrom;
  int idTo;
  String timestamp;
  String content;
  int type;

  MessageChat({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      "idFrom": this.idFrom,
      "idTo": this.idTo,
      "timestamp": this.timestamp,
      "content": this.content,
      "type": this.type,
    };
  }

  factory MessageChat.fromDocument(DocumentSnapshot doc) {
    int idFrom = doc.get("idFrom");
    int idTo = doc.get("idTo");
    int type = doc.get("type");
    String timestamp = doc.get("timestamp");
    String content = doc.get("content");

    return MessageChat(
      idFrom: idFrom,
      idTo: idTo,
      timestamp: timestamp,
      content: content,
      type: type,
    );
  }
}
