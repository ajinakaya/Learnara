import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnara/app/constants/api_endpoint.dart';
import 'package:learnara/features/auth/presentation/view/login_view.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';
import 'package:learnara/features/langauge/domain/entity/user_language_entity.dart';
import 'package:learnara/features/langauge/presentation/view_model/language/language_bloc.dart';
import 'package:learnara/features/onboarding/presentation/view/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCard extends StatefulWidget {
  @override
  _LanguageCardState createState() => _LanguageCardState();
}

class _LanguageCardState extends State<LanguageCard> {
  PreferredLanguageEntity? selectedLanguage;

  @override
  void initState() {
    super.initState();
    context.read<LanguageBloc>().add(LoadLanguages());
    _getUserIdAndLoadPreference();
  }

  Future<void> _getUserIdAndLoadPreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? userId = prefs.getString('userId');

      if (userId != null && userId.isNotEmpty) {
        context.read<LanguageBloc>().add(GetUserLanguage(userId));
      } else {
        _loadSelectedLanguageFromLocal();
      }
    } catch (error) {
      print("Error getting user ID: $error");
      _loadSelectedLanguageFromLocal();
    }
  }

  Future<void> _loadSelectedLanguageFromLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? languageId = prefs.getString('selectedLanguageId');
      final String? languageName = prefs.getString('selectedLanguageName');
      final String? languageImage = prefs.getString('selectedLanguageImage');

      if (languageId != null && languageName != null && languageImage != null) {
        setState(() {
          selectedLanguage = PreferredLanguageEntity(
            languageId: languageId,
            languageName: languageName,
            languageImage: languageImage,
          );
        });
      }
    } catch (error) {
      print("Error loading selected language: $error");
    }
  }

  void _handleLanguageSelect(PreferredLanguageEntity language) async {
    setState(() {
      selectedLanguage = language;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selectedLanguageId', language.languageId);
      await prefs.setString('selectedLanguageName', language.languageName);
      await prefs.setString('selectedLanguageImage', language.languageImage);

      final String? userId = prefs.getString('userId');

      if (userId != null && userId.isNotEmpty) {
        final userLanguage = UserLanguagePreferenceEntity(
          id: language.languageId,
          userId: userId,
          languageName: language.languageName,
          languageImage: language.languageImage,
        );
        context.read<LanguageBloc>().add(SetUserLanguage(userLanguage));
      }
    } catch (error) {
      print("Error saving language preference: $error");
    }
  }

  void _handleContinue(BuildContext context) {
    if (selectedLanguage != null) {
      print("Continuing with language: ${selectedLanguage!.languageName}");
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(
            builder: (_) => LoginView(selectedLanguage: selectedLanguage)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please select a language before continuing."),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Onboarding()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<LanguageBloc, LanguageState>(
          listener: (context, state) {
            if (state.userLanguagePreference != null && !state.isLoading) {
              setState(() {
                selectedLanguage = PreferredLanguageEntity(
                  languageId: state.userLanguagePreference!.id,
                  languageName: state.userLanguagePreference!.languageName,
                  languageImage: state.userLanguagePreference!.languageImage,
                );
              });
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: CircularProgressIndicator(color: Colors.blue.shade600),
              );
            }

            if (state.error != null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, color: Colors.red, size: 60),
                      SizedBox(height: 16),
                      Text(
                        "Error: ${state.error}",
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () =>
                            context.read<LanguageBloc>().add(LoadLanguages()),
                        icon: Icon(Icons.refresh),
                        label: Text("Retry"),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state.languages.isEmpty) {
              return Center(child: Text("No languages available"));
            }

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Choose Your Language",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: state.languages.length,
                      itemBuilder: (context, index) {
                        final language = state.languages[index];
                        final isSelected =
                            selectedLanguage?.languageId == language.languageId;

                        return GestureDetector(
                          onTap: () => _handleLanguageSelect(language),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.blue.shade50
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.blue.shade400
                                    : Colors.grey.shade300,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    "${ApiEndpoints.baseUrl}${language.languageImage}",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.language,
                                          size: 50,
                                          color: Colors.grey.shade400);
                                    },
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  language.languageName,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: selectedLanguage != null
                        ? () => _handleContinue(context)
                        : null,
                    child: Text("Continue",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
