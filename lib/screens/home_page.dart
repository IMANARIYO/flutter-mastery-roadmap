import 'package:flutter/material.dart';
import 'package:flutter_mastery_roadmap/constants/app_colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: SafeArea(
          child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageIcon(AssetImage("assets/img/menu.png"),
                        size: 24, color: Colors.black),
                    Row(
                      children: [
                        Icon(Icons.search, size: 24, color: Colors.black),
                        SizedBox(width: 10),
                        Icon(Icons.notifications,
                            size: 24, color: Colors.black),
                      ],
                    ),
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Popular Books",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 180,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.8),
                itemCount: 5,
                itemBuilder: (_, index) {
                  return Container(
                    height: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/img/pic-8.png"))),
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
