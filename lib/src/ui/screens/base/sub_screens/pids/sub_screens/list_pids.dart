import 'package:edc_document_archieve/src/core/models/study_document.dart';
import 'package:edc_document_archieve/src/services/app_service.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef ValueSetter<StudyDocument> = void Function(StudyDocument value);

class ListPids extends StatelessWidget {
  const ListPids({
    Key? key,
    required this.pids,
    required this.onFolderButtonTapped,
    required this.studyDocuments,
    required this.scrollController,
    required this.cardKeyList,
  }) : super(key: key);

  final List<String> pids;
  final List<StudyDocument>? studyDocuments;
  final ValueSetter<StudyDocument> onFolderButtonTapped;
  final ScrollController scrollController;
  final List<GlobalKey<ExpansionTileCardState>> cardKeyList;

  @override
  Widget build(BuildContext context) {
    AppService _appService = context.read<AppService>();
    return ListView.separated(
      controller: scrollController,
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
        return Container(
          padding: const EdgeInsets.all(10),
          child: ExpansionTileCard(
            key: cardKeyList[index],
            onExpansionChanged: (value) {
              if (value) {
                _appService.selectedPid = pids[index];
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
            title: Text(
              pids[index],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
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
      itemCount: pids.length,
    );
  }
}
