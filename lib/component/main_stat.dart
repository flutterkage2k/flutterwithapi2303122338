import 'package:flutter/material.dart';

class MainStat extends StatelessWidget {
  // 미세먼저 초미세먼지 등
  final String category;
// 아이콘 위치( 경로)
  final String imgPath;
// 오염정도
  final String level;
// 오염수치
  final String stat;

  // 너비
  final double width;

  const MainStat({
    super.key,
    required this.category,
    required this.imgPath,
    required this.level,
    required this.stat,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    const ts = TextStyle(color: Colors.black);

    return SizedBox(
      width: width, // <- 외부에서 사이즈를 받는다.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            category,
            style: ts,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Image.asset(
            imgPath,
            width: 50.0,
          ),
          Text(
            level,
            style: ts,
          ),
          Text(
            stat,
            style: ts,
          )
        ],
      ),
    );
  }
}
