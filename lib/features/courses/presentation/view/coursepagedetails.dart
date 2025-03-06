import 'package:flutter/material.dart';
import 'package:learnara/features/Activitytype/domain/entity/flashcard/flashcard_entity.dart';

class FlashcardDetailPage extends StatefulWidget {
  final FlashcardEntity flashcard;

  const FlashcardDetailPage({super.key, required this.flashcard});

  @override
  _FlashcardDetailPageState createState() => _FlashcardDetailPageState();
}

class _FlashcardDetailPageState extends State<FlashcardDetailPage> {
  bool _isFlipped = false;

  void _toggleCard() {
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.flashcard.cards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.flashcard.title ?? 'Flashcard')),
        body: const Center(child: Text('No card data available')),
      );
    }

    final card = widget.flashcard.cards[0]; // Get the first card

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.flashcard.title ?? 'Flashcard'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: GestureDetector(
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
              backText: card.back,
              hint: card.hint ?? 'No hint available',
              example: card.example ?? 'No example available',
            )
                : _FrontOfCard(frontText: card.front),
          ),
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
      height: 250,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        frontText,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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
    required this.example,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('back'),
      height: 250,
      width: 350,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            backText,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text('Hint: $hint', style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
          const SizedBox(height: 8),
          Text('Example: $example', style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}
