import 'dart:io';

import 'package:emart_seller/controllers/profile_controller.dart';
import 'package:emart_seller/views/widgets/custom_textfield.dart';
import 'package:emart_seller/views/widgets/loading_indicator.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import '../widgets/text_style.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    print(controller.nameController.text);
    print("🟥🟥");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: white),
          title: boldText(
            text: editProfile,
            size: 22.0,
          ),
          actions: [
            controller.isloading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);

                      //if image is not selected
                      if (controller.profileImgPath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImageLink = controller.snapshotData['imageUrl'];
                      }

                      //if old password matches data base
                      if (controller.snapshotData['password'] == controller.oldpassController.text) {
                        await controller.updateProfile(
                          imgUrl: controller.profileImageLink,
                          name: controller.nameController.text,
                          password: controller.newpassController.text,
                        );

                        controller.changeAuthPassword(
                          email: controller.snapshotData['email'],
                          password: controller.oldpassController.text,
                          newPassword: controller.newpassController.text,
                        );
                        VxToast.show(context, msg: "Updated");
                      } else if (controller.oldpassController.text.isEmptyOrNull && controller.newpassController.text.isEmptyOrNull) {
                        await controller.updateProfile(
                          imgUrl: controller.profileImageLink,
                          name: controller.nameController.text,
                          password: controller.snapshotData['password'],
                        );
                      } else {
                        VxToast.show(context, msg: "Some error occured");
                        controller.isloading(false);
                      }
                    },
                    child: normalText(text: save, color: purpleColor),
                  ).box.color(white).height(35).roundedLg.make(),
            10.widthBox,
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //if data image url and controller path is empty
              controller.snapshotData['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProduct,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.height(90).width(100).clip(Clip.antiAlias).make()

                  //if data is not empty but controller path is empty
                  : controller.snapshotData['imageUrl'] != '' && controller.profileImgPath.isEmpty
                      ? Image.network(
                          controller.snapshotData['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()

                      //if both are empty
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),

              //     Image.asset(
              //     imgProduct,
              //     width: 150,
              // ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: white,
                ),
                onPressed: () {
                  controller.changeImage(context);
                },
                child: normalText(text: changeImage, color: fontGrey),
              ),
              10.heightBox,
              const Divider(color: white),
              customTextField(label: name, hint: "eg. Dhruv Devs", controller: controller.nameController),
              30.heightBox,
              Align(
                alignment: Alignment.centerLeft,
                child: boldText(text: "Change your password"),
              ),
              10.heightBox,
              customTextField(label: oldPassword, hint: passwordHint, controller: controller.oldpassController),
              10.heightBox,
              customTextField(label: newPassword, hint: passwordHint, controller: controller.newpassController),
            ],
          ),
        ),
      ),
    );
  }
}
