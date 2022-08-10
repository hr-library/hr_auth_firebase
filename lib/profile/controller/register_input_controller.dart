import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterInputController extends GetxController {
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  RxString image = ''.obs;

  RxBool isEdit = false.obs;
}
