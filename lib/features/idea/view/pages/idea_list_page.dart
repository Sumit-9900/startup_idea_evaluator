import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:startup_idea_evaluator/core/router/route_constants.dart';
import 'package:startup_idea_evaluator/core/widgets/loader.dart';
import 'package:startup_idea_evaluator/features/idea/view/widgets/idea_tile.dart';
import 'package:startup_idea_evaluator/features/idea/viewmodel/idea_provider.dart';

class IdeaListPage extends StatelessWidget {
  const IdeaListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🚀 Startup Ideas'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              // Handle sorting logic here
              if (result == 'rating') {
                context.read<IdeaProvider>().sortIdeasByRating();
              } else if (result == 'votes') {
                context.read<IdeaProvider>().sortIdeasByVotes();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'rating',
                child: Text('Sort by Rating'),
              ),
              const PopupMenuItem<String>(
                value: 'votes',
                child: Text('Sort by Votes'),
              ),
            ],
            icon: const Icon(Icons.sort),
          ),
          IconButton(
            onPressed: () {
              context.pushNamed(
                RouteConstants.leaderboardRoute,
                extra: context.read<IdeaProvider>().ideas,
              );
            },
            icon: Icon(Icons.leaderboard),
          ),
        ],
      ),
      body: Consumer<IdeaProvider>(
        builder: (context, ideaProvider, child) {
          if (ideaProvider.isLoading) {
            return const Center(child: Loader());
          }

          final ideas = ideaProvider.ideas;
          if (ideas.isEmpty) {
            return const Center(
              child: Text(
                'No ideas found!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }

          return Scrollbar(
            thumbVisibility: true,
            interactive: true,
            thickness: 12,
            radius: const Radius.circular(12),
            child: RefreshIndicator(
              color: Color(0xFF0A66C2),
              backgroundColor: Colors.white,
              onRefresh: () async {
                context.read<IdeaProvider>().getIdeas();
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: ideas.length,
                  itemBuilder: (context, index) {
                    final idea = ideas[index];

                    return IdeaTile(idea: idea);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
