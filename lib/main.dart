import 'dart:convert';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:local_auth/local_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:json_theme/json_theme.dart';
// import 'package:periodt/ui/homepage/onboarding/onboarding.dart';
import 'routes/route_transitions.dart';
import 'components/widgets/list_view_new.dart';
import 'ui/homepage/home_page.dart';
import 'ui/auth/login_page.dart';
import 'newpage.dart';
import 'ui/auth/sign_up_page.dart';
import 'ui/homepage/newLogInPage.dart';

class TokenProvider extends StateNotifier<AsyncValue<String?>> {
  TokenProvider() : super(const AsyncValue.loading()) {
    _loadToken();
  }

  Box<String> tokenBox = Hive.box<String>('tokenBox');
  String? token;

  Future<void> _loadToken() async {
    token = tokenBox.get('token');
    if (token != null) {
      state = AsyncValue.data(token);
    } else {
      state = const AsyncValue.error('Token not found');
    }
  }

  Future<void> logout() async {
    // token = null;
    await tokenBox.delete('token');
  }

  // ... rest of the class
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  final localAuth = LocalAuthentication();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Future<bool> authenticateBiometric() async {
    bool isAvailable = await localAuth.canCheckBiometrics;
    if (isAvailable) {
      return await localAuth.authenticate(
        localizedReason: 'Authenticate to access the app',
        // useErrorDialogs: true,
        // stickyAuth: true,
      );
    }
    return false;
  }
  await Hive.openBox<String>('tokenBox');
  await Hive.openBox('jwt_tokens');
  await Hive.openBox('onboarding_status');
  final loginProvider = LoginProvider();
  final credentials = await loginProvider.readCredentials();
  bool isLoggedIn = false;
  if (credentials != null) {
    bool isAuthenticated = await authenticateBiometric();
    if (isAuthenticated) {
      isLoggedIn = await loginProvider.login(
          credentials['username']!, credentials['password']!);
    }
  }
  runApp(ProviderScope(
    // overrides: [
    //   tokenProvider.overrideWithValue(AsyncValue.data(Hive.box<String>('tokenBox').get('token')))
    // ],
    child: MyApp(theme: theme, isLoggedIn: isLoggedIn),
  ));
}

// final tokenProvider = FutureProvider<String?>((ref) async {
//   final tokenBox = await Hive.openBox<String>('tokenBox');
//   print(tokenBox.get('token'));
//   return tokenBox.get('token');
// });

class MyApp extends ConsumerWidget {
  MyApp({Key? key, required this.theme, required this.isLoggedIn}) : super(key: key);
  final ThemeData theme;
  final bool isLoggedIn;

  final tokenProvider =
      StateNotifierProvider<TokenProvider, AsyncValue<String?>>(
          (ref) => TokenProvider());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLifecycleHandler(
      ref: ref,
      tokenProvider: tokenProvider,
      child: MaterialApp(
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
            // nextScreen: ref.watch(tokenProvider).when(
            //       data: (token) {
            //         print(token);
            //         return token != null ?  HomePage() : LoginPage();
            //       },
          nextScreen: isLoggedIn ? HomePage() : LoginPage(),
                //   loading: () => const Center(child: CircularProgressIndicator()),
                //   error: (_, __) => LoginPage(),
                // ),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.topToBottom,
            backgroundColor: const Color(0xffFFDAD8)),
        onGenerateRoute: (settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case '/home':
              builder = (context) =>  HomePage();
              break;
            case '/login':
              builder = (context) =>  LoginPage();
              break;
            case '/signup':
              builder = (context) => SignUpPage();
              break;
            case '/newLogin':
              builder = (context) => FirstLoginPage();
              break;
            case '/animated':
              builder = (context) => AnimatedContainerExample();
              break;
            case '/example':
              builder = (context) => const ExampleScreen();
              break;
            case '/newSign':
              builder = (context) => SignUpPage();
              break;
            case '/selectWords':
              builder = (context) => SelectWords();
              break;
            case '/finishLogin':
              builder = (context) => FinishSignUp();
              break;
            default:
              return null;
          }
          return radialRevealTransitionBuilder(
              settings, builder); // Use the custom transition function here
        },
      ),
    );
  }
}


class AppLifecycleHandler extends StatefulWidget {
  final Widget child;
  final WidgetRef ref;
  final StateNotifierProvider<TokenProvider, AsyncValue<String?>> tokenProvider;

  AppLifecycleHandler({required this.child, required this.ref, required this.tokenProvider, Key? key}) : super(key: key);

  @override
  _AppLifecycleHandlerState createState() => _AppLifecycleHandlerState();
}

class _AppLifecycleHandlerState extends State<AppLifecycleHandler> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        final tokenProviderRef = widget.ref.read(widget.tokenProvider.notifier);
        await tokenProviderRef.logout();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

