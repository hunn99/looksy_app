import 'package:flutter/material.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:go_router/go_router.dart';
import 'package:looksy_app/presentation/pages/history/historypage.dart';
import 'package:looksy_app/presentation/pages/home/homepage.dart';
import 'package:looksy_app/presentation/pages/profile/profile_page.dart';
import 'package:looksy_app/presentation/pages/scan/scan.dart';
import 'package:looksy_app/presentation/pages/tips/tips.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/navigations/menu_items.dart';

// ignore: must_be_immutable
class NavigationPage extends StatefulWidget {
  int? selectedIndex;
  NavigationPage({super.key, this.selectedIndex = 0});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final List<String> _routesName = [
    '/home',
    '/home/tips',
    '/home/scan',
    '/home/history',
    '/home/profile'
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
      context.go(_routesName[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = <Widget>[
      const HomePage(),
      const TipsPage(),
      const ScanPage(),
      const HistoryPage(),
      const ProfilePage(),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: pages[widget.selectedIndex!],
        bottomNavigationBar: Container(
            height: 72,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: neutralTheme[50]!, width: 1),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                MenuItem(
                  label: 'Home',
                  selectedIcon: IconsaxBold.home_1,
                  unselectedIcon: IconsaxOutline.home,
                  index: 0,
                  selectedPageIndex: widget.selectedIndex ?? 0,
                  onTap: _onItemTapped,
                ),
                MenuItem(
                  label: 'Tips',
                  selectedIcon: IconsaxBold.magicpen,
                  unselectedIcon: IconsaxOutline.magicpen,
                  index: 1,
                  selectedPageIndex: widget.selectedIndex ?? 0,
                  onTap: _onItemTapped,
                ),
                MenuItem(
                  label: '',
                  selectedIcon: IconsaxBold.scan,
                  unselectedIcon: IconsaxOutline.scan,
                  index: 2,
                  selectedPageIndex: widget.selectedIndex ?? 0,
                  onTap: _onItemTapped,
                ),
                MenuItem(
                  label: 'History',
                  selectedIcon: IconsaxBold.document_text,
                  unselectedIcon: IconsaxOutline.document_text,
                  index: 3,
                  selectedPageIndex: widget.selectedIndex ?? 0,
                  onTap: _onItemTapped,
                ),
                MenuItem(
                  label: 'Profile',
                  selectedIcon: IconsaxBold.user,
                  unselectedIcon: IconsaxOutline.user,
                  index: 4,
                  selectedPageIndex: widget.selectedIndex ?? 0,
                  onTap: _onItemTapped,
                ),
              ],
            )),
      ),
    );
  }
}
