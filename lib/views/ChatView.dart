import 'package:chat_app/Themes/constants.dart';
import 'package:chat_app/controllers/ChatViewController.dart';
import 'package:chat_app/services/Authentication.dart';
import 'package:chat_app/services/Database.dart';
import 'package:chat_app/widgets/CustomText.dart';
import 'package:chat_app/widgets/MessageBallon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/CustomBackButton.dart';

class ChatView extends StatefulWidget {
  static var messageContent;
  ChatView({super.key, required this.name, required this.uid});
  String name;

  String uid;
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  /*  bool _needsScroll = false; */

/*   _scrollToEnd() async {
    _controller.animateTo(_controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  } */

  FocusNode focus = FocusNode();
  final controller = Get.put(ChatViewController());
  final AuthController authController = Get.put(AuthController());
  late GlobalKey<FormState> _formKey;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    String roomId =
        Database().chatRoomId(authController.auth.currentUser!.uid, widget.uid);
    var content;
    var color;
    var alignment;
    var topLeft;
    var topRight;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.9),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomBackButton(),
                    const SizedBox(
                      width: 20,
                    ),
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage("assets/images/profilePhoto.jpg"),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    CustomText(
                      text: widget.name,
                      fontSize:
                          Theme.of(context).textTheme.headlineSmall?.fontSize,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: StreamBuilder(
                  stream: Database()
                      .db
                      .collection('messages')
                      .doc(roomId)
                      .collection("message")
                      .orderBy("time", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                    if (snapshot.hasData) {
                      final messages = snapshot.data!.docs;
                      List<Widget> messageWigdets = [];
                      for (var message in messages) {
                        if (authController.currentUser.uid ==
                            message['senderId'].toString()) {
                          color = purple;
                          alignment = FractionalOffset.centerRight;
                          topRight = Radius.zero;
                          topLeft = Radius.circular(20);
                        } else {
                          color = green;
                          alignment = FractionalOffset.centerLeft;
                          topLeft = Radius.zero;
                          topRight = Radius.circular(20);
                        }
                        content = message['content'];

                        final messageWigdet = MessageBalloon(
                            topLeft: topLeft,
                            topRight: topRight,
                            width: MediaQuery.of(context).size.width * 0.8,
                            text: content,
                            color: color,
                            alignment: alignment);
                        messageWigdets.add(messageWigdet);
                      }
                      return ListView.builder(
                          reverse: true,
                          controller: _controller,
                          itemCount: messageWigdets.length,
                          itemBuilder: (BuildContext context, int index) {
                            return messageWigdets[index];
                          });
                    }
                    return const CircularProgressIndicator.adaptive();
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    onChanged: () {
                      _formKey.currentState!.save();
                    },
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: height * 0.35,
                      ),
                      child: TextFormField(
                        maxLines: null,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        focusNode: focus,
                        controller: controller.messageController,
                        onSaved: (input) {
                          setState(() {
                            ChatView.messageContent = input!;
                          });
                        },
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: "Send a message...",
                          hintStyle: const TextStyle(color: Color(0xffaaaaaa)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Theme.of(context).primaryIconTheme.color,
                            ),
                            onPressed: () {
                              setState(() {
                                Database().createMessage(
                                    AuthController()
                                        .auth
                                        .currentUser!
                                        .uid
                                        .toString(),
                                    controller.messageController.text.trim(),
                                    roomId);
                                controller.messageController.text = "";
                              });
                              focus.requestFocus();
                            },
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
