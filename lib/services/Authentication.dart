import 'package:chat_app/services/Database.dart';
import 'package:chat_app/views/ButtomNavigation.dart';
import 'package:chat_app/views/GetStartedView.dart';
import 'package:chat_app/views/LoginView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/UserModel.dart';
import '../views/UsersView.dart';

class AuthController extends GetxController {
  static AuthController AuthInstance = Get.find();
  late Rx<User?> firebaseUser;
  late UserModel currentUser;
  // late Rx<GoogleSignInAccount?> googleSignInAccount;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // Firebase user a realtime stream
  Stream<User?> get user => auth.authStateChanges();

  //Streams the firestore user from the firestore collection
  Stream<UserModel> streamFirestoreUser() {
    print('streamFirestoreUser()');

    return Database()
        .db
        .doc('/users/${firebaseUser.value!.uid}')
        .snapshots()
        .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  }

  //get the firestore user from the firestore collection
  Future<UserModel> getFirestoreUser() {
    return Database().db.doc('/users/${firebaseUser.value!.uid}').get().then(
        (documentSnapshot) => UserModel.fromMap(documentSnapshot.data()!));
  }

  @override
  void onReady() {
    super.onReady();
    // signOut();
    firebaseUser = Rx<User?>(auth.currentUser);

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

    // googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);
    // googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    // ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  handleAuthChanged(firebaseUser) async {
    //get user data from firestore

    if (firebaseUser == null) {
      Get.offAll(GetStartedView());
    } else {
      Get.offAll(ButtomNavigationView());
    }
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() => GetStartedView());
    } else {
      var response = await getFirestoreUser();
      currentUser = response;

      Get.offAll(ButtomNavigationView());
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      // this is solely for the Firebase Auth Exception
      // for example : password did not match
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e.message);
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future register(String fullname, String email, String password) async {
    try {
      UserCredential result = (await auth.createUserWithEmailAndPassword(
          email: email, password: password));
      User? user = result.user;

      await Database.instance.createUser(
        fullname,
        user?.uid,
        user?.email,
      );
      /*    if (result.additionalUserInfo!.isNewUser) {
        await Get.to(GenrePage());
      } else {
        //Continue with app flow
      } */
    } catch (firebaseAuthException) {
      Get.snackbar(
        "Error",
        firebaseAuthException.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    await auth.signOut();
  }
}
