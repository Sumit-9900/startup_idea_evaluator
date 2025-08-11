import 'package:flutter/material.dart';

class LeaderboardBadge extends StatelessWidget {
  final int index;
  const LeaderboardBadge({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color color;

    switch (index) {
      case 0:
        iconData = Icons.emoji_events;
        color = Colors.amber;
        break;
      case 1:
        iconData = Icons.emoji_events;
        color = Colors.grey;
        break;
      case 2:
        iconData = Icons.emoji_events;
        color = Colors.brown;
        break;
      default:
        iconData = Icons.workspace_premium;
        color = Colors.deepPurple.shade300;
    }

    return Icon(iconData, color: color, size: 30);
  }
}
