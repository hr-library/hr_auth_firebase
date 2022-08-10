import 'package:get/get.dart';

import '../../model/user_model.dart';
import '../../service/firestore_utils.dart';

class UsersController extends GetxController {
  final FirestoreUtils _firestoreUtils = FirestoreUtils();
  RxList<UserModel> usersList = <UserModel>[].obs;
  List<UserModel> usersListInit = [];

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> fetchUsers() async {
    usersList.value = await _firestoreUtils.fetchUsers();
    usersListInit.clear();
    usersListInit.addAll(usersList.value);
  }

  Future<void> activationUsers(UserModel data) async {
    UserModel newEvent = data.copyWith(enable: !data.enable!);
    usersList.value.remove(data);
    usersList.value.add(newEvent);
    List<UserModel> list = [];
    list.addAll(usersList.value);
    usersList.value = list;
    await _firestoreUtils.updateUser(newEvent);
    usersList.value.forEach((element) {
      print(element.displayName);
      print(element.uid);
      print("********************");
    });
    usersList.value.sort((a, b) => a.displayName!.compareTo(b.displayName!));
  }

  void filterSearchResults(String query) {
    List<UserModel> dummySearchList = [];
    List<UserModel> searchList = [];
    dummySearchList.addAll(usersListInit);
    if (query.toString().isNotEmpty) {
      List<UserModel> dummyListData = [];
      query = query.toLowerCase();
      dummySearchList.forEach((UserModel item) {
        bool hasName = false;
        if (item.displayName != null) {
          if (item.displayName!.toLowerCase().contains(query)) {
            hasName = true;
          }
        }
        if (hasName || item.email!.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      searchList.addAll(dummyListData);
    } else {
      searchList.addAll(usersListInit);
    }
    usersList.value.clear();
    usersList.value = searchList;
  }
}
