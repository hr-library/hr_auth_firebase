import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../hr_auth_firebase.dart';
import '../model/user_model.dart';
import '../service/firestore_utils.dart';
import '../service/storage_utils.dart';
import '../service/utils.dart';
import '../users/controller/users_controller.dart';

class AuthenticationController extends GetxController {
  final FirestoreUtils _firestoreUtils = FirestoreUtils();
  final StorageUtils _storageUtils = StorageUtils();
  final UsersController _usersController = Get.put(UsersController());

  Rxn<UserModel> currentUserModel = Rxn<UserModel>();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> createUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    String photo = '';
    String storageLocation = '';
    if (user.photoURL != null) {
      photo =
          await _storageUtils.uploadPicByUrl(user.uid, user.photoURL!, 'users');
      storageLocation = 'gs://hr-test-48e7e.appspot.com/users/${user.uid}';
    }
    UserModel newUser = UserModel(
      uid: user.uid,
      userType: 'simpleUser',
      enable: false,
      email: user.email,
      user: user,
      phoneNumber: user.phoneNumber,
      displayName: user.displayName,
      photo: photo,
      locationStorage: storageLocation,
    );
    await _firestoreUtils.createUser(newUser);
    currentUserModel.value = newUser;
  }

  Future<void> afterSignIn(Widget homePage) async {
    GetUserStatus status = await getUserStatus();
    print('$logTrace status : $status');
    if (status == GetUserStatus.userNotActivate) {
      Get.offAll(ErrorScaffoldHr(
        homePage: homePage,
      ));
    } else {
      Get.offAll(homePage);
    }
  }

  Future<void> getUser() async {
    if (FirebaseAuth.instance.currentUser?.uid == null) return;
    List<UserModel> listUser = _usersController.usersListInit
        .where((UserModel element) =>
            element.uid == FirebaseAuth.instance.currentUser?.uid)
        .toList();
    if (listUser.isEmpty) {
      await createUser();
    } else {
      currentUserModel.value = listUser.first;
    }
    print('$logTrace currentUserModel : ${currentUserModel.value?.uid}');
  }

  Future<GetUserStatus> getUserStatus() async {
    final UsersController usersController = Get.put(UsersController());
    await usersController.fetchUsers();
    await getUser();
    if (currentUserModel.value == null) {
      return GetUserStatus.noUser;
    }
    if (kDebugMode) {
      print(currentUserModel.value?.uid);
    }
    if (currentUserModel.value?.userType == 'admin') {
      return GetUserStatus.userAdmin;
    }
    if (currentUserModel.value?.enable == false) {
      await FirebaseAuth.instance.signOut();
      return GetUserStatus.userNotActivate;
    }
    return GetUserStatus.userActivate;
  }
}