import 'package:hously_flutter/screens/todo/apis_model/user_model.dart';
const boardModelDefault = BoardModel(count: 0, next: null, previous: null, results: []);
class   BoardModel {
  final int? count;
  final String? next;
  final String? previous;
  final List<BoardResults>? results;

 const BoardModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory BoardModel.fromJson(Map<String, dynamic> json) {
    return BoardModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: json['results'] != null
          ? List<BoardResults>.from(
        json['results'].map((v) => BoardResults.fromJson(v)),
      )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results?.map((v) => v.toJson()).toList(),
    };
  }
}

class BoardResults {
  final int? id;
  final User? user;
  final String? name;
  final String? timestamp;

 const BoardResults({
    required this.id,
    required this.user,
    required this.name,
    required this.timestamp,
  });

  factory BoardResults.fromJson(Map<String, dynamic> json) {
    return BoardResults(
      id: json['id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      name: json['name'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
      'name': name,
      'timestamp': timestamp,
    };
  }
}
