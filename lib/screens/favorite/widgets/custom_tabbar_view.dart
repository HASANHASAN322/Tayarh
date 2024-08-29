import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../utils/constant/colors.dart';
import '../controller/favorites_controller.dart';

class CustomTabBarView extends StatelessWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> tabs;

  const CustomTabBarView({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoritesController>(
      builder: (controller) {
        return TabBarView(
          children: tabs.isNotEmpty
              ? tabs.map((doc) {
            final List<dynamic> mapsList = doc['fav'];
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: mapsList.length,  // Set itemCount to the length of the inner list of maps
                itemBuilder: (context, index) {
                  final place = mapsList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.5, color: MyColors.borderColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(place['name'] , style: const TextStyle(fontSize: 18),),  // Display the address
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.blue,
                                      size: 10,
                                    ),
                                    const SizedBox(width: 5),
                                    Text('${place['description']}', style: const TextStyle(fontSize: 18),),  // Display the description
                                  ],
                                )
                              ],
                            ),
                            Text(DateFormat('dd MMM, yyyy').format(
                                place['date'].toDate()) , style: const TextStyle(fontSize: 17),),  // Display the formatted date
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }).toList()
              : [Center(child: CircularProgressIndicator(color: MyColors.mainColor))],
        );
      },
    );
  }
}
