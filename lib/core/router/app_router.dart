import 'package:go_router/go_router.dart';
import 'package:startup_idea_evaluator/core/router/route_constants.dart';
import 'package:startup_idea_evaluator/features/idea/models/idea_model.dart';
import 'package:startup_idea_evaluator/features/idea/view/pages/idea_list_page.dart';
import 'package:startup_idea_evaluator/features/idea/view/pages/idea_submission_page.dart';
import 'package:startup_idea_evaluator/features/leaderboard/view/pages/leaderboard_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: RouteConstants.ideaSubmissionRoute,
        builder: (context, state) => const IdeaSubmissionPage(),
      ),
      GoRoute(
        path: '/idea-list',
        name: RouteConstants.ideaListRoute,
        builder: (context, state) => const IdeaListPage(),
      ),
      GoRoute(
        path: '/leaderboard',
        name: RouteConstants.leaderboardRoute,
        builder: (context, state) {
          final ideas = state.extra as List<IdeaModel>;
          return LeaderboardPage(ideas: ideas);
        },
      ),
    ],
  );
}
