part of '../../../../hr_auth_firebase.dart';

class SignOutIconHr extends StatelessWidget {
  final Widget homePage;
  final bool verifyAdmin;
  const SignOutIconHr({
    required this.homePage,
    this.verifyAdmin = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        SignOut().signOut(homePage: homePage, verifyAdmin: verifyAdmin);
      },
      icon: const Icon(Icons.logout),
    );
  }
}

class SignOut {
  void signOut({
    required Widget homePage,
    bool verifyAdmin = false,
  }) async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(LoginViewHr(
      homePage: homePage,
      verifyAdmin: verifyAdmin,
    ));
  }

  void signOutWithAction({
    required void action,
  }) async {
    await FirebaseAuth.instance.signOut();
    action;
  }
}
