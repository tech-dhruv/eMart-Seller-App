import 'package:emart_seller/controllers/auth_controller.dart';
import 'package:emart_seller/controllers/products_controller.dart';
import 'package:emart_seller/views/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'const/const.dart';
import 'controllers/home_controller.dart';
import 'controllers/orders_controller.dart';
import 'controllers/profile_controller.dart';
import 'firebase_options.dart';
import 'views/auth_screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){
    super.initState();
    checkUser();
  }

  var isLoggedin = false;

  checkUser() async{
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          isLoggedin = false;
        } else{
          isLoggedin = true;
        }
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
      initialBinding: Bind(),
      home: isLoggedin ? const Home() : const LoginScreen(),
    );
  }
}

class Bind implements Bindings {
  @override
  void dependencies() {
    injection();
  }
}

injection() {
  Get.put(HomeController(), permanent: true);
  Get.put(AuthController(), permanent: true);
  //Get.put(ProfileController(), permanent: true);
  Get.put(OrdersController(), permanent: true);
  Get.put(ProductsController(), permanent: true);
}
