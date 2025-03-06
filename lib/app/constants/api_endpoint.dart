class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // static const String baseUrl = "http://10.0.2.2:3001/";
  static const String baseUrl = "http://192.168.1.66:3001/";

// ============================== Auth Routes =============================
  static const String login = "/login";
  static const String register = "/register";

  static const String imageUrl = "http://10.0.2.2:3001/uploads/images/";
   static const String profile = "/users/Profile";
  static const String uploadImage = "/imageupload";

  static const String getAllLanguages = "/preferred-language/preferredlanguages";
  static const String getUserPreferredLanguage = "/language/language";
  static const  String setUserPreferredLanguage = "/language/language";

  static  const String getAllFlashcards = "/flashcard/flashcard";
  static  const String getAllQuizzes = "/quiz/quiz";
  static  const String getAllAudioActivities = "/audio/audio";

  static  const String getAllCourses = "/course/course";
  static const String getAllChapters = "chapter/chapters";
  static  const String getAllSubLessons = "/sublesson/lesson";
  static const String sublessonbyid = "/sublesson/lesson/:id";
  static const String  Chapterbyid = "/chapter/chapters/:id";
  static const String getCoursebyid = "/course/course/:id ";

}


