import 'package:flutter/material.dart';
import 'package:learnara/features/Activitytype/domain/entity/quiz/quiz_entity.dart';

class QuizDetailPage extends StatefulWidget {
  final QuizEntity quiz;

  const QuizDetailPage({super.key, required this.quiz});

  @override
  _QuizDetailPageState createState() => _QuizDetailPageState();
}

class _QuizDetailPageState extends State<QuizDetailPage> {
  int currentQuestionIndex = 0;
  String selectedAnswer = '';
  bool isAnswerCorrect = false;

  @override
  Widget build(BuildContext context) {
    final quiz = widget.quiz;
    final question = quiz.questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz Details',
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600
          ),
        ),
        backgroundColor: Colors.blueGrey,
        elevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Container(
        color: Colors.grey[50],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quiz.title ?? 'Untitled Quiz',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Question ${currentQuestionIndex + 1}: ${question.question}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ...question.options.map((option) {
                return _buildAnswerOption(option);
              }).toList(),
              const SizedBox(height: 20),
              if (selectedAnswer.isNotEmpty)
                Center(child: _buildAnswerFeedback()),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    currentQuestionIndex < widget.quiz.questions.length - 1
                        ? 'Next Question'
                        : 'Finish Quiz',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerOption(String option) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
            color: selectedAnswer == option
                ? Colors.black87
                : Colors.grey[300]!,
            width: 1
        ),
      ),
      child: ListTile(
        title: Text(
          option,
          style: TextStyle(
            color: selectedAnswer == option
                ? Colors.white
                : Colors.black87,
          ),
        ),
        leading: Radio<String>(
          activeColor: Colors.black87,
          value: option,
          groupValue: selectedAnswer,
          onChanged: (value) {
            setState(() {
              selectedAnswer = value!;
              isAnswerCorrect = value == widget.quiz.questions[currentQuestionIndex].correctAnswer;
            });
          },
        ),
        tileColor: selectedAnswer == option
            ? Colors.blueGrey
            : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildAnswerFeedback() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isAnswerCorrect ? Colors.green[50] : Colors.red[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isAnswerCorrect ? Colors.green[200]! : Colors.red[200]!,
        ),
      ),
      child: Text(
        isAnswerCorrect ? 'Correct!' : 'Incorrect, try again.',
        style: TextStyle(
          fontSize: 16,
          color: isAnswerCorrect ? Colors.green[800] : Colors.red[800],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _nextQuestion() {
    if (currentQuestionIndex < widget.quiz.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = '';
      });
    } else {
      // Show a modal for quiz completion
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Quiz Completed'),
          content: const Text('Congratulations! You have finished the quiz.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }
}