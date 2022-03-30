import 'package:edc_document_archieve/src/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomStudyCard extends StatelessWidget {
  final String studyName;
  final Color? cardColor;
  final Function() onTap;
  const CustomStudyCard({
    Key? key,
    required this.studyName,
    required this.cardColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 10),
            const Icon(
              Icons.folder,
              size: 40,
              color: Colors.white60,
            ),
            const SizedBox(width: 30),
            CustomText(
              text: studyName,
              fontSize: 20,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
