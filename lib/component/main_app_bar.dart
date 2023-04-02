import 'package:flutter/material.dart';
import 'package:flutterwithapi2303122338/const/colors.dart';
import 'package:flutterwithapi2303122338/model/stat_model.dart';
import 'package:flutterwithapi2303122338/model/status_model.dart';
import 'package:flutterwithapi2303122338/utils/data_utils.dart';

class MainAppBar extends StatelessWidget {

  final StatusModel status;
  final StatModel stat;

  const MainAppBar({super.key, required this.status, required this.stat});

  @override
  Widget build(BuildContext context) {
    const ts = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
    );

    return SliverAppBar(
      backgroundColor: status.primaryColor,
      expandedHeight: 500,
      flexibleSpace: FlexibleSpaceBar(
          background: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: kToolbarHeight),
          child: Column(
            children: [
              Text(
                '서울',
                style: ts.copyWith(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
               DataUtils.getTimeFromDateTime(dateTime: stat.dataTime),
                style: ts.copyWith(
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Image.asset(
                status.imagePath,
                width: MediaQuery.of(context).size.width / 2,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                status.label,
                style: ts.copyWith(fontSize: 40.0, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                status.comment,
                style: ts.copyWith(fontSize: 20.0, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      )),
    );
  }

}
