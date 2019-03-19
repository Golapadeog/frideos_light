import 'package:flutter/material.dart';

import 'package:frideos_core/frideos_core.dart';

import 'package:frideos_light/frideos_light.dart';

import '../blocs/bloc.dart';
import '../blocs/animated_object_bloc.dart';

class AnimatedObjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AnimatedObjectBloc bloc = BlocProvider.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedObject page'),
        ),
        body: Container(
          color: Colors.blueGrey[100],
          child: Column(
            children: <Widget>[
              Container(
                height: 20,
              ),
              ValueBuilder<AnimatedStatus>(
                streamed: bloc.scaleAnimation.status,
                builder: (context, snapshot) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      snapshot.data == AnimatedStatus.active
                          ? RaisedButton(
                              color: Colors.lightBlueAccent,
                              child: const Text('Reset'),
                              onPressed: bloc.reset,
                            )
                          : Container(),
                      snapshot.data == AnimatedStatus.stop
                          ? RaisedButton(
                              color: Colors.lightBlueAccent,
                              child: const Text('Start'),
                              onPressed: bloc.start,
                            )
                          : Container(),
                      snapshot.data == AnimatedStatus.active
                          ? RaisedButton(
                              color: Colors.lightBlueAccent,
                              child: const Text('Stop'),
                              onPressed: bloc.stop,
                            )
                          : Container(),
                    ],
                  );
                },
              ),
              Expanded(
                child: ValueBuilder<double>(
                    streamed: bloc.scaleAnimation,
                    builder: (context, snapshot) {
                      return Transform.scale(
                        scale: snapshot.data,
                        // No need for StreamBuilder here, the widget
                        // is already updating
                        child: Transform.rotate(
                          angle: bloc.rotationAnimation.value,
                          // Same here
                          //
                          child: Transform(
                            transform:
                                Matrix4.rotationY(bloc.rotationAnimation.value),
                            child: const FlutterLogo(),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
