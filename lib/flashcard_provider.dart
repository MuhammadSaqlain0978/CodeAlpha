import 'package:flutter/material.dart';
import 'flashcard.dart';

class FlashcardProvider with ChangeNotifier {
  List<Flashcard> _flashcards = [];

  List<Flashcard> get flashcards => _flashcards;

  void addFlashcard(Flashcard flashcard) {
    _flashcards.add(flashcard);
    notifyListeners();
  }
}
