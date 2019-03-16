import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frideos_core/frideos_core.dart';
import 'package:frideos_light/frideos_light.dart';

class Model {
  Model({this.counter, this.text});

  int counter;
  String text;
}

class AppState extends AppStateModel {
  AppState() {
    print('-------APP STATE INIT--------');
    model.value = Model(counter: 33, text: 'Lorem ipsum');
  }

  final model = StreamedValue<Model>();

  @override
  void init() {}

  @override
  void dispose() {
    model.dispose();
  }
}

class App extends StatelessWidget {
  final AppState appState;

  App({@required this.appState});

  @override
  Widget build(BuildContext context) {
    return AppStateProvider<AppState>(
      appState: appState,
      child: MaterialPage(),
    );
  }
}

class MaterialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = AppStateProvider.of<AppState>(context).model;

    return ValueBuilder<Model>(
        stream: model,
        builder: (context, snapshot) {
          return MaterialApp(
            home: Container(
              child: Column(
                children: <Widget>[
                  Text(model.value.text),
                  Text(model.value.counter.toString()),
                ],
              ),
            ),
          );
        });
  }
}

void main() {
  testWidgets('AppStateProvider', (WidgetTester tester) async {
    final appState = AppState();

    await tester.pumpWidget(App(
      appState: appState,
    ));

    expect(find.text('Lorem ipsum'), findsOneWidget);
    expect(find.text('33'), findsOneWidget);
  });
}