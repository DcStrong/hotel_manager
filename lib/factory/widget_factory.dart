// WidgetFactory(): WidgetInterface
//   registerCreator(Creator: CreatorInterface)
//     this.creators.push(Creator)

//   createWidget(model: ModelInterface): WidgetInterface
//     return this.creators.some(Creator => Creator.createWidget(model))
// 

import 'package:hotel_manager/interface/model_interface.dart';
import 'package:hotel_manager/interface/widget_creator.dart';

class WidgetFactory {
  List<WidgetCreatorInterface> creators = [];

  // ignore: non_constant_identifier_names
  registerCreator(WidgetCreatorInterface creator) {
    creators.add(creator);
    print(creators);
  }

  createWidget(ModelInterface model) {
    WidgetCreatorInterface creator = creators.firstWhere((creator) => creator.isCanCreateWidget(model));
    print(creator);
    return creator.createWidget(model);
  }
}