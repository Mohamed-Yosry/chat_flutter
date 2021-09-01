import 'package:flutter/cupertino.dart';

class Message {
  static const collectionName='Messages';
  String id="";
   String content="";
   int time=0;
   String senderName="";

   Message({required this.id, required this.content,required this.time,required this.senderName});

  Message.fromJson (Map<String, Object?> json)
      : this( id: json['id']! as String,
    content: json['content']! as String,
    senderName: json['senderName']! as String,
    time: json[' time']! as int, );

  Map<String, Object?> toJson() {
    return { 'id': id,
    'content': content,
    'senderName': senderName,
    'time': time, };}

}