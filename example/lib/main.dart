import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hr_auth_firebase/hr_auth_firebase.dart';
import 'package:hr_auth_firebase/model/get_storage_key.dart';
import 'package:hr_auth_firebase/service/utils.dart';

import 'home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  GetStorage().write(GetStorageKey.platform, 'dev');
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDx-z6rsjA7N6fG75TauvMGAhrPFCuvfrM",
        authDomain: "hr-test-48e7e.firebaseapp.com",
        projectId: "hr-test-48e7e",
        storageBucket: "hr-test-48e7e.appspot.com",
        messagingSenderId: "513998380685",
        appId: "1:513998380685:web:8f7a05fcfeb4a79ca4ccc4",
        measurementId: "G-8296595LTL",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  initConfig(
    projectKey: 'example',
    storageKey: 'gs://hr-test-48e7e.appspot.com/',
    googleClientId:
        '513998380685-m9h9mi0sjcmsfn4k6ntuen8ai8848n85.apps.googleusercontent.com',
  );
  GetUserStatus status = await getUserStatus();
  print('$logTrace status : $status');
  Widget initialPage = LoginViewHr(homePage: const HomePageView());
  if (status == GetUserStatus.userActivate) {
    initialPage = const HomePageView();
  } else if (status == GetUserStatus.userNotActivate) {
    initialPage = const ErrorScaffoldHr(
      homePage: HomePageView(),
    );
  } else if (status == GetUserStatus.userAdmin) {
    initialPage = UsersScaffoldHr();
  }
  runApp(MyApp(
    initPage: initialPage,
  ));
}

class MyApp extends StatelessWidget {
  Widget initPage;
  MyApp({
    required this.initPage,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      home: FirebaseAuth.instance.currentUser == null
          ? LoginViewHr(homePage: const HomePageView())
          : const HomePageView(),
    );
  }
}
