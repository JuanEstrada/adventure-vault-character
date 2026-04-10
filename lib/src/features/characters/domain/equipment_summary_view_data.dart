import 'package:flutter/foundation.dart';

@immutable
class EquipmentSummaryViewData {
  const EquipmentSummaryViewData({
    required this.statusLabel,
    required this.description,
    required this.highlightItems,
  });

  final String statusLabel;
  final String description;
  final List<String> highlightItems;
}
