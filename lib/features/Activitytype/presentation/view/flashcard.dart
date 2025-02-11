import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnara/features/Activitytype/domain/entity/flashcard/flashcard_entity.dart';
import 'package:learnara/features/Activitytype/presentation/view_model/activity/activity_bloc.dart';

class FlashcardPage extends StatefulWidget {
  const FlashcardPage({super.key});

  @override
  _FlashcardPageState createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcard ',
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600
          ),),
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
            return const Center(
              child: Text('No flashcards available'),
            );
          }

          return ListView.builder(
            itemCount: state.flashcards.length,
            itemBuilder: (context, index) {
              FlashcardEntity flashcard = state.flashcards[index];
              return FlashcardWidget(flashcard: flashcard);
            },
          );
        },
      ),
    );
  }
}

class FlashcardWidget extends StatefulWidget {
  final FlashcardEntity flashcard;

  const FlashcardWidget({
    super.key,
    required this.flashcard
  });

  @override
  _FlashcardWidgetState createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget> {
  bool _isFlipped = false;
  int _currentCardIndex = 0;

  void _toggleCard() {
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  void _nextCard() {
    setState(() {
      _currentCardIndex = (_currentCardIndex + 1) % widget.flashcard.cards.length;
      _isFlipped = false;
    });
  }

  void _previousCard() {
    setState(() {
      _currentCardIndex = (_currentCardIndex - 1 + widget.flashcard.cards.length)
          % widget.flashcard.cards.length;
      _isFlipped = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Ensure cards is not null and has elements
    if (widget.flashcard.cards == null || widget.flashcard.cards.isEmpty) {
      return const Card(
        child: Center(child: Text('No cards available')),
      );
    }

    final currentCard = widget.flashcard.cards[_currentCardIndex];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.flashcard.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _toggleCard,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return RotationTransition(
                    turns: animation,
                    child: child,
                  );
                },
                child: _isFlipped
                    ? _BackOfCard(
                    backText: currentCard.back ?? 'No back text',
                    hint: currentCard.hint ?? 'No hint available',
                    example: currentCard.example ?? 'No example available'
                )
                    : _FrontOfCard(frontText: currentCard.front ?? 'No front text'),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: _previousCard,
                ),
                Text(
                  'Card ${_currentCardIndex + 1}/${widget.flashcard.cards.length}',
                  style: const TextStyle(color: Colors.grey),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: _nextCard,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FrontOfCard extends StatelessWidget {
  final String frontText;

  const _FrontOfCard({required this.frontText});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('front'),
      height: 200,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        frontText,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _BackOfCard extends StatelessWidget {
  final String backText;
  final String hint;
  final String example;

  const _BackOfCard({
    required this.backText,
    required this.hint,
    required this.example
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('back'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            backText,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Hint:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          Text(
            hint,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 16),
          const Text(
            'Example:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          Text(
            example,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}