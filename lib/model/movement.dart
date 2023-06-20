import 'package:cloud_firestore/cloud_firestore.dart';

class Movement {
  final String uid;
  final String userId;
  final double amount;
  final String category;
  late String description;
  final DateTime date;
  final bool isDebit;

  Movement(this.uid, this.userId, this.amount, this.category, this.description,
      this.date, this.isDebit);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'userId': userId,
      'amount': amount,
      'category': category,
      'description': description,
      'date': date,
      'isDebit': isDebit
    };
  }

  factory Movement.fromJson(Map<String, dynamic> json) {
    return Movement(
      json['uid'],
      json['userId'],
      json['amount'],
      json['category'],
      json['description'],
      (json['date'] as Timestamp).toDate(),
      json['isDebit'],
    );
  }
}
