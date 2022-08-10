part of '../../../../hr_auth_firebase.dart';

class ErrorScaffoldHr extends StatelessWidget {
  final Widget homePage;
  const ErrorScaffoldHr({
    required this.homePage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorViewHr(
        homePage: homePage,
      ),
    );
  }
}

class ErrorViewHr extends StatelessWidget {
  final Widget homePage;
  const ErrorViewHr({
    required this.homePage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Votre compte est bloqué',
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
                LoginViewHr(homePage: homePage),
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
