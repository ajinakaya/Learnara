import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnara/features/Activitytype/domain/entity/quiz/quiz_entity.dart';
import 'package:learnara/features/Activitytype/presentation/view/quiz_detail_page.dart';
import 'package:learnara/features/Activitytype/presentation/view_model/activity/activity_bloc.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz ',
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600
          ),
        ),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: BlocBuilder<ActivityBloc, ActivityState>(
        builder: (context, state) {
          if (state.quizzesStatus == ActivityStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.quizzesStatus == ActivityStatus.error) {
            return Center(
              child: Text(
                'Error loading quizzes: ${state.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state.quizzes.isEmpty) {
            return const Center(
              child: Text('No quizzes available'),
            );
          }

          return ListView.builder(
            itemCount: state.quizzes.length,
            itemBuilder: (context, index) {
              QuizEntity quiz = state.quizzes[index];
              return _buildQuizCard(quiz, context);
            },
          );
        },
      ),
    );
  }

  Widget _buildQuizCard(QuizEntity quiz, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          quiz.title ?? 'Untitled Quiz',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          quiz.description ?? 'No description',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black54),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizDetailPage(quiz: quiz),
            ),
          );
        },
      ),
    );
  }
}
