import 'package:emart_seller/controllers/auth_controller.dart';
import 'package:emart_seller/views/home_screen/home.dart';
import 'package:emart_seller/views/widgets/our_button.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/text_style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AuthController>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.heightBox,
                normalText(text: welcome, size: 18.0),
                20.heightBox,
                Row(
                  children: [
                    Image.asset(
                      icLogo,
                      width: 70,
                      height: 70,
                    ).box.border(color: white).rounded.padding(const EdgeInsets.all(8)).make(),
                    10.widthBox,
                    boldText(text: appname, size: 20.0),
                  ],
                ),
                40.heightBox,
                normalText(text: loginTo, size: 18.0, color: lightGrey),
                10.heightBox,
                Obx(
                  () => Column(
                    children: [
                      TextFormField(
                        controller: controller.emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: purpleColor,
                          ),
                          border: InputBorder.none,
                          hintText: emailHint,
                        ),
                      ),
                      10.heightBox,
                      TextFormField(
                        controller: controller.passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: purpleColor,
                          ),
                          border: InputBorder.none,
                          hintText: passwordHint,
                        ),
                      ),
                      10.heightBox,
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: normalText(text: forgotPassword, color: purpleColor),
                        ),
                      ),
                      20.heightBox,
                      SizedBox(
                        width: context.screenWidth - 100,
                        child: controller.isloading.value
                            ? Center(child: loadingIndicator())
                            : ourButton(
                                title: login,
                                onPress: () async {
                                  controller.isloading(true);

                                  await controller.loginMethod(context: context).then((value) {
                                    if (value != null) {
                                      VxToast.show(context, msg: "Logged in");
                                      controller.isloading(false);
                                      Get.offAll(() => const Home());
                                    } else {
                                      controller.isloading(false);
                                    }
                                  });
                                },
                              ),
                      )
                    ],
                  ).box.white.rounded.outerShadowMd.padding(const EdgeInsets.all(8)).make(),
                ),
                10.heightBox,
                Center(child: normalText(text: anyProblem, color: lightGrey)),
                const Spacer(),
                Center(child: boldText(text: credit)),
                20.heightBox
              ],
            ),
          ),
        ));
  }
}
