import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnara/app/constants/api_endpoint.dart';
import 'package:learnara/features/Activitytype/presentation/view/audio.dart';
import 'package:learnara/features/Activitytype/presentation/view/flashcard.dart';
import 'package:learnara/features/Activitytype/presentation/view/quiz.dart';
import 'package:learnara/features/Activitytype/presentation/view_model/activity/activity_bloc.dart';
import 'package:learnara/features/courses/presentation/view/course_screen.dart';
import 'package:learnara/features/goals/presentation/view/goal.dart';
import 'package:learnara/features/langauge/presentation/view_model/language/language_bloc.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';
import 'package:learnara/features/langauge/domain/entity/user_language_entity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sensors_plus/sensors_plus.dart';



class Course {
  final int id;
  final String title;
  final List<String> level;
  final String description;
  final String thumbnail;

  Course({
    required this.id,
    required this.title,
    required this.level,
    required this.description,
    required this.thumbnail,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Untitled Course',
      level: (json['level'] as List?)?.map((e) => e.toString()).toList() ??
          ['N/A'],
      description: json['description'] ?? 'No description available',
      thumbnail: json['thumbnail'] ?? 'assets/images/japan img.jpeg',
    );
  }
}

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  PreferredLanguageEntity? _selectedLanguage;
  List<Course> _courses = [];
  bool _isLoading = false;
  String _errorMessage = '';
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  AccelerometerEvent? _lastEvent;
  static const double shakeThreshold = 15.0;

  @override
  void initState() {
    super.initState();
    context.read<LanguageBloc>().add(LoadLanguages());
    _startShakeListener();
  }

  Future<void> _fetchCourses(String languageId) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final baseUrl = ApiEndpoints.baseUrl.replaceAll(RegExp(r'/+$'), '');
      final url = Uri.parse('$baseUrl/course/course?languageId=$languageId');

      print('Fetching Courses URL: $url');
      print('Language ID: $languageId');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> courseData = json.decode(response.body);
        setState(() {
          _courses =
              courseData.map((course) => Course.fromJson(course)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load courses: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: ${e.toString()}';
        _isLoading = false;
      });
      print('Course Fetch Error: $e');
    }
  }

  void _startShakeListener() {
    _accelerometerSubscription = accelerometerEventStream().listen((event) {
      if (_lastEvent != null) {
        double deltaX = event.x - _lastEvent!.x;
        double deltaY = event.y - _lastEvent!.y;
        double deltaZ = event.z - _lastEvent!.z;

        double acceleration =
        sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ);

        if (acceleration > shakeThreshold) {
          _onShakeDetected();
        }
      }
      _lastEvent = event;
    });
  }

  void _onShakeDetected() {
    // Handle the shake event here
    print('Shake detected!');

    // Example: Refresh courses when phone is shaken
    if (_selectedLanguage != null) {
      _fetchCourses(_selectedLanguage!.languageId.toString());

      // Show a quick feedback to user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Refreshing courses...'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 50,
              width: 60,
            ),
            const SizedBox(width: 8),
            BlocConsumer<LanguageBloc, LanguageState>(
              listener: (context, state) {
                if (state.languages.isNotEmpty) {
                  final availableLanguages = state.languages;
                  final selectedLanguage = state.userLanguagePreference != null
                      ? availableLanguages.firstWhere(
                          (lang) =>
                              lang.languageName ==
                              state.userLanguagePreference!.languageName,
                          orElse: () => availableLanguages.first,
                        )
                      : availableLanguages.first;

                  if (_courses.isEmpty) {
                    _fetchCourses(selectedLanguage.languageId.toString());
                  }
                }
              },
              builder: (context, state) {
                // This is purely for building the UI
                if (state.languages.isEmpty) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 1, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Loading Languages...'),
                  );
                }

                final availableLanguages = state.languages;
                _selectedLanguage = state.userLanguagePreference != null
                    ? availableLanguages.firstWhere(
                        (lang) =>
                            lang.languageName ==
                            state.userLanguagePreference!.languageName,
                        orElse: () => availableLanguages.first,
                      )
                    : availableLanguages.first;

                return _buildLanguageDropdown(context, availableLanguages);
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.track_changes, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => GoalScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_sharp, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => GoalScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: _selectedLanguage != null
                      ? Image.network(
                          '${ApiEndpoints.baseUrl}${_selectedLanguage?.languageImage ?? ''}',
                          width: 24,
                          height: 16,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            'assets/images/default_flag.png',
                            width: 24,
                            height: 16,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(width: 8),
                Text(
                  '${_selectedLanguage?.languageName ?? "Japanese"} Courses',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildDailyPracticeSection(context),
            const SizedBox(height: 30),
            const Text(
              'All Courses',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage.isNotEmpty
                      ? Center(
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      : _courses.isEmpty
                          ? const Center(
                              child: Text(
                                  'No courses available for this language'),
                            )
                          : ListView.builder(
                              itemCount: _courses.length,
                              itemBuilder: (context, index) {
                                final course = _courses[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: _buildCourseCard(
                                    course.title,
                                    course.level.join('-'),
                                    course.description,
                                    'assets/images/japan img1.jpeg',
                                  ),
                                );
                              },
                            ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown(
      BuildContext context, List<PreferredLanguageEntity> availableLanguages) {
    return Container(
      width: 120,
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<PreferredLanguageEntity>(
          value: _selectedLanguage,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          items: availableLanguages.map((language) {
            return DropdownMenuItem<PreferredLanguageEntity>(
              value: language,
              child: Row(
                children: [
                  Image.network(
                    '${ApiEndpoints.baseUrl}${language.languageImage}',
                    width: 16,
                    height: 12,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                        'assets/images/default_flag.png',
                        width: 16,
                        height: 12),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    language.languageName,
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (newLanguage) {
            if (newLanguage != null) {
              context
                  .read<LanguageBloc>()
                  .add(SetUserLanguage(UserLanguagePreferenceEntity(
                    id: newLanguage.languageId,
                    userId: context
                            .read<LanguageBloc>()
                            .state
                            .userLanguagePreference
                            ?.userId ??
                        'default_user',
                    languageName: newLanguage.languageName,
                    languageImage: newLanguage.languageImage,
                  )));

              _fetchCourses(newLanguage.languageId.toString());
            }
          },
        ),
      ),
    );
  }

  Widget _buildDailyPracticeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Daily Practice',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildPracticeCard(
                context: context,
                title: 'Audio Learning',
                points: '40',
                duration: '4 Mins 20 min',
                color: const Color(0xFFFFF3E9),
                imagePath: 'assets/images/Headphone.png',
                activityType: ActivityType.audio,
              ),
              const SizedBox(width: 12),
              _buildPracticeCard(
                context: context,
                title: 'Flashcard',
                points: '25',
                duration: '3 Mins 20 min',
                color: const Color(0xFFE9FFF3),
                imagePath: 'assets/images/flashcard1.png',
                activityType: ActivityType.flashcard,
              ),
              const SizedBox(width: 12),
              _buildPracticeCard(
                context: context,
                title: 'Quiz',
                points: '30',
                duration: '5 Mins 20 min',
                color: const Color(0xFFE5F3FF),
                imagePath: 'assets/images/quiz1.png',
                activityType: ActivityType.quiz,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPracticeCard({
    required BuildContext context,
    required String title,
    required String points,
    required String duration,
    required Color color,
    required String imagePath,
    required ActivityType activityType,
  }) {
    return GestureDetector(
      onTap: () {
        switch (activityType) {
          case ActivityType.audio:
            context.read<ActivityBloc>().add(FetchAudioActivitiesEvent());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AudioLearningPage(),
              ),
            );
            break;
          case ActivityType.quiz:
            context.read<ActivityBloc>().add(FetchQuizzesEvent());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QuizPage(),
              ),
            );
            break;
          case ActivityType.flashcard:
            context.read<ActivityBloc>().add(FetchFlashcardsEvent());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FlashcardPage(),
              ),
            );
            break;
        }
      },
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 16,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$points Points',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    duration,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Image.asset(
                imagePath,
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(
      String title, String level, String description, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: Image.asset(
                  imagePath,
                  width: 120,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 120,
                    height: 150,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/Japan Flag.jpeg',
                            width: 25,
                            height: 15,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            level,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            // Fetch Flashcards and Navigate to Flashcard Page
                            context.read<ActivityBloc>().add(FetchFlashcardsEvent());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CourseScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                          ),
                          child: const Text(
                            'Start Course',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ],
      ),
    );
  }
}

// Enum to define activity types
enum ActivityType { audio, quiz, flashcard }
