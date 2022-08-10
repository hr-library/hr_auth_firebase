# in main.dart
```
await GetStorage.init();
initConfig(
    projectKey: 'example',
    storageKey: 'gs://hr-test-48e7e.appspot.com/',
    googleClientId:
    '513998380685-m9h9mi0sjcmsfn4k6ntuen8ai8848n85.apps.googleusercontent.com',
);
GetUserStatus status = await getUserStatus();
```

## Users Management
- UsersScaffoldHr
- UserViewHr

## Profile
- MyProfileScaffoldHr
- MyProfileViewHr
- RegisterScaffoldHr
- RegisterView
- AvatarViewHr

## Login
- LoginViewHr
- SignOutIconHr
- SignOut

## ErrorPage
- ErrorScaffoldHr

## Value
Get.find<AuthenticationController>().currentUserModel.value