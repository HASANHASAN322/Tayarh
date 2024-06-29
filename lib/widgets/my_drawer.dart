import 'package:flutter/material.dart';
import 'package:tayarh/utils/constant/colors.dart';
import 'package:tayarh/utils/constant/size.dart';

import 'drawerItem.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: MySize.defaultSpace,top: MySize.defaultSpace),
        child: Drawer(
          backgroundColor: const Color(0xBB0F5367),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only( top: 80,),
              child: Column(
                children: [
                  headerWiget(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: MyColors.darkColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2.0,left: 15,top: 10),
                          child: DrawerItem(
                            name: "Notifications",
                            icon: "assets/icons/notification.png",
                            onPressd: () => onItemPressed(context, index: 0),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 2.0,left: 15),
                          child: DrawerItem(
                            name: "Favorites",
                            icon: "assets/icons/favorites.png",
                            onPressd: () => onItemPressed(context, index: 1),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 2,left: 15),
                          child: DrawerItem(
                              name: "My Points",
                              icon: "assets/icons/my_point.png",
                              onPressd: () => onItemPressed(context, index: 2)),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 2,left: 15),
                          child: DrawerItem(
                              name: "My Wallet",
                              icon: "assets/icons/wallet.png",
                              onPressd: () => onItemPressed(context, index: 3)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 2,left: 15),
                          child: DrawerItem(
                              name: "History",
                              icon: "assets/icons/history.png",
                              onPressd: () => onItemPressed(context, index: 5)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 2,left: 15),
                          child: DrawerItem(
                              name: "Settings",
                              icon: "assets/icons/settings.png",
                              onPressd: () => onItemPressed(context, index: 6)),
                        ),


                        const Divider(color: Color(0x459e9e9e),endIndent: 15,indent: 15,),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0,left: 15),
                          child: DrawerItem(
                              name: "Suggest a Feature",
                              icon: "assets/icons/suggest_feature.png",
                              onPressd: () => onItemPressed(context, index: 7)),
                        ),Padding(
                          padding: const EdgeInsets.only(top: 20.0,left: 15),
                          child: DrawerItem(
                              name: "Report an Issue",
                              icon: "assets/icons/report_icone.png",
                              onPressd: () => onItemPressed(context, index: 7)),
                        ),Padding(
                          padding: const EdgeInsets.only(top: 20.0,left: 15),
                          child: DrawerItem(
                              name: "Rate Us",
                              icon: "assets/icons/rate_icone.png",
                              onPressd: () => onItemPressed(context, index: 7)),
                        ),Padding(
                          padding: const EdgeInsets.only(top: 20.0,left: 15),
                          child: DrawerItem(
                              name: "Invite Friends",
                              icon: "assets/icons/Invite_icone.png",
                              onPressd: () => onItemPressed(context, index: 7)),
                        ),Padding(
                          padding: const EdgeInsets.only(top: 20.0,left: 15),
                          child: DrawerItem(
                              name: "Drive with Us",
                              icon: "assets/icons/drive_icone.png",
                              onPressd: () => onItemPressed(context, index: 7)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0,left: 15),
                          child: DrawerItem(
                              name: "Privacy Policy",
                              icon: "assets/icons/privacy_icone.png",
                              onPressd: () => onItemPressed(context, index: 7)),
                        ),


                        const SizedBox(height: 10,)
                      ],
                    ),
                  )
                ],
              ),
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

  Widget headerWiget() {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ABDO-AR",
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              Text("Update Information >",
                  style: TextStyle(color: Colors.white54, fontSize: 10))
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 18.0,bottom: 20),
          child: SizedBox(
            height: 50,
            width: 50,
            child: Image.asset(
              "assets/profile.png",
              fit: BoxFit.fill,
            ),
          ),
        )
      ],
    );
  }
}
