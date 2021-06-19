import 'package:flutter/cupertino.dart';
import 'package:hotel_manager/creatorWidget/creater_widget_activity.dart';
import 'package:hotel_manager/creatorWidget/creater_widget_excursion.dart';
import 'package:hotel_manager/creatorWidget/creater_widget_spa.dart';
import 'package:hotel_manager/creatorWidget/creater_widget_text.dart';
import 'package:hotel_manager/factory/widget_factory.dart';

class WidgetFactoryProvider extends InheritedWidget {
  final WidgetFactory widgetFactory = new WidgetFactory();

  WidgetFactoryProvider({Widget ?child,}) : super(child: child!) {
    widgetFactory.registerCreator(WidgetTextCreator());
    widgetFactory.registerCreator(WidgetExcursionCreator());
    widgetFactory.registerCreator(WidgetSpaCreator());
    widgetFactory.registerCreator(WidgetActivityCreator());
  }

  static WidgetFactoryProvider of(BuildContext context) {
    final WidgetFactoryProvider result = context.dependOnInheritedWidgetOfExactType<WidgetFactoryProvider>() ?? WidgetFactoryProvider();
    assert(result != null, 'No WidgetFactoryProvider found in context');
    return result;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
