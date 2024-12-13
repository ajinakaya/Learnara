import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int _currentPage = 0;

  final List<Map<String , String>>_OnboardingData =[
    {
      "title": "Learn a new language",
      "subtitle": "Discover the joy of learning with interactive lessons and practice.",
      "image": "assets/images/onboarding1.jpg",
    },
    {
      "title": "Track your progress",
      "subtitle": "Keep an eye on your achievements and reach your goals faster.",
      "image": "assets/images/progress1.jpg",
    },
    {
      "title": "Select a language",
      "subtitle": "Choose your preferred language and begin your journey.",
      "image": "assets/images/onboarding.jpg",
    },
  ];

  void _nextPage(){
    if (_currentPage < _OnboardingData.length-1){
      setState(() {
        _currentPage++;
      });
    }else{
      Navigator.of(context).pushNamed("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _OnboardingData[_currentPage];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              data["title"]!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            // Subtitle
            Text(
              data["subtitle"]!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
            Image.asset(
              data["image"]!,
              height: 300,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:List.generate(
                _OnboardingData.length,
                    (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height:55),
            ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16,horizontal:32),
                  backgroundColor: Colors.black.withOpacity(0.75),
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: Size(double.infinity,20),
                ),
                child: Text(
                  _currentPage < _OnboardingData.length -1 ? "Next": "Get Started",
                  style: TextStyle(fontSize: 18,color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
