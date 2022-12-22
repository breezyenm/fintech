import 'package:flutter/material.dart';
import 'package:qwid/models/card_transaction.dart';
import 'package:qwid/models/virtual_card.dart';
import 'package:qwid/models/virtual_card_cur.dart';

class CardData extends ChangeNotifier {
  List<VirtualCardCur>? virtualCardCurs;
  // List<VirtualCard>? virtualCards;
  List<CardTransaction>? transactions;

  String? _cur;
  String? get cur => _cur;
  set cur(String? val) {
    _cur = val;
    notifyListeners();
  }

  VirtualCardCur? _virtualCardCur;
  VirtualCardCur? get virtualCardCur => _virtualCardCur;
  set virtualCardCur(VirtualCardCur? val) {
    _virtualCardCur = val;
    notifyListeners();
  }

  VirtualCard? _virtualCard;
  VirtualCard? get virtualCard => _virtualCard;
  set virtualCard(VirtualCard? val) {
    _virtualCard = val;
    notifyListeners();
  }

  List<VirtualCard>? _virtualCards;
  List<VirtualCard>? get virtualCards => _virtualCards;
  set virtualCards(List<VirtualCard>? val) {
    _virtualCards = val;
    notifyListeners();
  }

  String _color = '#48BBED';
  String get color => _color;
  set color(String val) {
    _color = val;
    notifyListeners();
  }

  clear() {
    virtualCardCur = null;
    virtualCardCurs = null;
  }

  final Map<String, Color> presets = {
    "#48BBED": const Color(0xFF48BBED),
    "#F3941F": const Color(0xFFF3941F),
    "#7E3D88": const Color(0xFF7E3D88),
    "#000000": const Color(0xFF000000),
    "#194153": const Color(0xFF194153),
    "#F98AC6": const Color(0xFFF98AC6),
  };
}
