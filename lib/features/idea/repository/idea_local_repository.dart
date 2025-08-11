import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup_idea_evaluator/core/constants/app_constants.dart';

abstract interface class IdeaLocalRepository {
  Set<String> getVotedIdeas();
  Future<void> addVote(String ideaId);
  Future<void> removeVote(String ideaId);
  bool isVoted(String ideaId);
  Future<void> setTheme(bool isDarkMode);
  bool getTheme();
}

class IdeaLocalRepositoryImpl implements IdeaLocalRepository {
  final SharedPreferences prefs;
  IdeaLocalRepositoryImpl(this.prefs);

  @override
  Set<String> getVotedIdeas() {
    final votedIdeas = prefs.getStringList(AppConstants.votedIdeasKey) ?? [];
    return Set.from(votedIdeas);
  }

  @override
  Future<void> addVote(String ideaId) async {
    try {
      final votedIdeas = getVotedIdeas();
      votedIdeas.add(ideaId);
      await prefs.setStringList(
        AppConstants.votedIdeasKey,
        votedIdeas.toList(),
      );
    } catch (e) {
      throw 'Failed to add vote: ${e.toString()}';
    }
  }

  @override
  Future<void> removeVote(String ideaId) async {
    try {
      final votedIdeas = getVotedIdeas();
      votedIdeas.remove(ideaId);
      await prefs.setStringList(
        AppConstants.votedIdeasKey,
        votedIdeas.toList(),
      );
    } catch (e) {
      throw 'Failed to remove vote: ${e.toString()}';
    }
  }

  @override
  bool isVoted(String ideaId) {
    final votedIdeas = getVotedIdeas();
    return votedIdeas.contains(ideaId);
  }

  @override
  bool getTheme() {
    return prefs.getBool(AppConstants.themeKey) ?? false;
  }

  @override
  Future<void> setTheme(bool isDarkMode) async {
    try {
      await prefs.setBool(AppConstants.themeKey, isDarkMode);
    } catch (e) {
      throw 'Failed to set theme: ${e.toString()}';
    }
  }
}
