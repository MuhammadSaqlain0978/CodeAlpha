import 'package:flutter/material.dart';
import 'flashcard_provider.dart';
import 'flashcard.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FlashcardProvider(),
      child: MaterialApp(
        title: 'Flashcard Quiz App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FlashcardListScreen(),
      ),
    );
  }
}

class FlashcardListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcards'),
      ),
      body: FlashcardList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFlashcardScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class FlashcardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
          itemCount: provider.flashcards.length,
          itemBuilder: (context, index) {
            final flashcard = provider.flashcards[index];
            return ListTile(
              title: Text(flashcard.question),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(flashcard: flashcard),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class AddFlashcardScreen extends StatelessWidget {
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Flashcard'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Question'),
            ),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(labelText: 'Answer'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final question = _questionController.text;
                final answer = _answerController.text;

                if (question.isNotEmpty && answer.isNotEmpty) {
                  final flashcard =
                      Flashcard(question: question, answer: answer);
                  Provider.of<FlashcardProvider>(context, listen: false)
                      .addFlashcard(flashcard);
                  Navigator.pop(context);
                }
              },
              child: Text('Add Flashcard'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatelessWidget {
  final Flashcard flashcard;

  QuizScreen({required this.flashcard});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              flashcard.question,
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(flashcard.answer),
                  ),
                );
              },
              child: Text('Show Answer'),
            ),
          ],
        ),
      ),
    );
  }
}
