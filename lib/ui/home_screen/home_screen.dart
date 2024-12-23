import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/app_colors.dart';
import '../../utils/assets_manager.dart';
import '../tabs/favorite/favorite_tab.dart';
import '../tabs/home/home_tab.dart';
import '../tabs/map/map_tab.dart';
import '../tabs/profile/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [HomeTab(), MapTab(), FavoriteTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).primaryColor,
        ),
        child: BottomAppBar(
          padding: EdgeInsets.zero,
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
          notchMargin: 4,
          child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              items: [
                buildBottomNavigationBarItems(
                    index: 0,
                    iconSelectedName: AssetsManager.iconHomeSelected,
                    iconName: AssetsManager.iconHome,
                    label: AppLocalizations.of(context)!.home),
                buildBottomNavigationBarItems(
                    index: 1,
                    iconSelectedName: AssetsManager.iconMapSelected,
                    iconName: AssetsManager.iconMap,
                    label: AppLocalizations.of(context)!.map),
                buildBottomNavigationBarItems(
                    index: 2,
                    iconSelectedName: AssetsManager.iconFavoriteSelected,
                    iconName: AssetsManager.iconFavorite,
                    label: AppLocalizations.of(context)!.favorite),
                buildBottomNavigationBarItems(
                    index: 3,
                    iconSelectedName: AssetsManager.iconProfileSelected,
                    iconName: AssetsManager.iconProfile,
                    label: AppLocalizations.of(context)!.profile)
              ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigate to event
          //add event
        },
        child: Icon(
          Icons.add,
          color: AppColors.whiteColor,
          size: 25,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );

    //   body:
    // );
    // }
    //
  }

  BottomNavigationBarItem buildBottomNavigationBarItems(
      {required int index,
      required String iconSelectedName,
      required String iconName,
      required String label}) {
    return BottomNavigationBarItem(
        icon: ImageIcon(
            AssetImage(selectedIndex == index ? iconSelectedName : iconName)),
        label: label);
  }
}
