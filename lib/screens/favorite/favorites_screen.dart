import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tayarh/screens/favorite/controller/favorites_controller.dart';
import 'package:tayarh/screens/favorite/widgets/custom_tabbar_view.dart';
import 'package:tayarh/widgets/main_btn/main_btn.dart';
import '../../constant/size.dart';
import '../../constant/text_strings.dart';
import '../../theme/dark_mode.dart';
import '../../utils/constant/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = DarkMode.isDarkMode(context);

    return GetBuilder<FavoritesController>(
      init: FavoritesController("5xez1UVKnoyKeAVoinOt"), // Pass the user ID
      builder: (controller) {
        return controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : DefaultTabController(
                length: controller.favoritePlaces!.docs.length,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.8,
                  padding: const EdgeInsets.all(MySize.defaultSpace),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    color: dark ? MyColors.darkColor : MyColors.whiteColor,
                  ),
                  child: controller.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: MyColors.mainColor,
                          ),
                        )
                      : Column(
                          children: [
                            Container(
                              width: 80,
                              height: 10,
                              decoration: BoxDecoration(
                                color: MyColors.borderColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(height: MySize.spaceBtwSections),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                MyTexts.favorite,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: dark
                                      ? MyColors.whiteColor
                                      : MyColors.blackColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: MySize.spaceBtwItems),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height: 50,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Search',
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        prefixIcon: const Icon(Icons.search),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: MainButton(
                                      title: "New Place",
                                      fontSize: 15,
                                      onPressed: () {
                                        // Implement your button logic here
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            if (controller.favoritePlaces!.docs.isNotEmpty)
                              TabBar(
                                indicatorColor: Colors.blue,
                                labelColor: Colors.blue,
                                dividerHeight: 0,
                                unselectedLabelColor: dark
                                    ? MyColors.whiteColor
                                    : MyColors.blackColor,
                                tabs:
                                    controller.favoritePlaces!.docs.map((doc) {
                                  return Tab(text: doc['name']);
                                }).toList(),
                              ),
                            const SizedBox(height: 16.0),
                            if (controller.favoritePlaces!.docs.isNotEmpty)
                              Expanded(
                                child: CustomTabBarView(
                                    tabs: controller.placeFavorites),
                              ),
                          ],
                        ),
                ),
              );
      },
    );
  }
}
