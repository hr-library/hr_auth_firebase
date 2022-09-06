part of '../../../../hr_auth_firebase.dart';

class SignOutIconHr extends StatelessWidget {
  final Widget homePage;
  const SignOutIconHr({
    required this.homePage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        SignOut().signOut(homePage: homePage);
      },
      icon: const Icon(Icons.logout),
    );
  }
}

class SignOut {
  void signOut({
    required Widget homePage,
  }) async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(LoginViewHr(
      homePage: homePage,
    ));
  }

  void signOutWithAction({
    required void action,
  }) async {
    await FirebaseAuth.instance.signOut();
    action;
  }
}
