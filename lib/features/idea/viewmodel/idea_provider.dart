import 'package:flutter/material.dart';
import 'package:startup_idea_evaluator/features/idea/models/idea_model.dart';
import 'package:startup_idea_evaluator/features/idea/repository/idea_remote_repository.dart';

class IdeaProvider extends ChangeNotifier {
  final IdeaRemoteRepository _ideaRemoteRepository;

  List<IdeaModel> _ideas = [];
  bool _isLoading = false;
  String? _errorMessage;
  final Map<String, bool> _expandedStates = {};

  List<IdeaModel> get ideas => _ideas;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  IdeaProvider({required IdeaRemoteRepository ideaRemoteRepository})
    : _ideaRemoteRepository = ideaRemoteRepository,
      super();

  bool isExpanded(String ideaId) => _expandedStates[ideaId] ?? false;

  void toggleExpanded(String ideaId) {
    _expandedStates[ideaId] = !(isExpanded(ideaId));
    notifyListeners();
  }

  Future<void> submitIdea(IdeaModel idea) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final res = await _ideaRemoteRepository.submitIdea(idea);

    res.fold((failure) {
      _errorMessage = failure.message;
      notifyListeners();
    }, (r) => {getIdeas()});

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getIdeas() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final res = await _ideaRemoteRepository.getIdeas();

    res.fold(
      (failure) {
        _errorMessage = failure.message;
        notifyListeners();
      },
      (ideas) {
        _ideas = ideas;
        notifyListeners();
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteIdea(String ideaId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final res = await _ideaRemoteRepository.deleteIdea(ideaId);

    res.fold(
      (failure) {
        _errorMessage = failure.message;
        notifyListeners();
      },
      (r) {
        getIdeas();
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  void sortIdeasByRating() {
    _ideas.sort((a, b) => b.rating.compareTo(a.rating));
    notifyListeners();
  }

  void sortIdeasByVotes() {
    _ideas.sort((a, b) => b.votes.compareTo(a.votes));
    notifyListeners();
  }

  Future<void> voteIdea(String ideaId, int currentVotes) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final res = await _ideaRemoteRepository.voteIdea(ideaId, currentVotes);

    res.fold(
      (failure) {
        _errorMessage = failure.message;
        notifyListeners();
      },
      (r) {
        getIdeas();
      },
    );

    _isLoading = false;
    notifyListeners();
  }
}
