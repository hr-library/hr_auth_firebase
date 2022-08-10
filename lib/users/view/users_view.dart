part of '../../../../hr_auth_firebase.dart';

class UsersScaffoldHr extends StatelessWidget {
  const UsersScaffoldHr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Utiliateurs'),
      ),
      body: UserViewHr(),
    );
  }
}

class UserViewHr extends StatelessWidget {
  UserViewHr({Key? key}) : super(key: key);

  final UsersController _usersController = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Column(
              children: [
                _textField(context),
                Expanded(
                    child: Obx(() => _usersController.usersList.value.isNotEmpty
                        ? Obx(() => _listViewBuilder(
                            _usersController.usersList, context))
                        : Column(
                            children: const [],
                          )))
              ],
            ))
      ],
    );
  }

  Widget _textField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: HrCustomTextFormField(
        height: 60,
        textInputType: TextInputType.text,
        labelText: 'Recherche',
        prefixIcon: const Icon(
          Icons.search,
        ),
        hasPrefixIcon: true,
        onChanged: (String value) {
          _usersController.filterSearchResults(value);
        },
      ),
    );
  }

  Widget _listViewBuilder(List<UserModel> allData, BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: allData.length,
      itemBuilder: (BuildContext context, int index) {
        UserModel data = allData[index];
        return _card(context, data, index);
      },
    );
  }

  Widget _card(BuildContext context, UserModel data, int index) {
    ThemeData theme = Theme.of(context);
    return GFListTile(
      onTap: () {
        //_usersController.navigateToFormView(index);
      },
      avatar: data.photo == null || data.photo == ''
          ? const GFAvatar(
              child: Icon(Icons.person),
            )
          : kIsWeb
              ? GFAvatar(
                  backgroundImage: NetworkImage(data.photo!),
                )
              : GFAvatar(
                  backgroundImage: FirebaseImage(data.locationStorage!),
                ),
      title: Text(
        data.displayName ?? '',
      ),
      subTitle: Text(data.email ?? ''),
      icon: data.userType == 'admin'
          ? const Text('Admin')
          : GFCheckbox(
              size: 20,
              activeBgColor: theme.primaryColor,
              onChanged: (value) async {
                await _usersController.activationUsers(data);
              },
              value: data.enable!,
            ),
    );
  }
}
