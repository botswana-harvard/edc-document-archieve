import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:edc_document_archieve/src/services/app_service.dart';
import 'package:edc_document_archieve/src/utils/constants/constants.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<String> pids;
  List<GlobalKey<ExpansionTileCardState>> cardKeyList = [];
  late AppService _appService;
  final List<StudyDocument>? studyDocuments;

  CustomSearchDelegate({required this.studyDocuments, required this.pids});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        FocusScope.of(context).unfocus();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }
    List<String> results = pids
        .where((pid) => pid.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return _listPidsWidget(results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _appService = context.read<AppService>();
    List<String> suggestions = pids
        .where((pid) => pid.toLowerCase().contains(query.toLowerCase()))
        .toList();
    suggestions = suggestions.toSet().toList();
    return _listPidsWidget(suggestions);
  }

  onFolderButtonTapped(studyDocument) {
    _appService.selectedStudyDocument = studyDocument;
    switch (studyDocument.type) {
      case kCrfForm:
        Get.toNamed(kCrfformRoute);
        break;
      case kNonCrfForm:
        Get.toNamed(kNonCrfformRoute);
        break;
      default:
    }
  }

  Widget _listPidsWidget(List<String> suggestions) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            height: 1.5,
            width: MediaQuery.of(context).size.width,
            child: const Divider(
              thickness: 1,
            ),
          ),
        );
      },
      itemBuilder: (context, index) {
        cardKeyList
            .add(GlobalKey<ExpansionTileCardState>(debugLabel: '$index'));
        return Container(
          padding: const EdgeInsets.all(10),
          child: ExpansionTileCard(
            key: cardKeyList[index],
            onExpansionChanged: (value) {
              if (value) {
                _appService.selectedPid = suggestions[index];
                Future.delayed(const Duration(milliseconds: 500), () {
                  for (var i = 0; i < cardKeyList.length; i++) {
                    if (index != i) {
                      cardKeyList[i].currentState?.collapse();
                    }
                  }
                });
              }
            },
            leading: const Icon(
              Icons.folder,
              size: 30,
            ),
            title: query.isNotEmpty
                ? RichText(
                    text: TextSpan(
                        text: suggestions[index].substring(0, query.length),
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        children: [
                          TextSpan(
                              text: suggestions[index].substring(query.length),
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 18))
                        ]),
                  )
                : Text(suggestions[index]),
            children: [
              ...studyDocuments!.map((studyDocument) => Container(
                    padding: const EdgeInsets.all(10),
                    height: 80,
                    child: ListTile(
                      tileColor: Theme.of(context).canvasColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusColor: Colors.white,
                      style: ListTileStyle.list,
                      title: Text(studyDocument.name),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                      onTap: () => onFolderButtonTapped(studyDocument),
                    ),
                  )),
            ],
          ),
        );
      },
      itemCount: suggestions.length,
    );
  }
}
