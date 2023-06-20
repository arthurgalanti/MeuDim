class Category {
  final String uid;
  final String userId;
  final String name;

  Category(this.userId, this.name, this.uid);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'uid': uid, 'userId': userId, 'name': name};
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      json['uid'],
      json['userId'],
      json['name'],
    );
  }
}
