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

  factory Student.fromMap(Map<String, dynamic> data) {
    return Student(
      id: data['id'],
      name: data['name'],
      age: data['age'],
      image: data['image'],
    );
  }
}
