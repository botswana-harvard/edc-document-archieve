import 'package:edc_document_archieve/src/config/injector.dart';
import 'package:edc_document_archieve/src/services/app_service.dart';
import 'package:edc_document_archieve/src/services/bloc/authentication_bloc.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      color: kDarkBlue,
      fontWeight: FontWeight.bold,
      fontFamily: 'RobotoSlab',
      fontSize: 17);

  @override
  List<Widget>? get actions => customAppBarButtons;

  List<Widget> get customAppBarButtons {
    List<Widget> temp = [];
    if (actionButtons.isNotEmpty) {
      temp.addAll(actionButtons);
    }
    if (Get.currentRoute != kAuthWrapperRoute &&
        Get.currentRoute != kBaseRoute) {
      temp.add(IconButton(
        onPressed: () {
          Get.offAllNamed(kBaseRoute);
        },
        icon: const Icon(
          Icons.home,
          color: kDarkBlue,
        ),
      ));
    }
    temp.add(IconButton(
      onPressed: () {
        Injector.resolve<AuthenticationBloc>()
            .add(AuthenticationLogoutRequested());
        Get.offAllNamed(kLoginRoute);
      },
      icon: const Icon(
        Icons.settings_power_sharp,
        color: kDarkBlue,
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
}
