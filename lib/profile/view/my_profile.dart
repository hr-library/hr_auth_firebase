part of '../../../../hr_auth_firebase.dart';

class MyProfileScaffoldHr extends StatelessWidget {
  const MyProfileScaffoldHr({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon profile'),
      ),
      body: MyProfileViewHr(),
    );
  }
}

class MyProfileViewHr extends StatelessWidget {
  MyProfileViewHr({Key? key}) : super(key: key);

  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());
  final RegisterController _registerController = Get.put(RegisterController());
  final RegisterInputController _registerInputController = Get.put(
    RegisterInputController(),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(() => _registerInputController.isEdit.value
        ? RegisterView()
        : _body(context));
  }

  Widget _body(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Center(
        child: ListView(
          children: [
            const SizedBox(height: 50.0),
            Obx(() => _authenticationController.currentUserModel.value != null
                ? Obx(() => _profileWidget(
                      _authenticationController.currentUserModel.value!,
                    ))
                : Container()),
          ],
        ),
      ),
    );
  }

  Widget _profileWidget(UserModel data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        data.photo != null
            ? GFAvatar(
                size: 120,
                backgroundImage: NetworkImage(
                  data.photo!,
                ),
              )
            : const GFAvatar(
                size: 120,
                child: Icon(
                  Icons.person,
                  size: 50,
                ),
              ),
        _infoWidget(data.displayName ?? ''),
        _infoWidget(data.email ?? ''),
        _infoWidget(data.phoneNumber ?? ''),
        const SizedBox(height: 30.0),
        IconButton(
          onPressed: () {
            _registerController.navigateToEditUser();
          },
          icon: const Icon(Icons.edit),
        ),
      ],
    );
  }

  Widget _infoWidget(String text) {
    return text.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10.0),
              Text(
                text,
              ),
            ],
          )
        : Container();
  }
}
