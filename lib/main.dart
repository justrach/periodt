import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:periodt/signupPage.dart';

import 'home_page.dart';
import 'loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox<String>("tokenBox");

  runApp(ProviderScope(child: MyApp()));
}
final tokenProvider = FutureProvider<String?>((ref) async {
  final tokenBox = await Hive.openBox<String>('tokenBox');
  print(tokenBox.get('token'));
  return tokenBox.get('token');
});

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ref.watch(tokenProvider).when(
        data: (token) {
          print(token);
          return token != null ? HomePage() : LoginPage();
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => LoginPage(),
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/home":
            return MaterialPageRoute(builder: (_) => HomePage());
          case "/signup":
            return MaterialPageRoute(builder: (_) => SignUpPage());
          default:
            return null;
        }
      },
    );
  }
}