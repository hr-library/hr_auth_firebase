part of '../../../../hr_auth_firebase.dart';

class LoginViewHr extends StatelessWidget {
  final Widget homePage;
  List<FlutterFireUIAction> actions;
  LoginViewHr({
    required this.homePage,
    this.actions = const [],
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
      actions: actions.isEmpty
          ? [
              AuthStateChangeAction<SignedIn>((context, state) async {
                await _authenticationController.afterSignIn(homePage);
              }),
            ]
          : actions,
    );
  }
}
