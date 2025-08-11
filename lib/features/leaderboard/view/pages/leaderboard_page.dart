import 'package:flutter/material.dart';
import 'package:startup_idea_evaluator/core/utils/sort_ideas.dart';
import 'package:startup_idea_evaluator/features/idea/models/idea_model.dart';
import 'package:startup_idea_evaluator/features/leaderboard/view/widgets/leaderboard_tile.dart';

class LeaderboardPage extends StatelessWidget {
  final List<IdeaModel> ideas;
  const LeaderboardPage({super.key, required this.ideas});

  @override
  Widget build(BuildContext context) {
    final sortedIdeas = sortIdeas(ideas);
    return Scaffold(
      appBar: AppBar(title: Text('🚀 Top Innovations')),
      body: sortedIdeas.isEmpty
          ? Center(
              child: Text(
                'No startup ideas ranked yet!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.separated(
                itemCount: sortedIdeas.length,
                separatorBuilder: (context, index) => SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final idea = sortedIdeas[index];
                  return LeaderboardTile(idea: idea, index: index);
                },
              ),
            ),
    );
  }
}
