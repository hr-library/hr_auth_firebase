part of '../../../../hr_auth_firebase.dart';

class ErrorScaffoldHr extends StatelessWidget {
  final Widget homePage;
  final bool verifyAdmin;
  final String appTitle;
  const ErrorScaffoldHr({
    required this.homePage,
    required this.appTitle,
    this.verifyAdmin = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorViewHr(
        homePage: homePage,
        verifyAdmin: verifyAdmin,
        appTitle: appTitle,
      ),
    );
  }
}

class ErrorViewHr extends StatelessWidget {
  final Widget homePage;
  final String appTitle;
  final bool verifyAdmin;
  const ErrorViewHr({
    required this.homePage,
    required this.appTitle,
    this.verifyAdmin = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Votre compte n' a pas d' accès à cette application",
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Contacter votre administrateur',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          GFButton(
            onPressed: () {
              Get.offAll(
                LoginViewHr(
                  homePage: homePage,
                  verifyAdmin: verifyAdmin,
                  appTitle: appTitle,
                ),
              );
            },
            text: 'Réessayer',
            type: GFButtonType.outline,
          )
        ],
      ),
    );
  }
}
