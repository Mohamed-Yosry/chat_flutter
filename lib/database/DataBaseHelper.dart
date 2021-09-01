import 'package:chat_flutter/creatingGroup/Room.dart';
import 'package:chat_flutter/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../User.dart';

CollectionReference<User> getUsersCollectionWithConverter(){
  return FirebaseFirestore.instance.collection(User.CollectionName).withConverter<User>(
    fromFirestore: (snapshot, _) =>
        User.fromJson(snapshot.data()!),
    toFirestore: (user, _) => user.toJson(),
  );
}

CollectionReference<Room> getRoomsCollectionWithConverter(){
  return FirebaseFirestore.instance.collection(Room.COLLECTION_NAME).withConverter<Room>(
    fromFirestore: (snapshot, _) =>
        Room.fromJson(snapshot.data()!),
    toFirestore: (room, _) => room.toJson(),
  );
}
CollectionReference<Message> getMessageCollectionWithConverter(String roomId){
  final roomCollection =getRoomsCollectionWithConverter();

    return   roomCollection.doc(roomId).collection(Message.collectionName).withConverter<Message>(
    fromFirestore: (snapshot, _) => Message.fromJson(snapshot.data()!),
    toFirestore: (message, _) => message.toJson(),
  );
}
