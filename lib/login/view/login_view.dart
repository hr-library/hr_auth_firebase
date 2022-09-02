part of '../../../../hr_auth_firebase.dart';

class LoginViewHr extends StatelessWidget {
  final Widget homePage;
  final String appTitle;
  final bool verifyAdmin;
  LoginViewHr({
    required this.homePage,
    required this.appTitle,
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
      subtitleBuilder: (context, action) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            action == AuthAction.signIn
                ? 'Welcome to $appTitle\nPlease sign in to continue.'
                : 'Welcome to $appTitle\nPlease create an account to continue',
          ),
        );
      },
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) async {
          if (verifyAdmin) {
            await _authenticationController.afterSignInAndVerifyAdmin(
              homePage,
              verifyAdmin,
              appTitle,
            );
          } else {
            await _authenticationController.afterSignIn(
              homePage,
              verifyAdmin,
              appTitle,
            );
          }
        }),
      ],
    );
  }
}
