import 'package:hotel_manager/interface/model_interface.dart';
import 'package:hotel_manager/interface/widget_interface.dart';

abstract class WidgetCreatorInterface {
  WidgetInterface createWidget(ModelInterface model);
  
  bool isCanCreateWidget(ModelInterface model);
}

