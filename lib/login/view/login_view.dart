part of '../../../../hr_auth_firebase.dart';

class LoginViewHr extends StatelessWidget {
  final Widget homePage;
  LoginViewHr({
    required this.homePage,
    Key? key,
  }) : super(key: key);

  final providerConfigs = [
    const EmailProviderConfiguration(),
    const GoogleProviderConfiguration(
        clientId:
            '513998380685-m9h9mi0sjcmsfn4k6ntuen8ai8848n85.apps.googleusercontent.com'),
  ];
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providerConfigs: providerConfigs,
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) async {
          await _authenticationController.afterSignIn(homePage);
        }),
      ],
    );
  }
}
