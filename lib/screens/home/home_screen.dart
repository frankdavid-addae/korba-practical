import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:korba_practical/classes/feedback_dialogs.dart';
import 'package:korba_practical/constants.dart';
import 'package:korba_practical/helpers.dart';
import 'package:korba_practical/providers/users_provider.dart';
import 'package:korba_practical/screens/auth/sign_in_screen.dart';
import 'package:korba_practical/services/shared_preference_store.dart';
import 'package:korba_practical/services/users_api_requests.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _usersApiRequest = GetIt.I.get<UsersApiRequest>();
  final _keyLoader = GlobalKey<State>();
  final _feedbackDialog = GetIt.I.get<FeedbackDialog>();
  final _sharedPrefStore = GetIt.I.get<SharedPrefStore>();

  getUserData() async {
    var token = await _sharedPrefStore.retrieveStringData('token');
    return _usersApiRequest.getAllUsers(context, token!, 1);
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    var _usersProvider = Provider.of<UsersProvider>(context);
    var _usersList = _usersProvider.usersModel.users;
    double mediaQueryHeight = MediaQuery.of(context).size.height;

    // log(_usersModel.users.toString());

    return Scaffold(
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
            onPressed: () {},
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
                        onPressed: (context) {},
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
                    onTap: () {
                      log(_usersList![index].toString());
                    },
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
}
