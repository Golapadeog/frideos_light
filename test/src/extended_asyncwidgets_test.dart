import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frideos_core/frideos_core.dart';
import 'package:frideos_light/frideos_light.dart';

void main() {
  //
  // StreamedWidget
  //
  testWidgets('StreamedWidget NoDataChild', (WidgetTester tester) async {
    final streamedValue = StreamedValue<Widget>();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: StreamedWidget(
          stream: streamedValue.outStream,
          builder: (context, snapshot) => snapshot.data,
          noDataChild: const Text('NoData'),
        ),
      ),
    ));

    expect(find.text('testwidget'), findsNothing);
    expect(find.text('NoData'), findsOneWidget);

    streamedValue.value = const Text('testwidget');

    await tester.pumpAndSettle();

    expect(find.text('testwidget'), findsOneWidget);

    streamedValue.dispose();
  });

  testWidgets('StreamedWidget onNoData callback', (WidgetTester tester) async {
    final streamedValue = StreamedValue<Widget>();

    var str = '';

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: StreamedWidget(
          stream: streamedValue.outStream,
          builder: (context, snapshot) => snapshot.data,
          onNoData: () {
            str = 'callback';
            return const Text('NoData');
          },
        ),
      ),
    ));

    expect(find.text('testwidget'), findsNothing);

    expect(str, 'callback');
    expect(find.text('NoData'), findsOneWidget);

    streamedValue.value = const Text('testwidget');

    await tester.pumpAndSettle();

    expect(find.text('testwidget'), findsOneWidget);

    streamedValue.dispose();
  });
  //
  // ValueBuilder
  //
  testWidgets('ValueBuilder widget', (WidgetTester tester) async {
    final streamedValue = StreamedValue<String>(initialData: 'initialData');

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ValueBuilder<String>(
          streamed: streamedValue,
          builder: (context, snapshot) => Text(snapshot.data),
        ),
      ),
    ));

    await tester.pump();

    expect(find.text('initialData'), findsOneWidget);

    streamedValue.value = 'ValueBuilder';

    await tester.pumpAndSettle();

    expect(find.text('ValueBuilder'), findsOneWidget);

    streamedValue.value = 'Text changed';

    await tester.pumpAndSettle();

    expect(find.text('Text changed'), findsOneWidget);
  });
}
