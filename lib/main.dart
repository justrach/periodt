import 'dart:convert';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:json_theme/json_theme.dart';
import 'routes/route_transitions.dart';
import 'signup_page.dart';
import 'components/widgets/list_view_new.dart';
import 'ui/homepage/home_page.dart';
import 'loginpage.dart';
import 'newpage.dart';
import 'ui/test/testpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox<String>('tokenBox');
  await Hive.openBox('jwt_tokens');


  runApp(ProviderScope(
      child: MyApp(
    theme: theme,
  )));
}

final tokenProvider = FutureProvider<String?>((ref) async {
  final tokenBox = await Hive.openBox<String>('tokenBox');
  print(tokenBox.get('token'));
  return tokenBox.get('token');
});

class MyApp extends ConsumerWidget {
  const MyApp({Key? key, required this.theme}) : super(key: key);
  final ThemeData theme;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: AnimatedSplashScreen(
          duration: 2000,
          splash: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LoadingAnimationWidget.waveDots(
                size: 30,
                color: Colors.pink,
              ),
              const Text(
                'perIodt',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          nextScreen: ref.watch(tokenProvider).when(
                data: (token) {
                  print(token);
                  return token != null ? HomePage() : LoginPage();
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => LoginPage(),
              ),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.topToBottom,
          backgroundColor: const Color(0xffFFDAD8)),
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/home':
            builder = (context) => HomePage();
            break;
          case '/signup':
            builder = (context) => SignUpPage();
            break;
          case '/animated':
            builder = (context) => AnimatedContainerExample();
            break;
          case '/example':
            builder = (context) => const ExampleScreen();
            break;
          case '/newSign':
            builder = (context) => TestPage();
            break;
          default:
            return null;
        }
        return radialRevealTransitionBuilder(settings, builder); // Use the custom transition function here
      },

    );
  }
}
