import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/drawer/gf_drawer.dart';
import 'package:get/get.dart';
import 'package:hr_auth_firebase/hr_auth_firebase.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFDrawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 70,
          ),
          ListTile(
            leading: const Icon(Icons.person_outline_rounded),
            title: const Text('My profile'),
            onTap: () {
              Get.to(
                const MyProfileScaffoldHr(),
              );
            },
          ),
          if (Get.find<AuthenticationController>().isAdmin.value)
            ListTile(
              leading: const Icon(CupertinoIcons.person_3),
              title: const Text('All Users'),
              onTap: () {
                Get.to(const UsersScaffoldHr());
              },
            ),
        ],
      ),
    );
  }
}
