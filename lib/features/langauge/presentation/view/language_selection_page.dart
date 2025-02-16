import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnara/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:learnara/features/langauge/domain/entity/user_language_entity.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';
import 'package:learnara/features/langauge/presentation/view_model/language/language_bloc.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  PreferredLanguageEntity? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    // Trigger loading of languages
    context.read<LanguageBloc>().add(LoadLanguages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: BlocConsumer<LanguageBloc, LanguageState>(
        listener: (context, state) {
          // Handle any errors
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!)),
            );
          }
        },
        builder: (context, state) {
          // Show loading indicator while fetching languages
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Show error if languages couldn't be loaded
          if (state.languages.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No languages available'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LanguageBloc>().add(LoadLanguages());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Display list of languages
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Choose Your Language',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.languages.length,
                  itemBuilder: (context, index) {
                    final language = state.languages[index];
                    return _buildLanguageListItem(context, language, state);
                  },
                ),
              ),
              // Continue Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _selectedLanguage != null
                      ? () {
                    // Dispatch event to set user's preferred language
                    context.read<LanguageBloc>().add(SetUserLanguage(
                      UserLanguagePreferenceEntity(
                        id: '',
                        userId: '',
                        languageName: _selectedLanguage!.languageName,
                        languageImage: _selectedLanguage!.languageImage,
                      ),
                    ));

                    // Navigate to Dashboard
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const DashboardView(),
                      ),
                    );
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: _selectedLanguage != null ? Colors.black : Colors.grey,
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLanguageListItem(
      BuildContext context,
      PreferredLanguageEntity language,
      LanguageState state
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedLanguage = language;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: _selectedLanguage == language
                ? Colors.black.withOpacity(0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _selectedLanguage == language
                  ? Colors.black
                  : Colors.grey.shade300,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Language Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    language.languageImage,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.language),
                        ),
                  ),
                ),
                const SizedBox(width: 16),
                // Language Name
                Expanded(
                  child: Text(
                    language.languageName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Selection Indicator
                if (_selectedLanguage == language)
                  const Icon(
                    Icons.check_circle,
                    color: Colors.black,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}