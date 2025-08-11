import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:startup_idea_evaluator/core/router/app_router.dart';
import 'package:startup_idea_evaluator/core/theme/app_theme.dart';
import 'package:startup_idea_evaluator/features/idea/viewmodel/idea_provider.dart';
import 'package:startup_idea_evaluator/features/idea/viewmodel/theme_provider.dart';
import 'package:startup_idea_evaluator/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await initDependencies();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<IdeaProvider>()..getIdeas(),
        ),
        ChangeNotifierProvider(create: (_) => getIt<ThemeProvider>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context.watch<ThemeProvider>().themeMode,
      routerConfig: AppRouter.router,
    );
  }
}
