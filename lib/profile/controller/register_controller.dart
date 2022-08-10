import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hr_auth_firebase/controller/authentication_controller.dart';
import 'package:hr_auth_firebase/profile/controller/register_input_controller.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/get_storage_key.dart';
import '../../model/user_model.dart';
import '../../service/firestore_utils.dart';
import '../../service/storage_utils.dart';
import '../view/register_view.dart';

enum NavigationStatus {
  errorPage,
  signInPage,
  signupPage,
}

class RegisterController extends GetxController {
  final RegisterInputController _registerInputController =
      Get.put(RegisterInputController());
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());
  final FirestoreUtils _firestoreUtils = FirestoreUtils();
  final StorageUtils _storageUtils = StorageUtils();

  RxBool onLoading = false.obs;
  PickedFile? pickedFile;

  RxString authMessage = ''.obs;

  RxBool displayNameHasError = false.obs;
  RxString displayNameErrorMessage = ''.obs;

  RxBool phoneNumberHasError = false.obs;
  RxString phoneNumberErrorMessage = ''.obs;

  Rx<NavigationStatus> navigationStatus = NavigationStatus.signInPage.obs;
  String storageLocation =
      '${GetStorage().read(GetStorageKey.projectKey)}${GetStorage().read(GetStorageKey.platform)}';

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future getImageFromFile() async {
    pickedFile = (await ImagePicker().getImage(source: ImageSource.gallery))!;
    _registerInputController.image.value = pickedFile!.path;
  }

  Future getImageFromCamera() async {
    pickedFile = (await ImagePicker().getImage(source: ImageSource.camera))!;
    _registerInputController.image.value = pickedFile!.path;
  }

  bool verifyDisplayName(BuildContext context) {
    if (_registerInputController.displayNameController.text.isEmpty) {
      displayNameHasError.value = true;
      displayNameErrorMessage.value = 'Veuillez entrer votre pseudo';
      return false;
    }
    displayNameHasError.value = false;
    return true;
  }

  bool verifyPhoneNumber(BuildContext context) {
    if (_registerInputController.phoneNumberController.text.isEmpty) {
      phoneNumberHasError.value = true;
      phoneNumberErrorMessage.value =
          'Veuillez entrer votre numéro de téléphone';
      return false;
    }
    phoneNumberHasError.value = false;
    return true;
  }

  bool verifyLengthPhoneNumber(BuildContext context) {
    if (_registerInputController.phoneNumberController.text.length != 10 &&
        _registerInputController.phoneNumberController.text.isNotEmpty) {
      phoneNumberHasError.value = true;
      phoneNumberErrorMessage.value =
          'Veuillez entrer un numéro de téléphone valide';
      return false;
    }
    phoneNumberHasError.value = false;
    return true;
  }

  Future<void> updateUser(BuildContext context) async {
    if (!verifyLengthPhoneNumber(context) || !verifyDisplayName(context)) {
      return;
    }
    onLoading.value = true;
    UserModel data = _authenticationController.currentUserModel.value!;
    late UserModel newData;
    if (pickedFile != null) {
      String photo = await _storageUtils.uploadPicByFile(
          data.uid!, pickedFile!, storageLocation);
      String locationStorage =
          '${GetStorage().read(GetStorageKey.storageKey)}users/$storageLocation/${data.uid}';
      newData = data.copyWith(
        displayName: _registerInputController.displayNameController.text,
        phoneNumber: _registerInputController.phoneNumberController.text,
        photo: photo,
        locationStorage: locationStorage,
      );
    } else {
      newData = data.copyWith(
        displayName: _registerInputController.displayNameController.text,
        phoneNumber: _registerInputController.phoneNumberController.text,
      );
    }
    await _firestoreUtils.updateUser(newData);
    _authenticationController.currentUserModel.value = newData;
    pickedFile = null;
    onLoading.value = false;
  }

  void navigateToEditUser() {
    _registerInputController.displayNameController.text =
        _authenticationController.currentUserModel.value!.displayName ?? '';
    _registerInputController.phoneNumberController.text =
        _authenticationController.currentUserModel.value!.phoneNumber ?? '';
    _registerInputController.image.value =
        _authenticationController.currentUserModel.value!.photo ?? '';
    _registerInputController.isEdit.value = true;
  }

  void cancelEdit() {
    _registerInputController.isEdit.value = false;
  }
}
