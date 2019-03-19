import 'package:flutter/material.dart';

import 'package:frideos_light/frideos_light.dart';

import '../../blocs/multiple_selection/multiple_selection_page_two_bloc.dart';
import '../../models/item_model.dart';

class MultipleSelectionPageTwo extends StatelessWidget {
  const MultipleSelectionPageTwo({this.bloc});

  final PageTwoBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Two'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ValueBuilder<List<Item>>(
                  streamed: bloc.items,
                  builder: (c, s) {
                    return GridView.builder(
                        itemCount: s.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          final item = s.data[index];
                          return Container(
                            padding: const EdgeInsets.all(10),
                            child: InkWell(
                              child: Column(
                                children: <Widget>[
                                  Text(item.name),
                                  Container(
                                      height: 100,
                                      width: 100,
                                      color: item.color),
                                  Expanded(child: Text(item.description)),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  noDataChild: const Text('items list empty.'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
