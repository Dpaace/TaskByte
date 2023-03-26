import 'package:task_byte/helper/objectbox.dart';
import 'package:task_byte/model/user_model.dart';
import 'package:task_byte/state/objectbox_state.dart';

class UserDataSource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;

  Future<int> addUser(User user) async {
    try {
      return objectBoxInstance.addUser(user);
    } catch (e) {
      return Future.value(0);
    }
  }

  Future<List<User>> getUsers() async {
    try {
      return objectBoxInstance.getAllUsers();
    } catch (e) {
      throw Exception("Error in getting all users");
    }
  }

  // Future<bool> loginUser(String email, String password) {
  //   try {
  //     return Future.value(objectBoxInstance.loginUser(email, password));
  //   } catch (e) {
  //     return Future.value(null);
  //   }
  // }

  Future<bool> loginUser(String email, String password) async {
    try {
      if (objectBoxInstance.loginUser(email, password) != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error occured : ${e.toString()}');
    }
  }

  Future<bool> checkUser(String username, String email) async {
    try {
      if (objectBoxInstance.checkUser(username, email) == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      throw Exception('Error occured : ${e.toString()}');
    }
  }

  // Future<bool> loginStudent(String username, String password) async {
  //   try {
  //     if (objectBoxInstance.loginStudent(username, password) != null) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     throw Exception('Error occured : ${e.toString()}');
  //   }
  // }
}
