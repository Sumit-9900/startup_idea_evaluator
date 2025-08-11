import 'package:flutter/material.dart';
import 'package:startup_idea_evaluator/features/idea/models/idea_model.dart';
import 'package:startup_idea_evaluator/features/leaderboard/view/widgets/leaderboard_badge.dart';

class LeaderboardTile extends StatelessWidget {
  final IdeaModel idea;
  final int index;
  const LeaderboardTile({super.key, required this.idea, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: LeaderboardBadge(index: index),
        title: Text(
          idea.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          idea.tagline,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text(
              idea.rating.toStringAsFixed(1),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
