part of '../../../../hr_auth_firebase.dart';

class AvatarViewHr extends StatelessWidget {
  AvatarViewHr({Key? key}) : super(key: key);

  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return _authenticationController.currentUserModel.value!.photo == null ||
            _authenticationController.currentUserModel.value!.photo!.isEmpty
        ? const GFAvatar(
            child: Icon(Icons.person),
          )
        : kIsWeb
            ? GFAvatar(
                backgroundImage: NetworkImage(
                    _authenticationController.currentUserModel.value!.photo!),
              )
            : GFAvatar(
                backgroundImage: FirebaseImage(_authenticationController
                    .currentUserModel.value!.locationStorage!),
              );
  }
}
