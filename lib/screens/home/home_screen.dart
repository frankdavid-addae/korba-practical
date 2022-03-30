import 'dart:developer';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:korba_practical/classes/feedback_dialogs.dart';
import 'package:korba_practical/constants.dart';
import 'package:korba_practical/helpers.dart';
import 'package:korba_practical/providers/users_provider.dart';
import 'package:korba_practical/screens/auth/sign_in_screen.dart';
import 'package:korba_practical/screens/users/user_details_screen.dart';
import 'package:korba_practical/services/shared_preference_store.dart';
import 'package:korba_practical/services/users_api_requests.dart';
import 'package:korba_practical/widgets/shared_widgets/custom_input_field.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _usersApiRequest = GetIt.I.get<UsersApiRequest>();
  final _updateFormKey = GlobalKey<FormState>();
  final _createUserFormKey = GlobalKey<FormState>();
  final _keyLoader = GlobalKey<State>();
  final _feedbackDialog = GetIt.I.get<FeedbackDialog>();
  final _sharedPrefStore = GetIt.I.get<SharedPrefStore>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _locationController;
  late TextEditingController _nameController;
  late TextEditingController _eMailController;
  late TextEditingController _placeController;
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  AutovalidateMode _autoValidateCreateForm = AutovalidateMode.disabled;
  bool isHidden = true;
  bool btnUpdateEnabled = true;

  getUserData() async {
    var token = await _sharedPrefStore.retrieveStringData('token');
    return _usersApiRequest.getAllUsers(context, token!, 1);
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    // Initialize controllers
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _locationController = TextEditingController();
    _nameController = TextEditingController();
    _eMailController = TextEditingController();
    _placeController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _nameController.dispose();
    _eMailController.dispose();
    _placeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _usersProvider = Provider.of<UsersProvider>(context);
    var _usersList = _usersProvider.usersModel.users;
    double mediaQueryHeight = MediaQuery.of(context).size.height;

    // log(_usersModel.users.toString());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: silverSandColor,
      appBar: AppBar(
        backgroundColor: eerieBlackColor,
        title: Text(
          'List of Users',
          style: smallTextStyle.copyWith(
            color: silverSandColor,
            fontWeight: FontWeight.w600,
            fontSize: Constant.kSize(mediaQueryHeight, 24.0, 22.0, 20.0),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    contentPadding:
                        const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    titlePadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    content: Container(
                      padding: EdgeInsets.only(
                        top: 20 * multiplier * mediaQueryHeight,
                        left: 15 * multiplier * mediaQueryHeight,
                        right: 15 * multiplier * mediaQueryHeight,
                      ),
                      height:
                          Constant.kSize(mediaQueryHeight, 350.0, 350.0, 370.0),
                      width: 150 * multiplier * mediaQueryHeight,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // SizedBox(
                          //     height: 20.0 *
                          //         multiplier *
                          //         mediaQueryHeight),
                          Form(
                            key: _createUserFormKey,
                            autovalidateMode: _autoValidateCreateForm,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  CustomInputField(
                                    hintText: 'Full Name',
                                    controller: _nameController,
                                    keyboardType: TextInputType.text,
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Icon(
                                        Icons.person,
                                        color: eerieBlackColor,
                                        size: Constant.kSize(
                                            mediaQueryHeight, 28.0, 26.0, 24.0),
                                      ),
                                    ),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Full Name field is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomInputField(
                                    hintText: 'Email Address',
                                    controller: _eMailController,
                                    keyboardType: TextInputType.emailAddress,
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Icon(
                                        Icons.email,
                                        color: eerieBlackColor,
                                        size: Constant.kSize(
                                            mediaQueryHeight, 28.0, 26.0, 24.0),
                                      ),
                                    ),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Email address field is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomInputField(
                                    hintText: 'Location',
                                    controller: _placeController,
                                    keyboardType: TextInputType.text,
                                    fillColor: whiteColor,
                                    suffixIcon: Icon(
                                      Icons.location_pin,
                                      size: Constant.kSize(
                                          mediaQueryHeight, 28.0, 26.0, 24.0),
                                      color: eerieBlackColor,
                                    ),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Location field is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0 * multiplier * mediaQueryHeight,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 35.0 * multiplier * mediaQueryHeight,
                            // width: Constant.kSize(mediaQueryHeight, 95.0, 85.0),
                            decoration: BoxDecoration(
                              // color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: OutlinedButton(
                              onPressed: btnUpdateEnabled
                                  ? () async {
                                      if (_createUserFormKey.currentState!
                                          .validate()) {
                                        var _token = await _sharedPrefStore
                                            .retrieveStringData('token');
                                        _toggleButtonState(false);
                                        _feedbackDialog.loadingDialog(
                                            context, _keyLoader);

                                        if (await ConnectivityWrapper
                                            .instance.isConnected) {
                                          var input = {
                                            "name": _nameController.text,
                                            "email": _eMailController.text,
                                            "location": _placeController.text,
                                          };

                                          var result =
                                              await _usersApiRequest.createUser(
                                            context,
                                            _token!,
                                            input,
                                          );
                                          if (result == 'success') {
                                            var usersResult =
                                                await _usersApiRequest
                                                    .getAllUsers(
                                                        context, _token, 1);

                                            if (usersResult != null) {
                                              Navigator.of(
                                                _keyLoader.currentContext!,
                                                rootNavigator: true,
                                              ).pop();

                                              _toggleButtonState(true);

                                              Navigator.of(context)
                                                  .pop(DialogAction.abort);
                                            }
                                          } else {
                                            await Future.delayed(
                                              Duration(
                                                  milliseconds:
                                                      Helpers.milliSeconds),
                                            );
                                            Navigator.of(
                                              _keyLoader.currentContext!,
                                              rootNavigator: true,
                                            ).pop();
                                            _feedbackDialog.errorDialog(
                                              context,
                                              result.toString(),
                                            );
                                            _toggleButtonState(true);
                                          }
                                        } else {
                                          await Future.delayed(
                                            Duration(
                                                milliseconds:
                                                    Helpers.milliSeconds),
                                          );
                                          Navigator.of(
                                            _keyLoader.currentContext!,
                                            rootNavigator: true,
                                          ).pop();
                                          _feedbackDialog
                                              .internetError(context);
                                          _toggleButtonState(true);
                                        }
                                      } else {
                                        setState(() => _autoValidateCreateForm =
                                            AutovalidateMode.onUserInteraction);
                                      }
                                      // log('pressed');
                                    }
                                  : () {},
                              style: OutlinedButton.styleFrom(
                                backgroundColor: eerieBlackColor,
                                side: BorderSide.none,
                              ),
                              child: Text(
                                'Create',
                                style: smallTextStyle.copyWith(
                                  fontSize:
                                      15.0 * multiplier * mediaQueryHeight,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icon(
              Icons.person_add,
              color: neonGreenColor,
              size: 32.0 * multiplier * mediaQueryHeight,
            ),
          ),
          IconButton(
            onPressed: () async {
              Helpers.signOut();
              Navigator.pushNamedAndRemoveUntil(
                context,
                SignInScreen.routeName,
                (route) => false,
              );
            },
            icon: Icon(
              Icons.logout,
              color: redMunsellColor,
              size: 32.0 * multiplier * mediaQueryHeight,
            ),
          )
        ],
      ),
      body: SizedBox(
        height: mediaQueryHeight,
        // padding: leftAndRightScreenPadding,
        child: ListView.custom(
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: 10.0 * multiplier * mediaQueryHeight,
                ),
                child: Slidable(
                  key: ValueKey(index),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          setState(() {
                            _fullNameController.text =
                                _usersList![index]['name'];
                            _emailController.text = _usersList[index]['email'];
                            _locationController.text =
                                _usersList[index]['location'];
                          });
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.transparent,
                                elevation: 0.0,
                                contentPadding: const EdgeInsets.fromLTRB(
                                    0.0, 0.0, 0.0, 0.0),
                                titlePadding: const EdgeInsets.fromLTRB(
                                    0.0, 0.0, 0.0, 0.0),
                                content: Container(
                                  padding: EdgeInsets.only(
                                    top: 20 * multiplier * mediaQueryHeight,
                                    left: 15 * multiplier * mediaQueryHeight,
                                    right: 15 * multiplier * mediaQueryHeight,
                                  ),
                                  height: Constant.kSize(
                                      mediaQueryHeight, 350.0, 350.0, 370.0),
                                  width: 150 * multiplier * mediaQueryHeight,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // SizedBox(
                                      //     height: 20.0 *
                                      //         multiplier *
                                      //         mediaQueryHeight),
                                      Form(
                                        key: _updateFormKey,
                                        autovalidateMode: _autoValidate,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              CustomInputField(
                                                hintText: 'Full Name',
                                                controller: _fullNameController,
                                                keyboardType:
                                                    TextInputType.text,
                                                suffixIcon: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Icon(
                                                    Icons.person,
                                                    color: eerieBlackColor,
                                                    size: Constant.kSize(
                                                        mediaQueryHeight,
                                                        28.0,
                                                        26.0,
                                                        24.0),
                                                  ),
                                                ),
                                                validator: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return 'Full Name field is required';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              CustomInputField(
                                                hintText: 'Email Address',
                                                controller: _emailController,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                suffixIcon: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Icon(
                                                    Icons.email,
                                                    color: eerieBlackColor,
                                                    size: Constant.kSize(
                                                        mediaQueryHeight,
                                                        28.0,
                                                        26.0,
                                                        24.0),
                                                  ),
                                                ),
                                                validator: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return 'Email address field is required';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              CustomInputField(
                                                hintText: 'Location',
                                                controller: _locationController,
                                                keyboardType:
                                                    TextInputType.text,
                                                fillColor: whiteColor,
                                                suffixIcon: Icon(
                                                  Icons.location_pin,
                                                  size: Constant.kSize(
                                                      mediaQueryHeight,
                                                      28.0,
                                                      26.0,
                                                      24.0),
                                                  color: eerieBlackColor,
                                                ),
                                                validator: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return 'Location field is required';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0 *
                                            multiplier *
                                            mediaQueryHeight,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 35.0 *
                                            multiplier *
                                            mediaQueryHeight,
                                        // width: Constant.kSize(mediaQueryHeight, 95.0, 85.0),
                                        decoration: BoxDecoration(
                                          // color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        child: OutlinedButton(
                                          onPressed: btnUpdateEnabled
                                              ? () async {
                                                  if (_updateFormKey
                                                      .currentState!
                                                      .validate()) {
                                                    var _token =
                                                        await _sharedPrefStore
                                                            .retrieveStringData(
                                                                'token');
                                                    _toggleButtonState(false);
                                                    _feedbackDialog
                                                        .loadingDialog(context,
                                                            _keyLoader);

                                                    if (await ConnectivityWrapper
                                                        .instance.isConnected) {
                                                      var input = {
                                                        "id": _usersList![index]
                                                            ['id'],
                                                        "name":
                                                            _fullNameController
                                                                .text,
                                                        "email":
                                                            _emailController
                                                                .text,
                                                        "location":
                                                            _locationController
                                                                .text,
                                                      };

                                                      var result =
                                                          await _usersApiRequest
                                                              .updateUser(
                                                        context,
                                                        _token!,
                                                        _usersList[index]['id'],
                                                        input,
                                                      );
                                                      if (result == 'success') {
                                                        var usersResult =
                                                            await _usersApiRequest
                                                                .getAllUsers(
                                                                    context,
                                                                    _token,
                                                                    1);

                                                        if (usersResult !=
                                                            null) {
                                                          Navigator.of(
                                                            _keyLoader
                                                                .currentContext!,
                                                            rootNavigator: true,
                                                          ).pop();

                                                          _toggleButtonState(
                                                              true);

                                                          Navigator.of(context)
                                                              .pop(DialogAction
                                                                  .abort);
                                                        }
                                                      } else {
                                                        await Future.delayed(
                                                          Duration(
                                                              milliseconds: Helpers
                                                                  .milliSeconds),
                                                        );
                                                        Navigator.of(
                                                          _keyLoader
                                                              .currentContext!,
                                                          rootNavigator: true,
                                                        ).pop();
                                                        _feedbackDialog
                                                            .errorDialog(
                                                          context,
                                                          result.toString(),
                                                        );
                                                        _toggleButtonState(
                                                            true);
                                                      }
                                                    } else {
                                                      await Future.delayed(
                                                        Duration(
                                                            milliseconds: Helpers
                                                                .milliSeconds),
                                                      );
                                                      Navigator.of(
                                                        _keyLoader
                                                            .currentContext!,
                                                        rootNavigator: true,
                                                      ).pop();
                                                      _feedbackDialog
                                                          .internetError(
                                                              context);
                                                      _toggleButtonState(true);
                                                    }
                                                  } else {
                                                    setState(() => _autoValidate =
                                                        AutovalidateMode
                                                            .onUserInteraction);
                                                  }
                                                }
                                              : () {},
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor: eerieBlackColor,
                                            side: BorderSide.none,
                                          ),
                                          child: Text(
                                            'Update',
                                            style: smallTextStyle.copyWith(
                                              fontSize: 15.0 *
                                                  multiplier *
                                                  mediaQueryHeight,
                                              color: whiteColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        backgroundColor: neonGreenColor,
                        foregroundColor: whiteColor,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.transparent,
                                elevation: 0.0,
                                contentPadding: const EdgeInsets.fromLTRB(
                                    0.0, 0.0, 0.0, 0.0),
                                titlePadding: const EdgeInsets.fromLTRB(
                                    0.0, 0.0, 0.0, 0.0),
                                content: Container(
                                  padding: EdgeInsets.only(
                                    top: 30 * multiplier * mediaQueryHeight,
                                    left: 15 * multiplier * mediaQueryHeight,
                                    right: 15 * multiplier * mediaQueryHeight,
                                  ),
                                  height: Constant.kSize(
                                      mediaQueryHeight, 250.0, 250.0, 265.0),
                                  width: 150 * multiplier * mediaQueryHeight,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 60.0 *
                                            multiplier *
                                            mediaQueryHeight,
                                        width: 60.0 *
                                            multiplier *
                                            mediaQueryHeight,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              redMunsellColor.withOpacity(0.2),
                                        ),
                                        child: Icon(
                                          Icons.question_mark,
                                          size: 40.0 *
                                              multiplier *
                                              mediaQueryHeight,
                                          color: redMunsellColor,
                                        ),
                                      ),
                                      SizedBox(
                                          height: 20.0 *
                                              multiplier *
                                              mediaQueryHeight),
                                      Expanded(
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            text:
                                                'Are you sure you to delete this user?',
                                            style: smallTextStyle.copyWith(
                                              color: blackColor,
                                              fontSize: Constant.kSize(
                                                  mediaQueryHeight, 16, 16, 14),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0 *
                                            multiplier *
                                            mediaQueryHeight,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 35.0 *
                                            multiplier *
                                            mediaQueryHeight,
                                        // width: Constant.kSize(mediaQueryHeight, 95.0, 85.0),
                                        decoration: BoxDecoration(
                                          // color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            OutlinedButton(
                                              onPressed: () async {
                                                _feedbackDialog.loadingDialog(
                                                    context, _keyLoader);
                                                var _token =
                                                    await _sharedPrefStore
                                                        .retrieveStringData(
                                                            'token');
                                                var result =
                                                    await _usersApiRequest
                                                        .deleteUser(
                                                            context,
                                                            _token!,
                                                            _usersList![index]
                                                                ['id']);

                                                if (result == 'success') {
                                                  var usersResult =
                                                      await _usersApiRequest
                                                          .getAllUsers(context,
                                                              _token, 1);

                                                  if (usersResult != null) {
                                                    setState(() {
                                                      _usersList
                                                          .removeAt(index);
                                                    });

                                                    Navigator.of(
                                                      _keyLoader
                                                          .currentContext!,
                                                      rootNavigator: true,
                                                    ).pop();
                                                    Navigator.of(context).pop(
                                                        DialogAction.abort);
                                                  }
                                                }
                                              },
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor:
                                                    redMunsellColor,
                                                side: BorderSide.none,
                                              ),
                                              child: Text(
                                                'Delete',
                                                style: smallTextStyle.copyWith(
                                                  fontSize: 15.0 *
                                                      multiplier *
                                                      mediaQueryHeight,
                                                  color: whiteColor,
                                                ),
                                              ),
                                            ),
                                            OutlinedButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(DialogAction.abort),
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor:
                                                    eerieBlackColor,
                                                side: BorderSide.none,
                                              ),
                                              child: Text(
                                                'Cancel',
                                                style: smallTextStyle.copyWith(
                                                  fontSize: 15.0 *
                                                      multiplier *
                                                      mediaQueryHeight,
                                                  color: whiteColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0 *
                                            multiplier *
                                            mediaQueryHeight,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        backgroundColor: redMunsellColor,
                        foregroundColor: whiteColor,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: () => Navigator.pushNamed(
                      context,
                      UserDetailsScreen.routeName,
                      arguments: _usersList![index],
                    ),
                    tileColor: whiteColor,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 12.0 * multiplier * mediaQueryHeight,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: whiteColor,
                      backgroundImage:
                          NetworkImage(_usersList![index]['profilepicture']),
                      radius: 20.0,
                    ),
                    title: Text(
                      _usersList[index]['name'],
                      style: smallTextStyle.copyWith(
                        color: graniteGrayColor,
                        fontSize:
                            Constant.kSize(mediaQueryHeight, 16.0, 15.0, 14.0),
                      ),
                    ),
                    subtitle: Text(
                      _usersList[index]['email'],
                      style: smallTextStyle.copyWith(
                        color: graniteGrayColor,
                        fontSize:
                            Constant.kSize(mediaQueryHeight, 14.0, 13.0, 12.0),
                      ),
                    ),
                    trailing: Text(
                      _usersList[index]['location'],
                      style: smallTextStyle.copyWith(
                        color: graniteGrayColor,
                        fontSize:
                            Constant.kSize(mediaQueryHeight, 14.0, 13.0, 12.0),
                      ),
                    ),
                  ),
                ),
              );
            },
            childCount: _usersList!.length,
          ),
          shrinkWrap: true,
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }

  void _toggleButtonState(bool state) {
    setState(() => btnUpdateEnabled = state);
  }
}
