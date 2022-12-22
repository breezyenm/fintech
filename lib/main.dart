import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/firebase_options.dart';
import 'package:qwid/providers/registry.dart';
import 'package:provider/provider.dart';
import 'package:qwid/screens/onboarding/login.dart';
import 'package:qwid/screens/onboarding/onboarding.dart';

import 'providers/brain/home_provider.dart';
import 'providers/brain/onboarding.dart';
import 'providers/brain/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<HomeProvider>(builder: (context, pro, child) {
        return FutureBuilder(
            future: pro.timing == null ? pro.getTiming(context) : null,
            builder: (context, snapshot) {
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  pro.handleUserInteraction(context);
                },
                onPanDown: (dragDownDetails) {
                  pro.handleUserInteraction(context);
                },
                child: MaterialApp(
                  title: 'qwid',
                  theme: ThemeData(
                    dividerColor: CustomColors.stroke,
                    dividerTheme: const DividerThemeData(
                      space: 0,
                      color: CustomColors.stroke,
                    ),
                    scaffoldBackgroundColor: CustomColors.background,
                    appBarTheme: const AppBarTheme(
                      iconTheme: IconThemeData(
                        color: CustomColors.black,
                      ),
                      backgroundColor: CustomColors.background,
                      elevation: 0,
                      // shape: ContinuousRectangleBorder(
                      //   side: BorderSide(
                      //     width: 0.5,
                      //     color: CustomColors.grey6,
                      //   ),
                      // ),
                      centerTitle: true,
                      titleTextStyle: CustomTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: CustomColors.black,
                      ),
                    ),
                  ),
                  home: Navigator(
                    initialRoute: 'auth',
                    key: pro.navigatorKey,
                    onGenerateRoute: (settings) {
                      return MaterialPageRoute(
                        builder: (context) => Consumer<OnBoarding>(
                            builder: (context, pro, child) {
                          return FutureBuilder(
                              future: Future.wait([
                                pro.check(),
                                Provider.of<SettingsProvider>(context,
                                        listen: false)
                                    .checkFingerprint(),
                              ]),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.done ||
                                    Provider.of<SettingsProvider>(context,
                                                listen: false)
                                            .fingerprint !=
                                        null) {
                                  return (pro.isFirst ?? true)
                                      ? const OnboardingPage()
                                      : const LoginPage();
                                }
                                return const Scaffold(
                                  body: Center(
                                    child: CircularProgressIndicator.adaptive(
                                      valueColor: AlwaysStoppedAnimation(
                                        CustomColors.primary,
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }),
                      );
                    },
                  ),
                ),
              );
            });
      }),
    );
  }
}
