part of '../../../../hr_auth_firebase.dart';

class LoginViewHr extends StatelessWidget {
  final Widget homePage;
  final bool verifyAdmin;
  LoginViewHr({
    required this.homePage,
    this.verifyAdmin = false,
    Key? key,
  }) : super(key: key);

  final providerConfigs = [
    const EmailProviderConfiguration(),
    GoogleProviderConfiguration(
        clientId: GetStorage().read(GetStorageKey.googleClientId)),
  ];
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providerConfigs: providerConfigs,
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) async {
          if (verifyAdmin) {
            await _authenticationController.afterSignInAndVerifyAdmin(
                homePage, verifyAdmin);
          } else {
            await _authenticationController.afterSignIn(homePage, verifyAdmin);
          }
        }),
      ],
    );
  }
}
