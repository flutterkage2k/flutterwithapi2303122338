import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwithapi2303122338/component/card_title.dart';
import 'package:flutterwithapi2303122338/component/category_card.dart';
import 'package:flutterwithapi2303122338/component/main_app_bar.dart';
import 'package:flutterwithapi2303122338/component/main_card.dart';
import 'package:flutterwithapi2303122338/component/main_drawer.dart';
import 'package:flutterwithapi2303122338/const/colors.dart';
import 'package:flutterwithapi2303122338/const/data.dart';
import 'package:flutterwithapi2303122338/model/stat_model.dart';
import 'package:flutterwithapi2303122338/repository/stat_repository.dart';

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    fetchData(); // homescreen이 한번 실행될때만 실행됨.
  }

  fetchData() async {
    final statModels = await StatRepository.fetchData();

    print(statModels);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: MainDrawer(),
      body: CustomScrollView(
        slivers: [
          MainAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CategoryCard(),
                const SizedBox(
                  height: 16.0,
                ),
                MainCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CardTitle(
                        title: '시간별 미세먼지',
                      ),
                      Column(
                        children: List.generate(
                          24,
                          (index) {
                            final now = DateTime.now();
                            final hour = now.hour;
                            int currentHour = hour - index;

                            if (currentHour < 0) {
                              currentHour += 24;
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              child: Row(
                                children: [
                                  Expanded(child: Text('$currentHour시')),
                                  Expanded(
                                    child: Image.asset(
                                      'asset/img/good.png',
                                      height: 20.0,
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(
                                    '좋음',
                                    textAlign: TextAlign.right,
                                  )),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
