import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:startup_idea_evaluator/core/router/route_constants.dart';
import 'package:startup_idea_evaluator/core/utils/ai_generate_rating.dart';
import 'package:startup_idea_evaluator/core/utils/show_toast.dart';
import 'package:startup_idea_evaluator/core/widgets/loader.dart';
import 'package:startup_idea_evaluator/features/idea/models/idea_model.dart';
import 'package:startup_idea_evaluator/features/idea/view/widgets/input_field.dart';
import 'package:startup_idea_evaluator/features/idea/viewmodel/idea_provider.dart';
import 'package:startup_idea_evaluator/features/idea/viewmodel/theme_provider.dart';
import 'package:uuid/uuid.dart';

class IdeaSubmissionPage extends StatefulWidget {
  const IdeaSubmissionPage({super.key});

  @override
  State<IdeaSubmissionPage> createState() => _IdeaSubmissionPageState();
}

class _IdeaSubmissionPageState extends State<IdeaSubmissionPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController taglineController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode taglineFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  @override
  void dispose() {
    nameController.dispose();
    taglineController.dispose();
    descriptionController.dispose();
    nameFocusNode.dispose();
    taglineFocusNode.dispose();
    descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Startup Idea'),
        actions: [
          Selector<ThemeProvider, ThemeMode>(
            selector: (_, themeProvider) => themeProvider.themeMode,
            builder: (context, themeMode, child) {
              return IconButton(
                onPressed: () {
                  context.read<ThemeProvider>().toggleTheme();
                },
                icon: Icon(
                  themeMode == ThemeMode.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  color: themeMode == ThemeMode.dark
                      ? Colors.amber
                      : Colors.black,
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              context.pushNamed(RouteConstants.ideaListRoute);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<IdeaProvider>(
          builder: (context, ideaProvider, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!ideaProvider.isLoading &&
                  ideaProvider.errorMessage == null &&
                  formKey.currentState != null &&
                  nameController.text.isNotEmpty) {
                showToast(
                  message: 'Startup Idea submitted successfully!',
                  backgroundColor: Colors.green,
                );
                nameController.clear();
                taglineController.clear();
                descriptionController.clear();
                context.pushNamed(RouteConstants.ideaListRoute);
              } else if (ideaProvider.errorMessage != null) {
                showToast(
                  message: ideaProvider.errorMessage!,
                  backgroundColor: Colors.red,
                );
              }
            });

            return Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InputField(
                      controller: nameController,
                      focusNode: nameFocusNode,
                      hintText: 'Startup Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a startup name!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      controller: taglineController,
                      focusNode: taglineFocusNode,
                      hintText: 'Tagline (e.g. Revolutionizing Healthcare)',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a tagline!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      controller: descriptionController,
                      focusNode: descriptionFocusNode,
                      hintText: 'Brief description of your startup idea...',
                      maxLines: 6,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: ideaProvider.isLoading
                          ? null
                          : () async {
                              if (formKey.currentState!.validate()) {
                                final uuid = const Uuid().v4();
                                final rating = aiGenerateRating();

                                final idea = IdeaModel(
                                  id: uuid,
                                  name: nameController.text.trim(),
                                  tagline: taglineController.text.trim(),
                                  description: descriptionController.text
                                      .trim(),
                                  rating: rating,
                                );
                                context.read<IdeaProvider>().submitIdea(idea);
                              }
                            },
                      child: ideaProvider.isLoading
                          ? const Loader()
                          : const Text(
                              'Submit Idea',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
