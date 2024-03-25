import 'package:flutter/foundation.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:mr_yummy_v2/bindings/bindings.dart';
import 'package:mr_yummy_v2/cart_page.dart';
import 'package:mr_yummy_v2/details_page.dart';
import 'package:mr_yummy_v2/general_page.dart';
import 'package:mr_yummy_v2/middleware/midlleware.dart';
import 'package:mr_yummy_v2/order_page.dart';
import 'package:mr_yummy_v2/sign_up.dart';
import 'package:mr_yummy_v2/waiting_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'otp_page.dart';

SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: mybindings(),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/details_page", page: () => details_page()),
        GetPage(name: "/cart_page", page: () => cart_page()),
        GetPage(name: "/order_page", page: () => order_page()),
        GetPage(
          name: "/",
          page: () => MyHomePage(
            title: "",
          ),
        ),
        GetPage(
          middlewares: [existeduser()],
          name: "/sign_up",
          page: () => sign_up(),
        ),
        GetPage(name: "/waiting", page: () => waiting()),
        GetPage(name: "/otp", page: () => otp()),
        GetPage(name: "/general_page", page: () => general_page()),
      ],
      theme: ThemeData(fontFamily: "Rubik"),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentindex = 0;
  final controller = PageController();
  List<Image> images = [
    Image.asset(
      "assets/entry2.jpg",
      fit: BoxFit.cover,
    ),
    Image.asset("assets/entry3.jpg", fit: BoxFit.cover),
    Image.asset(
      "assets/entry.jpg",
      fit: BoxFit.cover,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 70 / 100,
            child: PageView.builder(
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  currentindex = value;
                });
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                return images[index];
              },
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 30 / 100,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: (MediaQuery.of(context).size.height * 30 / 100) *
                      70 /
                      100,
                  child: Center(
                    child: Text(
                        textAlign: TextAlign.center,
                        "تعشّق المذاق، تفضل إلى مطعمنا للوجبات السريعة واستمتع بتشكيلة شهية من البرجرات اللذيذة، والوجبات الشهية، والمقبلات الرائعة، والحلويات المغرية.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ),
                Container(
                  height: (MediaQuery.of(context).size.height * 30 / 100) *
                      30 /
                      100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: SmoothPageIndicator(
                          controller: controller,
                          count: 3,
                          effect: WormEffect(
                              dotWidth: 50,
                              dotColor: Colors.grey,
                              activeDotColor: Colors.red),
                        ),
                      ),
                      Container(
                        height:
                            (MediaQuery.of(context).size.height * 30 / 100) *
                                20 /
                                100,
                        width: MediaQuery.of(context).size.width * 40 / 100,
                        child: RaisedButton(
                            color: Colors.red,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide: BorderSide.none),
                            onPressed: () {
                              if (currentindex != 2) {
                                controller.nextPage(
                                    duration: Duration(seconds: 1),
                                    curve: Curves.fastOutSlowIn);
                              } else {
                                Get.toNamed("/sign_up");
                              }
                            },
                            child: Text(
                              currentindex != 2 ? "Next" : "Enter",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
