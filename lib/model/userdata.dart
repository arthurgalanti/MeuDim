class Userdata {
  late final String uid;
  final String name;

  Userdata(this.uid, this.name);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'uid': uid, 'name': name};
  }

  factory Userdata.fromJson(Map<String, dynamic> json) {
    return Userdata(
      json['uid'],
      json['name'],
    );
  }
}
