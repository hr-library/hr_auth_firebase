import 'package:flutter/material.dart';
import 'package:hr_auth_firebase/hr_auth_firebase.dart';
import 'package:get/get.dart';

import 'drawer.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: const [
          SignOutIconHr(
            homePage: HomePageView(),
          ),
        ],
      ),
      drawer: const DrawerMenu(),
      body: Center(
        child: Column(
          children: [
            const Text('Bem vindo ao Flutter!!!'),
            const SizedBox(height: 20),
            if (Get.find<AuthenticationController>().isAdmin.value)
              TextButton(
                  onPressed: () {
                    Get.to(const UsersScaffoldHr());
                  },
                  child: const Text('All Users')),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Get.to(
                    const MyProfileScaffoldHr(),
                  );
                },
                child: const Text('My Profile')),
            const SizedBox(height: 20),
            AvatarViewHr(),
            const SizedBox(height: 20),
            Text(
              '${Get.find<AuthenticationController>().currentUserModel.value?.displayName}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              'is Admin : ${Get.find<AuthenticationController>().isAdmin.value}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
