part of '../../../../hr_auth_firebase.dart';

class LoginViewHr extends StatelessWidget {
  final Widget homePage;
  LoginViewHr({
    required this.homePage,
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
      footerBuilder: (context, provider) {
        return Lottie.network(
          'https://assets8.lottiefiles.com/packages/lf20_jcikwtux.json',
        );
      },
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) async {
          await _authenticationController.afterSignIn(
            homePage,
          );
        }),
      ],
    );
  }
}
