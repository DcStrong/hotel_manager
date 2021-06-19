import 'package:hotel_manager/components/widget/detail_card/card_with_excursion.dart';
import 'package:hotel_manager/interface/widget_creator.dart';
import 'package:hotel_manager/interface/model_interface.dart';
import 'package:hotel_manager/model/card_with_excursion.dart';

class WidgetExcursionCreator implements WidgetCreatorInterface {
  CardWithExcursionType createWidget(ModelInterface model) {
    if(model is CardWithExcursionModel) {
      return CardWithExcursionType(cardModel: model,);
    }
    throw Exception('Невозможно вернуть виджет');
  }

  isCanCreateWidget(ModelInterface model) {
    return model is CardWithExcursionModel;
  }
}