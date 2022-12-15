import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static Database instance = Database();
  late FirebaseFirestore db;
  Database() {
    db = FirebaseFirestore.instance;
  }
  String messagesCollection = "messages";
  String userMessageCollection = "message";

  Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
    //use a Async-await function to get the data
    final data = await db.collection("users").get();
    return data; //get the data
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  bool createGroup(String user1, String user2) {
    try {
      String roomid = chatRoomId(user1, user2);
      print(roomid);
      db
          .collection(messagesCollection)
          .doc(roomid)
          .collection(userMessageCollection);
      db.collection(messagesCollection).doc(roomid).set({
        "contact1": user1,
        "contact2": user2,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future createMessage(String user, String content, String roomId) async {
    try {
      await db
          .collection(messagesCollection)
          .doc(roomId)
          .collection(userMessageCollection)
          .add({"content": content, "senderId": user, "time": Timestamp.now()});
    } catch (e) {}
  }

  Future createUser(String fullname, String? uid, String? email) async {
    try {
      await db
          .collection("users")
          .doc(uid)
          .set({"email": email, "uid": uid, "fullname": fullname});
    } catch (e) {}
  }

/*   Future<void> uploadFile(String uid, String downloadUrl) async {
    db.collection(userCollection).doc(uid).update({
      "imagePath": downloadUrl,
    });
  } */

/*   Future<void> updateUser(String fullname, String email, String? uid) async {
    try {
      db
          .collection(userCollection)
          .doc(uid) // <-- Doc ID where data should be updated.
          .update({
        "fullname": fullname,
        "email": email,
      });
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Email and Name Surname can't be changed");
    }
  } */
}
