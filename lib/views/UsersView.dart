import 'package:chat_app/services/Authentication.dart';
import 'package:chat_app/views/ChatView.dart';
import 'package:chat_app/widgets/CustomText.dart';
import 'package:chat_app/widgets/UserCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../services/Database.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    var messageText;
    var messageSender;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomText(
                text: "Contact",
                fontSize: Theme.of(context).textTheme.headline4!.fontSize,
                fontWeight: FontWeight.w500,
              ),
              StreamBuilder(
                stream: Database().db.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (snapshot.hasData) {
                    final users = snapshot.data!.docs;
                    List<Widget> messageWigdets = [];
                    for (var user in users) {
                      if (authController.currentUser.uid ==
                          user['uid'].toString()) {
                      } else {
                        messageText = user['fullname'];
                        messageSender = user['email'];
                        final messageWigdet = UserCard(
                            name: messageText,
                            email: messageSender,
                            onTap: () {
                              setState(() {
                                if (true ==
                                    Database().createGroup(
                                        authController.auth.currentUser!.uid
                                            .toString(),
                                        user["uid"].toString())) {
                                  Get.to(ChatView(
                                    name: user["fullname"].toString(),
                                    uid: user["uid"].toString(),
                                  ));
                                } else {}
                              });
                            });
                        messageWigdets.add(messageWigdet);
                      }
                    }
                    return Expanded(
                      child: ListView(
                        children: [...messageWigdets],
                      ),
                    );
                  }
                  return const CircularProgressIndicator.adaptive();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
