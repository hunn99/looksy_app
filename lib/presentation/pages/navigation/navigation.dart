import 'package:flutter/material.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:looksy_app/presentation/pages/history/historypage.dart';
import 'package:looksy_app/presentation/pages/home/homepage.dart';
import 'package:looksy_app/presentation/pages/profile/profile_page.dart';
import 'package:looksy_app/presentation/pages/scan/scan.dart';
import 'package:looksy_app/presentation/pages/tips/tips.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/navigations/menu_items.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int? selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = <Widget>[
      const HomePage(),
      const TipsPage(),
      const HistoryPage(),
      const ProfilePage(),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: pages[selectedIndex!],
        bottomNavigationBar: Container(
          height: 72,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: neutralTheme[50]!, width: 1),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MenuItem(
                label: 'Home',
                selectedIcon: IconsaxBold.home_1,
                unselectedIcon: IconsaxOutline.home,
                index: 0,
                selectedPageIndex: selectedIndex!,
                onTap: _onItemTapped,
              ),
              MenuItem(
                label: 'Tips',
                selectedIcon: IconsaxBold.magicpen,
                unselectedIcon: IconsaxOutline.magicpen,
                index: 1,
                selectedPageIndex: selectedIndex!,
                onTap: _onItemTapped,
              ),
              const SizedBox(width: 80),
              MenuItem(
                label: 'History',
                selectedIcon: IconsaxBold.document_text,
                unselectedIcon: IconsaxOutline.document_text,
                index: 2,
                selectedPageIndex: selectedIndex!,
                onTap: _onItemTapped,
              ),
              MenuItem(
                label: 'Profile',
                selectedIcon: IconsaxBold.user,
                unselectedIcon: IconsaxOutline.user,
                index: 3,
                selectedPageIndex: selectedIndex!,
                onTap: _onItemTapped,
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          padding: const EdgeInsets.only(top: 20),
          child: FloatingActionButton(
            onPressed: () {
              // Arahkan ke halaman scan
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScanPage(),
                ),
              );
            },
            backgroundColor:
                neutralTheme, // Ganti dengan warna tema yang sesuai
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(30), // Sesuaikan radius tombol
            ),
            child: const Icon(
              IconsaxOutline.scan, // Ikon scan
              size: 28, // Ukuran ikon
              color: Colors.white, // Warna ikon
            ),
          ),
        ),
      ),
    );
  }
}
