import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animations/animations.dart';

// final colorProvider = StateProvider<Color>((ref) => Colors.blue);
final colorProvider = ChangeNotifierProvider<ColorProvider>((ref) => ColorProvider());

// class ColorNotifier extends StateNotifier<Color> {
//   ColorNotifier() : super(Colors.red);
//
//   void setColor(Color newColor) {
//     state = newColor;
//   }
//
//   void getRandomColor() {
//     final random = Random();
//     final colors = [
//       Colors.red,
//       Colors.green,
//       Colors.blue,
//       Colors.orange,
//       Colors.purple,
//       Colors.pink,
//       Colors.yellow,
//     ];
//     state = colors[random.nextInt(colors.length)];
//   }
// }


class ColorProvider extends ChangeNotifier {
  Color _color = Colors.red;

  void setColor(Color color) {
    _color = color;
    notifyListeners();
  }

  Color get color => _color;

  Color getRandomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }
}
class AnimatedContainerExample extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorProviderRef = ref.watch(colorProvider);
    print("starting this page");

    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        title: Text('AnimatedContainer Example'),
      ),
      body: Center(
        child: OpenContainer(
          closedColor: colorProviderRef.color,
          openColor: colorProviderRef.getRandomColor(),
          transitionDuration: const Duration(milliseconds: 500),
          closedBuilder: (BuildContext _, VoidCallback openContainer) {
            return InkWell(
              onTap: openContainer,
              child: Container(
                child: Center(child: Text("start")),
                width: 200,
                height: 200,
              ),
            );
          },
          openBuilder: (BuildContext _, VoidCallback closeContainer) {
            return InkWell(
              onTap: closeContainer,
              child: Container(
                width: 400,
                height: 400,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          colorProviderRef.setColor(colorProviderRef.getRandomColor());
        },
        child: Icon(Icons.color_lens),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Center(
          child: Text('This is the second page.'),
        ),
      ),
    );
  }
}
