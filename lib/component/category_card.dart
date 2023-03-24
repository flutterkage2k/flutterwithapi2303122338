import 'package:flutter/material.dart';
import 'package:flutterwithapi2303122338/component/main_stat.dart';
import 'package:flutterwithapi2303122338/const/colors.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16.0,
            ),
          ),
        ),
        color: lightColor,
        child: LayoutBuilder(builder: (context, constraint) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: darkColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    '종류별 통계',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    // 사용자가 조금만 넘겨도 페이지 단위로 넘어가도록 하는 부분
                    physics: PageScrollPhysics(),
                    children: List.generate(
                      20,
                      (index) => MainStat(
                        width: constraint.maxWidth / 3, // <- 이부분 에서 constraint 부분이 컨테이너 /3 이기때문에 3등분이 된다.
                        category: '미세먼지$index',
                        imgPath: 'asset/img/best.png',
                        level: '최고',
                        stat: '0㎍/㎥',
                      ),
                    )),
              )
            ],
          );
        }),
      ),
    );
  }
}
