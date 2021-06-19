import 'package:hotel_manager/components/widget/detail_card/card_with_spa.dart';
import 'package:hotel_manager/interface/widget_creator.dart';
import 'package:hotel_manager/model/card_with_spa.dart';
import 'package:hotel_manager/interface/model_interface.dart';

class WidgetSpaCreator implements WidgetCreatorInterface {
  CardWithSpaType createWidget(ModelInterface model) {
    if(model is CardWithSpaModel) {
      return CardWithSpaType(cardModel: model);
    }
    throw Exception('Невозможно вернуть виджет');
  }

  isCanCreateWidget(ModelInterface model) {
    return model is CardWithSpaModel;
  }
}