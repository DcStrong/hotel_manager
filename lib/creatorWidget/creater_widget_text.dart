import 'package:hotel_manager/components/widget/detail_card/card_with_text.dart';
import 'package:hotel_manager/interface/widget_creator.dart';
import 'package:hotel_manager/model/card_with_text.dart';
import 'package:hotel_manager/interface/model_interface.dart';

class WidgetTextCreator implements WidgetCreatorInterface {
  CardWithText createWidget(ModelInterface model) {
    if(model is CardWithTextModel) {
      return CardWithText(cardModel: model);
    }
    throw Exception('Невозможно вернуть виджет');
  }

  isCanCreateWidget(ModelInterface model) {
    return model is CardWithTextModel;
  }
}