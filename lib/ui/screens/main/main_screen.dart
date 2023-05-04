import 'package:afisha_admin_panel/ui/screens/adds/adds_screen.dart';
import 'package:afisha_admin_panel/ui/screens/product_categories/product_categories.dart';
import 'package:afisha_admin_panel/ui/screens/users/users_screen.dart';
import 'package:afisha_admin_panel/ui/screens/users_category/users_category.dart';
import 'package:afisha_admin_panel/utils/size_config.dart';
import 'package:afisha_admin_panel/values/colors.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int botNavIndex = 0;

  onBotNavTap(index) {
    setState(() {
      botNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: botNavIndex == 1
          ? ProductCategories()
          : botNavIndex == 2
              ? UsersScreen()
              : botNavIndex == 3
                  ? AddsScreen()
                  : UsersCategory(),
      bottomNavigationBar: getBottomNavigation(),
    );
  }

  getBottomNavigation() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        boxShadow: [
          BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: botNavIndex,
          onTap: onBotNavTap,
          selectedItemColor: AppColors.red,
          unselectedItemColor: AppColors.black,
          iconSize: 20,
          items: [
            getBotNavItem('U cats'),
            getBotNavItem('P cats'),
            getBotNavItem('Users'),
            getBotNavItem('Adds'),
          ],
        ),
      ),
    );
  }

  getBotNavItem(String s) {
    return BottomNavigationBarItem(
      icon: const SizedBox(),
      label: s,
    );
  }
}
