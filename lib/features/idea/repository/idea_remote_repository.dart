import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:startup_idea_evaluator/core/constants/api_constants.dart';
import 'package:startup_idea_evaluator/core/failure/app_failure.dart';
import 'package:startup_idea_evaluator/features/idea/models/idea_model.dart';
import 'package:http/http.dart' as http;
import 'package:startup_idea_evaluator/features/idea/repository/idea_local_repository.dart';

abstract interface class IdeaRemoteRepository {
  Future<Either<AppFailure, void>> submitIdea(IdeaModel idea);
  Future<Either<AppFailure, List<IdeaModel>>> getIdeas();
  Future<Either<AppFailure, void>> voteIdea(String ideaId, int currentVotes);
  Future<Either<AppFailure, void>> deleteIdea(String ideaId);
}

class IdeaRemoteRepositoryImpl implements IdeaRemoteRepository {
  final http.Client client;
  final IdeaLocalRepository localRepository;
  IdeaRemoteRepositoryImpl({
    required this.client,
    required this.localRepository,
  });

  @override
  Future<Either<AppFailure, void>> submitIdea(IdeaModel idea) async {
    try {
      final url = Uri.parse(ApiConstants.apiUrl);
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode(idea.toMap());

      final response = await client.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        return right(null);
      }
      return left(AppFailure('Failed to submit idea: ${response.body}'));
    } on http.ClientException catch (e) {
      return left(AppFailure('Failed to submit idea: ${e.message}'));
    }
  }

  @override
  Future<Either<AppFailure, List<IdeaModel>>> getIdeas() async {
    try {
      final url = Uri.parse(ApiConstants.apiUrl);
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<IdeaModel> ideas = data
            .map((e) => IdeaModel.fromMap(e))
            .toList();
        return right(ideas);
      }
      return left(AppFailure('Failed to get ideas: ${response.body}'));
    } on http.ClientException catch (e) {
      return left(AppFailure('Failed to get ideas: ${e.message}'));
    }
  }

  @override
  Future<Either<AppFailure, void>> voteIdea(
    String ideaId,
    int currentVotes,
  ) async {
    try {
      final hasVoted = localRepository.isVoted(ideaId);

      final newVotes = hasVoted ? currentVotes - 1 : currentVotes + 1;

      final url = Uri.parse('${ApiConstants.apiUrl}/$ideaId');

      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({'votes': newVotes});

      final response = await client.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        if (hasVoted) {
          await localRepository.removeVote(ideaId);
        } else {
          await localRepository.addVote(ideaId);
        }
        return right(null);
      }
      return left(AppFailure('Failed to vote idea: ${response.body}'));
    } on http.ClientException catch (e) {
      return left(AppFailure('Failed to vote idea: ${e.message}'));
    }
  }

  @override
  Future<Either<AppFailure, void>> deleteIdea(String ideaId) async {
    try {
      final url = Uri.parse('${ApiConstants.apiUrl}/$ideaId');
      final response = await client.delete(url);
      if (response.statusCode == 200) {
        return right(null);
      }
      return left(AppFailure('Failed to delete idea: ${response.body}'));
    } on http.ClientException catch (e) {
      return left(AppFailure('Failed to delete idea: ${e.message}'));
    }
  }
}
