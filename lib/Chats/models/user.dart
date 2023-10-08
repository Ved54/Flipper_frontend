class UserModel{
  final String uid;
  final String name;
  final String email;
  final String image;

  const UserModel({
    required this.name,
    required this.image,
    required this.uid,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(
        uid: json['uid'],
        name: json['name'],
        image: json['image_url'],
        email: json['email'],
      );
  
}