import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:text_field/text_field.dart';
import '../controller/register_controller.dart';
import '../controller/register_input_controller.dart';

class RegisterScaffoldHr extends StatelessWidget {
  const RegisterScaffoldHr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterView(),
    );
  }
}

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);

  final RegisterController _registerController = Get.put(RegisterController());
  final RegisterInputController _authenticationInputController =
      Get.put(RegisterInputController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() => !_registerController.onLoading.value
          ? _buildForm(context)
          : _loader()),
    );
  }

  Widget _loader() {
    return const GFLoader(type: GFLoaderType.circle);
  }

  Widget _buildForm(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: heightOfScreen * 0.1,
              ),
              _imagePicker(),
              const SizedBox(
                height: 20,
              ),
              Obx(() => HrCustomTextFormField(
                    controller:
                        _authenticationInputController.displayNameController,
                    labelText: 'Nom',
                    errorText: _registerController.displayNameHasError.value
                        ? _registerController.displayNameErrorMessage.value
                        : null,
                  )),
              const SizedBox(
                height: 20,
              ),
              Obx(() => HrCustomTextFormField(
                    controller:
                        _authenticationInputController.phoneNumberController,
                    labelText: 'Téléphone',
                    errorText: _registerController.phoneNumberHasError.value
                        ? _registerController.phoneNumberErrorMessage.value
                        : null,
                  )),
              const SizedBox(
                height: 25,
              ),
              GFButton(
                onPressed: () async {
                  if (_authenticationInputController.isEdit.value) {
                    await _registerController.updateUser(context);
                  }
                },
                text: _authenticationInputController.isEdit.value
                    ? 'Modifier'
                    : 'Envoyer',
                type: GFButtonType.outline,
              ),
              const SizedBox(height: 30.0),
              IconButton(
                onPressed: () {
                  _registerController.cancelEdit();
                },
                icon: const Icon(Icons.clear),
              ),
              SizedBox(
                height: heightOfScreen * 0.03,
              ),
            ],
          )),
    );
  }

  Widget _imagePicker() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 94,
                child: ClipOval(
                  child: Obx(() => SizedBox(
                      width: 170.0,
                      height: 170.0,
                      child: _authenticationInputController.image.value.isEmpty
                          ? const Icon(
                              Icons.person,
                              size: 60.0,
                            )
                          : _authenticationInputController.image.value
                                  .contains('http')
                              ? Image.network(
                                  _authenticationInputController.image.value,
                                  fit: BoxFit.fill,
                                )
                              : Image.file(
                                  File(_authenticationInputController
                                      .image.value),
                                  fit: BoxFit.cover,
                                ))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: IconButton(
                icon: const Icon(
                  Icons.photo,
                  size: 25.0,
                ),
                onPressed: () async {
                  await _registerController.getImageFromFile();
                },
              ),
            ),
            if (!kIsWeb)
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.photo_camera,
                    size: 25.0,
                  ),
                  onPressed: () async {
                    await _registerController.getImageFromCamera();
                  },
                ),
              ),
          ],
        ),
      ],
    );
  }
}
