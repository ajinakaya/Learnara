class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3001/";
  // static const String baseUrl = "http://localhost:3001/api/v1/";

// ============================== Auth Routes =============================
  static const String login = "/login";
  static const String register = "/register";
  static const String imageUrl = "http://10.0.2.2:3001/uploads/images/";
  // static const String uploadImage = "/imageupload";
  static const String uploadImage = "/uploadimage";


}
