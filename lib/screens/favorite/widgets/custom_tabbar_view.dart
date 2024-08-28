import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../utils/constant/colors.dart';
import '../controller/favorites_controller.dart';
class CustomTabBarView extends StatelessWidget {
  final List<String> tabs;

  const CustomTabBarView({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoritesController>(
      builder: (controller) {
        return TabBarView(
          children: tabs.map((String placeName) {
            var favorites = controller.placeFavorites[placeName] ?? [];

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: favorites.length,
              itemBuilder: (context, i) {
                var favorite = favorites[i];

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
                              Text(favorite['address'] ?? 'Unknown Address'),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    color: Colors.blue,
                                    size: 10,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(favorite['description'] ?? 'No Description'),
                                ],
                              )
                            ],
                          ),
                          const Spacer(),
                          Text(favorite['time_add'] != null
                              ? DateFormat('dd MMM, yyyy').format(favorite['time_add'].toDate())
                              : 'No Date'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
