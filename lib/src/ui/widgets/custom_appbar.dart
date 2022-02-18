import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  final String titleName;
  final Color? appbackgroundColor;
  final List<Widget> actionButtons;
  final bool implyLeading;

  CustomAppBar({
    Key? key,
    required this.titleName,
    this.appbackgroundColor = Colors.white,
    this.actionButtons = const [],
    this.implyLeading = false,
  }) : super(key: key);

  @override
  Widget? get title => Text(titleName);

  @override
  bool? get centerTitle => true;

  @override
  TextStyle? get titleTextStyle => const TextStyle(
      color: DARK_BLUE,
      fontWeight: FontWeight.bold,
      fontFamily: 'RobotoSlab',
      fontSize: 18);

  @override
  List<Widget>? get actions => customAppBarButtons;

  List<Widget> get customAppBarButtons {
    List<Widget> temp = [];
    if (actionButtons.isNotEmpty) temp.addAll(actionButtons);
    temp.add(IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.settings_power_sharp,
        color: DARK_BLUE,
      ),
    ));
    return temp;
  }

  @override
  Color? get backgroundColor => appbackgroundColor;

  @override
  bool get automaticallyImplyLeading => implyLeading;

  @override
  double? get elevation => 0.1;

  @override
  Widget? get leading => const Icon(
        Icons.home,
        color: DARK_BLUE,
      );
}
