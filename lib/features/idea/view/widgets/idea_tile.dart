import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:startup_idea_evaluator/core/utils/show_toast.dart';
import 'package:startup_idea_evaluator/features/idea/models/idea_model.dart';
import 'package:startup_idea_evaluator/features/idea/repository/idea_local_repository.dart';
import 'package:startup_idea_evaluator/features/idea/viewmodel/idea_provider.dart';
import 'package:startup_idea_evaluator/init_dependencies.dart';

class IdeaTile extends StatelessWidget {
  final IdeaModel idea;
  const IdeaTile({super.key, required this.idea});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(idea.id),
      direction: DismissDirection.startToEnd,
      movementDuration: const Duration(milliseconds: 500),
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        context.read<IdeaProvider>().deleteIdea(idea.id);
        showToast(message: 'Idea deleted', backgroundColor: Colors.red);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 5,
        shadowColor: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Title + Actions
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      idea.name,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.thumb_up),
                    color: getIt<IdeaLocalRepository>().isVoted(idea.id)
                        ? Colors.blue
                        : Colors.grey,
                    onPressed: () {
                      context.read<IdeaProvider>().voteIdea(
                        idea.id,
                        idea.votes,
                      );
                    },
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'share') {
                        SharePlus.instance.share(
                          ShareParams(
                            text:
                                'Name: ${idea.name}\nTagline: ${idea.tagline}\nDescription: ${idea.description}',

                            subject: idea.name,
                          ),
                        );
                      } else if (value == 'copy') {
                        Clipboard.setData(
                          ClipboardData(
                            text:
                                'Name: ${idea.name}\nTagline: ${idea.tagline}\nDescription: ${idea.description}',
                          ),
                        );
                        showToast(
                          message: 'Idea copied to clipboard',
                          backgroundColor: Colors.green,
                        );
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'share',
                        child: Row(
                          children: [
                            Icon(Icons.share, color: Colors.black54),
                            SizedBox(width: 8),
                            Text('Share'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'copy',
                        child: Row(
                          children: [
                            Icon(Icons.copy, color: Colors.black54),
                            SizedBox(width: 8),
                            Text('Copy to Clipboard'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Tagline
              Text(
                idea.tagline,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[700],
                ),
              ),

              const SizedBox(height: 16),

              // Rating & Votes Row
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    idea.rating.toStringAsFixed(1),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.people, color: Colors.grey, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    idea.votes.toString(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Description with Read More / Less
              Selector<IdeaProvider, bool>(
                selector: (context, ideaProvider) =>
                    ideaProvider.isExpanded(idea.id),
                builder: (context, isExpanded, child) {
                  final displayText = isExpanded
                      ? idea.description
                      : (idea.description.length > 100
                            ? idea.description.substring(0, 100)
                            : idea.description);

                  return RichText(
                    text: TextSpan(
                      text: displayText,
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        if (idea.description.length > 100)
                          TextSpan(
                            text: isExpanded
                                ? '... Read less'
                                : '... Read more',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.read<IdeaProvider>().toggleExpanded(
                                  idea.id,
                                );
                              },
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
