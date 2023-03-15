import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:periodt/ui/homepage/home_page.dart';

void main() {
  testWidgets('HomePage should have 4 Goddess Gossip texts', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(child: MaterialApp(home: HomePage())));
    await tester.pumpAndSettle();

    expect(find.text('Goddess Gossip'), findsNWidgets(4));
  });
}
