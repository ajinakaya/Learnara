import 'package:hive_flutter/adapters.dart';
import 'package:learnara/app/constants/hive_table_constant.dart';
import 'package:learnara/features/auth/data/model/auth_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    //Initalizing the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}learnara.db';

    Hive.init(path);

    Hive.registerAdapter(AuthHiveModelAdapter());
  }

  Future<void> register(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HIveTableConstant.userBox);
    await box.put(auth.userId, auth);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HIveTableConstant.userBox);
    await box.delete(id);
  }

  // Future<List<AuthHiveModel>> getAllAuth() async{

  // }

  // Login using email and password
  Future<AuthHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HIveTableConstant.userBox);
    var auth = box.values.firstWhere(
            (element) =>
        element.email == email && element.password == password,
        orElse: () => const AuthHiveModel.initial());
    return auth;
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HIveTableConstant.userBox);
  }

  // Clear User Box
  Future<void> clearUserBox() async {
    await Hive.deleteBoxFromDisk(HIveTableConstant.userBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}