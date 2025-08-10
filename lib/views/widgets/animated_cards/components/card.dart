import 'package:flutter/material.dart';
import 'bottom_links.dart';
import 'card_details.dart';
import 'card_summary.dart';
import 'folding_card.dart';
import 'my_data.dart';

class MyCard extends StatefulWidget {
  static const double nominalOpenHeight = 400;
  static const double nominalClosedHeight = 160;
  final DummyData dummyData;
  final VoidCallback? onClick;

  const MyCard({super.key, required this.dummyData, required this.onClick});
  @override
  State<StatefulWidget> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  CardSummary? topCard;
  late CardSummary frontCard = CardSummary(
    dummy: widget.dummyData,
  );
  late CardDetails middleCard = CardDetails(widget.dummyData);
  // late BottomLinks bottomCard = BottomLinks(dummyData: widget.dummyData,);
  bool _isOpen = false;

  Widget get backCard => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      color: Color(0xffdce6ef),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return FoldingCard(
      entries: _getEntries(),
      isOpen: _isOpen,
      onClick: _handleOnTap,
    );
  }

  List<FoldEntry> _getEntries() {
    return [
      FoldEntry(height: 160.0, front: topCard),
      FoldEntry(height: 160.0, front: middleCard, back: frontCard),
      // FoldEntry(height: 80.0, front: bottomCard, back: backCard),
    ];
  }

  void _handleOnTap() {
    widget.onClick?.call();
    setState(() {
      _isOpen = !_isOpen;
      topCard = CardSummary(
        dummy: widget.dummyData,
        theme: MyCardTheme.dark,
        isOpen: _isOpen,
      );
    });
  }
}
