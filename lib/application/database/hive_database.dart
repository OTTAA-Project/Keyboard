import 'package:keyboard/core/abstracts/local_database.dart';
import 'package:keyboard/core/enums/keyboard_layouts.dart';
import 'package:keyboard/core/models/user_model.dart';

import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase implements LocalDatabase {
  @override
  UserModel? user;

  late Box<UserModel> _userBox;

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(KeyboardLayoutAdapter());
    Hive.registerAdapter(UserModelAdapter());

    _userBox = await Hive.openBox<UserModel>('user');
  }

  @override
  Future<void> close() async {
    await Hive.close();
  }

  @override
  Future<void> deleteUser() async {
    await _userBox.clear();
  }

  @override
  Future<UserModel?> getUser() async {
    return _userBox.getAt(0);
  }

  @override
  Future<void> setUser(UserModel user) async {
    this.user = user;
    await _userBox.clear();
    await _userBox.add(user);
  }
}
