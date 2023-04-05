import 'package:flutter/material.dart';
import 'package:flutterwithapi2303122338/component/card_title.dart';
import 'package:flutterwithapi2303122338/component/main_card.dart';
import 'package:flutterwithapi2303122338/component/main_stat.dart';
import 'package:flutterwithapi2303122338/model/stat_and_status_model.dart';
import 'package:flutterwithapi2303122338/utils/data_utils.dart';

class CategoryCard extends StatelessWidget {
  final Color darkColor;
  final Color lightColor;
  final String region;
  final List<StatAndStatusModel> models;
  const CategoryCard({
    Key? key,
    required this.region,
    required this.models,
    required this.darkColor,
    required this.lightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        backgroundColor: lightColor,
        child: LayoutBuilder(builder: (context, constraint) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardTitle(
                title: '종류별 통계',
                backgroundColor: darkColor,
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  // 사용자가 조금만 넘겨도 페이지 단위로 넘어가도록 하는 부분
                  physics: PageScrollPhysics(),
                  children: models
                      .map(
                        (model) => MainStat(
                          width: constraint.maxWidth / 3,
                          category: DataUtils.getItemCodeKrString(
                            itemCode: model.itemCode,
                          ),
                          imgPath: model.status.imagePath,
                          level: model.status.label,
                          stat: '${model.stat.getLevelFromRegion(
                            region,
                          )}${DataUtils.getUnitFromItemCode(
                            itemCode: model.itemCode,
                          )}',
                        ),
                      )
                      .toList(),

                  // List.generate(
                  //   20,
                  //   (index) => MainStat(
                  //     width: constraint.maxWidth / 3, // <- 이부분 에서 constraint 부분이 컨테이너 /3 이기때문에 3등분이 된다.
                  //     category: '미세먼지$index',
                  //     imgPath: 'asset/img/best.png',
                  //     level: '최고',
                  //     stat: '0㎍/㎥',
                  //   ),
                  // ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
