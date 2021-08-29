
class Room {
  static const COLLECTION_NAME="rooms";
  String id;
  String description;
  String category;
  String name;
  Room({required this.id,required this.description, required this.name, required this.category});

  Room.fromJson(Map<String,Object?>json):this(
    id:json['id']! as String,
      name:json['userName']! as String,
      description:json['description']! as String,
      category:json['category']! as String,
  );

  Map<String,Object> toJson(){
    return {
      'id':id,
      'userName':name,
      'description':description,
      'category':category
    };
  }

}