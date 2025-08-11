import 'package:startup_idea_evaluator/features/idea/models/idea_model.dart';

List<IdeaModel> sortIdeas(List<IdeaModel> ideas) {
  ideas.sort((a, b) => b.rating.compareTo(a.rating));
  final topIdeas = ideas.take(5).toList();
  return topIdeas;
}
