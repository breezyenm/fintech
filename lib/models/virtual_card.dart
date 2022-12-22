import 'package:qwid/models/virtual_card_data.dart';

class VirtualCard {
  String? virtualCardId,
      virtualCardSource,
      virtualCardName,
      virtualCardCur,
      virtualCardBalance,
      virtualCardColor,
      virtualCardAlias;
  int? id, userId, virtualCardStatus;
  bool? virtualCardFreeze;
  VirtualCardData? virtualCardData;

  VirtualCard({
    this.virtualCardAlias,
    this.virtualCardBalance,
    this.virtualCardColor,
    this.virtualCardCur,
    this.virtualCardData,
    this.virtualCardFreeze,
    this.virtualCardId,
    this.virtualCardName,
    this.virtualCardSource,
    this.virtualCardStatus,
    this.userId,
    this.id,
  });

  static VirtualCard fromMap({
    required Map<String, dynamic> details,
    VirtualCardData? virtualCardData,
  }) =>
      VirtualCard(
        virtualCardAlias: details['virtualCardAlias'],
        virtualCardBalance: details['virtualCardBalance'],
        virtualCardColor: details['virtualCardColor'],
        virtualCardCur: details['virtualCardCur'],
        id: details['id'],
        userId: details['userId'],
        virtualCardData: virtualCardData,
        virtualCardFreeze: details['virtualCardFreeze'],
        virtualCardId: details['virtualCardId'],
        virtualCardName: details['virtualCardName'],
        virtualCardSource: details['virtualCardSource'],
        virtualCardStatus: details['virtualCardStatus'],
      );
}
