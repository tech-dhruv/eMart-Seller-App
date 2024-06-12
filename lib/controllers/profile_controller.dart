import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  late QueryDocumentSnapshot snapshotData;

  var profileImgPath = ''.obs;

  var profileImageLink = '';

  var isloading = false.obs;

  //text-field
  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();

  //shop controllers
  var shopNameController = TextEditingController();
  var shopAddressController = TextEditingController();
  var shopMobileController = TextEditingController();
  var shopWebsiteController = TextEditingController();
  var shopDescController = TextEditingController();

  changeImage(context) async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    var filename = basename(profileImgPath.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imgUrl}) async {
    var store = firestore.collection(vendorsCollection).doc(currentUser!.uid);
    await store.set({'vendor_name': name, 'password': password, 'imageUrl': imgUrl}, SetOptions(merge: true));
    isloading(false);
  }

  void changeAuthPassword({email, password, newPassword}) async {
    final user = await FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(email: user!.email ?? "", password: password);

    user.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword);
    }).catchError((err) {
      print(err.toString());
    });
  }

  updateShop({shopname, shopaddress, shopmobile, shopwebsite, shopdesc}) async {
    var store = firestore.collection(vendorsCollection).doc(currentUser!.uid);
    await store.set({
      'shop_name': shopname,
      'shop_address': shopaddress,
      'shop_mobile': shopmobile,
      'shop_desc': shopdesc,
    }, SetOptions(merge: true));
    isloading(false);
  }
}
