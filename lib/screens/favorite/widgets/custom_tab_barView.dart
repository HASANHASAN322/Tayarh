import 'package:flutter/material.dart';

import '../../../utils/constant/colors.dart';

class CustomTabBarView extends StatelessWidget {
  final List<String> tabs;

  const CustomTabBarView({Key? key, required this.tabs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: tabs.map((String name) {
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: MyColors.borderColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("My secondary home"),
                              SizedBox(height: 15,),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: Colors.blue,
                                    size: 10,
                                  ),
                                  SizedBox(width: 5,),
                                  Text("Suez (Attaka)"),
                                ],
                              )
                          ],
                        ),
                        Spacer(),
                        Text("29 March, 2024"),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
