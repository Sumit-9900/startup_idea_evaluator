import 'dart:math';

double aiGenerateRating() {
  final random = Random();
  final aiRating = random.nextDouble() * 100;

  return aiRating;
}
