import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup_idea_evaluator/features/idea/repository/idea_local_repository.dart';
import 'package:startup_idea_evaluator/features/idea/repository/idea_remote_repository.dart';
import 'package:http/http.dart' as http;
import 'package:startup_idea_evaluator/features/idea/viewmodel/idea_provider.dart';
import 'package:startup_idea_evaluator/features/idea/viewmodel/theme_provider.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  final httpClient = http.Client();
  getIt.registerLazySingleton(() => httpClient);

  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => prefs);

  // Repository
  getIt.registerFactory<IdeaLocalRepository>(
    () => IdeaLocalRepositoryImpl(getIt<SharedPreferences>()),
  );

  getIt.registerFactory<IdeaRemoteRepository>(
    () => IdeaRemoteRepositoryImpl(client: getIt(), localRepository: getIt()),
  );

  // Provider
  getIt.registerLazySingleton(
    () => IdeaProvider(ideaRemoteRepository: getIt()),
  );

  getIt.registerLazySingleton(() => ThemeProvider(getIt()));
}
