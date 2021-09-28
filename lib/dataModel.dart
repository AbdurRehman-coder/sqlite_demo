import 'dart:core';

class DataModel{
  int? id;
  String? title;
  String? description;
  int? age;
  String? email;
  //Constructor for initializing properties
  DataModel({this.id, required this.title, required this.description, required this.age, this.email});

  //Named_Constructor used as json.decoder (Deserialization)
  DataModel.fromMap(Map<String, dynamic> mapRes):
      id = mapRes['id'],
      title = mapRes['title'],
      description = mapRes['description'],
      age = mapRes['age'],
      email = mapRes['email'];

//convert class data to json  (Serialization)
 Map<String, Object?> toMap(){
  return {
    'id' : id,
    'title' : title,
    'description' : description,
    'age' : age,
    'email' : email,

  };
  }
}