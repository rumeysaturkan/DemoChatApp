import 'package:chat_app/Themes/constants.dart';
import 'package:chat_app/widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserCard extends StatelessWidget {
  UserCard({super.key, required this.name, required this.email, this.onTap});
  String email;
  String name;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: darkGray, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    "assets/images/profilePhoto.jpg",
                    fit: BoxFit.cover,
                    height: 90,
                    width: 90,
                  ),
                ),
                /*  CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/images/profilePhoto.jpg"),
                ), */
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: name,
                      fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                    ),
                    CustomText(
                        text: email,
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium!.fontSize),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
