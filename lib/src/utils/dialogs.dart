import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class Dialogs {
  /// general dialog
  static Future<void> showGeneralDialog(
    BuildContext context, {
    String title = "",
    required String text,
    Widget? buttons,

    /// Navigator pop twice
    bool doublePop = false,
  }) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  title: Text(
                    title,
                    textAlign: TextAlign.center,
                  ),
                  children: <Widget>[
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(bottom: 20),
                                child: Text(
                                  text,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              buttons ??
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      if (doublePop) {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: const Text("OK"),
                                  ),
                            ]),
                      ),
                    )
                  ]));
        });
  }

  /// Loading
  static Future<void> showLoadingDialog(
    BuildContext context, {
    String message = "Please Wait....",
  }) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(children: <Widget>[
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10,
                    ),
                    child: Row(children: [
                      const SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                      ),
                      const SizedBox(width: 15),
                      Text(message)
                    ]),
                  ),
                )
              ]));
        });
  }

  static void closeLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
