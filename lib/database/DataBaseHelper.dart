import 'package:chat_flutter/creatingGroup/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../User.dart';

//CollectionReference updateCollection = FirebaseFirestore.instance.collection(Room.COLLECTION_NAME);


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
