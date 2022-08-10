library hr_auth_firebase;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:hr_auth_firebase/controller/authentication_controller.dart';
import 'package:hr_auth_firebase/profile/controller/register_controller.dart';
import 'package:hr_auth_firebase/profile/controller/register_input_controller.dart';
import 'package:hr_auth_firebase/profile/view/register_view.dart';
import 'package:hr_auth_firebase/users/controller/users_controller.dart';
import 'package:text_field/text_field.dart';

import 'model/user_model.dart';

part 'login/view/login_view.dart';
part 'login/view/logout.dart';
part 'users/view/users_view.dart';
part 'profile/view/my_profile.dart';
part 'error/view/error_page.dart';
part 'profile/view/avatar.dart';

enum GetUserStatus {
  userActivate,
  userAdmin,
  noUser,
  userNotActivate,
}

Future<GetUserStatus> getUserStatus() async {
  AuthenticationController authenticationController =
      Get.put(AuthenticationController());
  return authenticationController.getUserStatus();
}