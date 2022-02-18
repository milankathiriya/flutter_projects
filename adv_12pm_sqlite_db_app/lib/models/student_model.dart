import 'dart:typed_data';

class Student {
  final int? id;
  final String name;
  final int age;
  final Uint8List? image;

  Student({
    this.id,
    required this.name,
    required this.age,
    this.image,
  });

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      image: map['image'],
    );
  }
}
