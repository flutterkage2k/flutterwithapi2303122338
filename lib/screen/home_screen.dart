import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwithapi2303122338/component/card_title.dart';
import 'package:flutterwithapi2303122338/component/category_card.dart';
import 'package:flutterwithapi2303122338/component/hourly_card.dart';
import 'package:flutterwithapi2303122338/component/main_app_bar.dart';
import 'package:flutterwithapi2303122338/component/main_card.dart';
import 'package:flutterwithapi2303122338/component/main_drawer.dart';
import 'package:flutterwithapi2303122338/const/colors.dart';
import 'package:flutterwithapi2303122338/const/data.dart';
import 'package:flutterwithapi2303122338/const/regions.dart';
import 'package:flutterwithapi2303122338/const/status_level.dart';
import 'package:flutterwithapi2303122338/model/stat_and_status_model.dart';
import 'package:flutterwithapi2303122338/model/stat_model.dart';
import 'package:flutterwithapi2303122338/repository/stat_repository.dart';
import 'package:flutterwithapi2303122338/utils/data_utils.dart';

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = regions[0]; // 서울일것이다.


  bool isExpanded = true;

  ScrollController scrollController = ScrollController();

  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
    Map<ItemCode, List<StatModel>> stats = {};

    List<Future> futures = [];

    for (ItemCode itemCode in ItemCode.values) {
      futures.add(
        StatRepository.fetchData(
          itemCode: itemCode,
        ),
      );
    }
    final results = await Future.wait(futures);

    for (int i = 0; i < results.length; i++) {
      final key = ItemCode.values[i];
      final value = results[i];

      stats.addAll({
        key: value,
      });
    }

    return stats;
  }

  scrollListender() {
    bool isExpanded = scrollController.offset()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: MainDrawer(
        selectedRegion: region,
        onRegionTap: (String region) {
          setState(() {
            this.region = region;
          });
          Navigator.of(context).pop();
        },
      ),
      body: FutureBuilder<Map<ItemCode, List<StatModel>>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error'),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            Map<ItemCode, List<StatModel>> stats = snapshot.data!;

            StatModel pm10RecentStat = stats[ItemCode.PM10]![0];

            final status = DataUtils.getStatusFromItemCodeAndValue(
              value: pm10RecentStat.seoul,
              itemCode: ItemCode.PM10,
            );

            final ssModel = stats.keys.map((key) {
              final value = stats[key]!;
              final stat = value[0];

              return StatAndStatusModel(
                itemCode: key,
                status: DataUtils.getStatusFromItemCodeAndValue(
                  value: stat.getLevelFromRegion(region),
                  itemCode: key,
                ),
                stat: stat,
              );
            }).toList();

            return Container(
              color: status.primaryColor,
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  MainAppBar(
                    isExpanded: true,
                    dateTime: pm10RecentStat.dataTime,
                    region: region,
                    stat: pm10RecentStat,
                    status: status,
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CategoryCard(
                          region: region,
                          models: ssModel,
                          darkColor: status.darkColor,
                          lightColor: status.lightColor,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        ...stats.keys.map((itemCode) {
                          final stat = stats[itemCode]!;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: HourlyCard(
                              darkColor: status.darkColor,
                              lightColor: status.lightColor,
                              category: DataUtils.getItemCodeKrString(
                                itemCode: itemCode,
                              ),
                              stats: stat,
                              region: region,
                            ),
                          );
                        }).toList(),
                        const SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
