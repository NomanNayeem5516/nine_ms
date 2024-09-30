import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nine_ms/screens/bottom/home.dart';
import 'package:nine_ms/screens/bottom/notif.dart';
import 'package:nine_ms/screens/bottom/setting.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageIndex = 0;
  static final List<Widget> page = [
    const Home(),
    const Notif(),
    const Setting()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: page[pageIndex],
      bottomNavigationBar: Container(
        height: 50,
        margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                icon: pageIndex == 0
                    ? const Icon(
                        Icons.home_filled,
                        color: Colors.blue,
                        size: 35,
                      )
                    : const Icon(
                        Icons.home_filled,
                        color: Colors.grey,
                        size: 35,
                      )),
            IconButton(
                onPressed: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                icon: pageIndex == 1
                    ? const Icon(
                  Icons.production_quantity_limits,
                  color: Colors.blue,
                  size: 35,
                )
                    : const Icon(
                  Icons.production_quantity_limits,
                  color: Colors.grey,
                  size: 35,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
                icon: pageIndex == 2
                    ? const Icon(
                  Icons.settings,
                  color: Colors.blue,
                  size: 35,
                )
                    : const Icon(
                  Icons.settings,
                  color: Colors.grey,
                  size: 35,
                )),
          ],
        ),
      ),
    );
  }
}
