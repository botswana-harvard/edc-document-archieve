import 'package:edc_document_archieve/src/ui/widgets/custom_text.dart';
import 'package:edc_document_archieve/src/utils/constants/colors.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  static const String routeName = kBase;

  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double parentHeight = constraints.maxHeight;
        double parentWidth = constraints.maxWidth;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings_power_sharp,
                  color: DARK_BLUE,
                ),
              )
            ],
            centerTitle: true,
            title: Text(kAppName.toUpperCase()),
            titleTextStyle: const TextStyle(
              color: DARK_BLUE,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            elevation: 0,
          ),
          body: Container(
            color: Colors.white,
            height: parentHeight / 2,
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 100,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const CustomTextWidget(
                    text: 'Select Study',
                    fontSize: 30,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: 70,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(width: 10),
                        Icon(
                          Icons.folder,
                          size: 40,
                          color: Colors.white60,
                        ),
                        SizedBox(width: 30),
                        CustomTextWidget(
                          text: 'Flourish',
                          fontSize: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: 70,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(width: 10),
                        Icon(
                          Icons.folder,
                          size: 40,
                          color: Colors.white60,
                        ),
                        SizedBox(width: 30),
                        CustomTextWidget(
                          text: 'Tshilo Dikotla',
                          fontSize: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
