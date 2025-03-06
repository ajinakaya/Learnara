import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnara/features/Activitytype/domain/entity/flashcard/flashcard_entity.dart';
import 'package:learnara/features/Activitytype/presentation/view_model/activity/activity_bloc.dart';
import 'package:learnara/features/courses/presentation/view/coursepagedetails.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocBuilder<ActivityBloc, ActivityState>(
        builder: (context, state) {
          if (state.flashcardsStatus == ActivityStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.flashcardsStatus == ActivityStatus.error) {
            return Center(
              child: Text(
                'Error loading flashcards: ${state.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state.flashcards.isEmpty) {
            return const Center(child: Text('No flashcards available'));
          }

          return ListView.builder(
            itemCount: state.flashcards.length,
            itemBuilder: (context, index) {
              FlashcardEntity flashcard = state.flashcards[index];
              return _buildFlashcardTile(flashcard, context);
            },
          );
        },
      ),
    );
  }

  Widget _buildFlashcardTile(FlashcardEntity flashcard, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          flashcard.title ?? 'Untitled Flashcard',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          flashcard.description ?? 'No description',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black54),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FlashcardDetailPage(flashcard: flashcard),
            ),
          );
        },
      ),
    );
  }
}
