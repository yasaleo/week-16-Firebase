class PersonModel {
  String? uid;
  String? name;
  String? address;
  int? age;
  PersonModel({this.uid, this.name, this.address, this.age});

  factory PersonModel.fromMap(map) {
    return PersonModel(
      uid: map['uid'],
      name: map['name'],
      age: map['age'],
      address: map['address'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'uid':uid,
      'name':name,
      'age':age,
      'address':address
    };
  }
}
