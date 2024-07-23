import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tayarh/utils/constant/colors.dart';
import 'package:tayarh/utils/constant/image_strings.dart';
import 'package:tayarh/utils/constant/size.dart';

import '../screens/home/controller/home_controller.dart';
import '../theme/dark_mode.dart';
import 'drawer_item.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = DarkMode.isDarkMode(context);
    final homeController = Get.put(HomeController());
    return Padding(
      padding: const EdgeInsets.only(
          left: MySize.defaultSpace*2 ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Drawer(
          backgroundColor: dark ? const Color(0xBB0F5367) :const Color(0xff84ceea),
          child: SingleChildScrollView(
            child: Column(
              children: [
                headerWidget(),
                const SizedBox(

                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color:dark ? MyColors.darkColor : MyColors.whiteColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 2.0, left: 15, top: 10),
                        child: DrawerItem(
                          name: "Notifications",
                          icon: MyImage.notification,
                          onPress: () => homeController.openNotificationBottomSheet(context),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 2.0, left: 15),
                        child: DrawerItem(
                          name: "Favorites",
                          icon: MyImage.favorites,
                          onPress: () => homeController.openFavoriteBottomSheet(context),
                        ),
                      ),



                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 2, left: 15),
                        child: DrawerItem(
                            name: "My Points",
                            icon: MyImage.pointLogo,
                            onPress: () =>
                                homeController.openPointBottomSheet(context)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 2, left: 15),
                        child: DrawerItem(
                            name: "My Wallet",
                            icon: MyImage.wallet,
                            onPress: () =>  homeController.openWalletBottomSheet(context)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 2, left: 15),
                        child: DrawerItem(
                            name: "History",
                            icon: MyImage.history,
                            onPress: () => homeController.openHistoryBottomSheet(context)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 2, left: 15),
                        child: DrawerItem(
                            name: "Settings",
                            icon: MyImage.settings,
                            onPress: () => homeController.openSettingBottomSheet(context)),
                      ),
                      const Divider(
                        color: Color(0x459e9e9e),
                        endIndent: 15,
                        indent: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 15),
                        child: DrawerItem(
                            name: "Suggest a Feature",
                            icon: MyImage.suggestAFeature,
                            onPress: () => onItemPressed(context, index: 7)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 15),
                        child: DrawerItem(
                            name: "Report an Issue",
                            icon: MyImage.reportAnIssue,
                            onPress: () => onItemPressed(context, index: 7)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 15),
                        child: DrawerItem(
                            name: "Rate Us",
                            icon: MyImage.rateUs,
                            onPress: () => onItemPressed(context, index: 7)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 15),
                        child: DrawerItem(
                            name: "Invite Friends",
                            icon: MyImage.inviteFriends,
                            onPress: () => onItemPressed(context, index: 7)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 15),
                        child: DrawerItem(
                            name: "Drive with Us",
                            icon: MyImage.driveWithUs,
                            onPress: () => onItemPressed(context, index: 7)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 15),
                        child: DrawerItem(
                            name: "Privacy Policy",
                            icon: MyImage.privacyPolicy,
                            onPress: () => onItemPressed(context, index: 7)),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);
    switch (index) {
      case 0:
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => FeedScreen()));
        break;
      case 1:
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => Favorites()));
        break;

      case 2:
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => ProfileScreen(
        //             uid: FirebaseAuth.instance.currentUser!.uid)));
        break;
      case 3:
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => SearchScreen()));
        break;
      case 4:
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => SettingScreen()));
        break;
      case 5:
        //todo share link app
        // Share.share('www.google.com');
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => SettingScreen()));
        break;
      case 6:
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => FollowUs()));
        break;
      default:

        //todo
        Navigator.pop(context);
        break;
    }
  }

  Widget headerWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: MySize.defaultSpace * 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("ABDO-AR",
                    style: TextStyle(fontSize: 15, color: Colors.white)),
                Text("Update Information >",
                    style: TextStyle(color: Colors.white54, fontSize: 10))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset(
                    "assets/profile.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
