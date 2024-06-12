import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../const/const.dart';

class AuthController extends GetxController {
  var isloading = false.obs;

  //textcontrollers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // //storing data method
  // storeUserData({name, password, email}) async {
  //   DocumentReference store = await firestore.collection(usersCollection).doc(currentUser!.uid);
  //   store.set({
  //     'name': name,
  //     'password': password,
  //     'email': email,
  //     'imageUrl': '',
  //     'id': currentUser!.uid,
  //     'cart_count' : "00",
  //     'wishlist_count' : "00",
  //     'order_count' : "00",
  //   });
  // }

  //signout method
  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
