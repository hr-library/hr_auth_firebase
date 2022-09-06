part of '../../../../hr_auth_firebase.dart';

class SignOutIconHr extends StatelessWidget {
  final Widget homePage;
  final String appTitle;
  const SignOutIconHr({
    required this.homePage,
    required this.appTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        SignOut().signOut(homePage: homePage, appTitle: appTitle);
      },
      icon: const Icon(Icons.logout),
    );
  }
}

class SignOut {
  void signOut({
    required Widget homePage,
    required String appTitle,
  }) async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(LoginViewHr(
      homePage: homePage,
      appTitle: appTitle,
    ));
  }

  void signOutWithAction({
    required void action,
  }) async {
    await FirebaseAuth.instance.signOut();
    action;
  }
}
