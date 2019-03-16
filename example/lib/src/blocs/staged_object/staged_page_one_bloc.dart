import 'package:frideos_core/frideos_core.dart';

import 'package:frideos_light/frideos_light.dart';

import '../../blocs/bloc.dart';

class StagedPageOneBloc extends BlocBase {
  StagedPageOneBloc() {
    print('-------StagedPageOne BLOC--------');
    totalWidgets.value = 0;
  }

  final tunnelSender = MapSender<int, Stage>();
  final tunnelSenderStr = StreamedSender<String>();
  final totalWidgets = StreamedValue<int>();

  int indexStage = 0;
  final widgetsStagesMap = Map<int, Stage>();

  void addStage(Stage stage) {
    widgetsStagesMap[indexStage] = stage;
    indexStage++;
    tunnelSender.send(widgetsStagesMap);
    print('Map: $widgetsStagesMap');
    totalWidgets.value = widgetsStagesMap.length;
  }

  void resetMap() {
    widgetsStagesMap.clear();
    indexStage = 0;
    totalWidgets.value = 0;
  }

  @override
  void dispose() {
    print('-------StagedPageOne BLOC DISPOSE--------');
    totalWidgets.dispose();
  }
}
