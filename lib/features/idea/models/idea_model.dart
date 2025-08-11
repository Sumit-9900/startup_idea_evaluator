import 'package:equatable/equatable.dart';

class IdeaModel extends Equatable {
  final String id;
  final String name;
  final String tagline;
  final String description;
  final double rating;
  final int votes;

  const IdeaModel({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.rating,
    this.votes = 0,
  });

  factory IdeaModel.fromMap(Map<String, dynamic> map) {
    return IdeaModel(
      id: map['id'],
      name: map['name'],
      tagline: map['tagline'],
      description: map['description'],
      rating: map['rating'],
      votes: map['votes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'description': description,
      'rating': rating,
      'votes': votes,
    };
  }

  IdeaModel copyWith({
    String? id,
    String? name,
    String? tagline,
    String? description,
    double? rating,
    int? votes,
  }) {
    return IdeaModel(
      id: id ?? this.id,
      name: name ?? this.name,
      tagline: tagline ?? this.tagline,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      votes: votes ?? this.votes,
    );
  }

  @override
  String toString() {
    return 'IdeaModel(id: $id, name: $name, tagline: $tagline, description: $description, rating: $rating, votes: $votes)';
  }

  @override
  List<Object?> get props => [id, name, tagline, description, rating, votes];
}
