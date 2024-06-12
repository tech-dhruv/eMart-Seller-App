import 'package:emart_seller/controllers/profile_controller.dart';
import 'package:emart_seller/views/widgets/custom_textfield.dart';
import 'package:emart_seller/views/widgets/loading_indicator.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import '../widgets/text_style.dart';

class ShopSettings extends StatefulWidget {
  const ShopSettings({super.key});

  @override
  State<ShopSettings> createState() => _ShopSettingsState();
}

class _ShopSettingsState extends State<ShopSettings> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: white),
          title: boldText(
            text: shopSettings,
            size: 22.0,
          ),
          actions: [
            controller.isloading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.updateShop(
                        shopaddress: controller.shopAddressController.text.trim(),
                        shopname: controller.shopNameController.text.trim(),
                        shopmobile: controller.shopMobileController.text.trim(),
                        shopwebsite: controller.shopWebsiteController.text.trim(),
                        shopdesc: controller.shopDescController.text.trim(),
                      );
                      //ignore: use_build_context_synchronously
                      VxToast.show(context, msg: "Shop updated");
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
              customTextField(
                label: shopName,
                hint: nameHint,
                controller: controller.shopNameController,
              ),
              10.heightBox,
              customTextField(
                label: address,
                hint: shopAddressHint,
                controller: controller.shopAddressController,
              ),
              10.heightBox,
              customTextField(
                label: mobile,
                hint: shopMobileHint,
                controller: controller.shopMobileController,
              ),
              10.heightBox,
              customTextField(
                label: website,
                hint: shopWebsiteHint,
                controller: controller.shopWebsiteController,
              ),
              10.heightBox,
              customTextField(
                isDesc: true,
                label: description,
                hint: shopDescHint,
                controller: controller.shopDescController,
              )
            ],
          ),
        ),
      ),
    );
  }
}
