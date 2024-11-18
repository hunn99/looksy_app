import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/pages/history/historypage.dart';
import 'package:looksy_app/presentation/pages/home/homepage.dart';
import 'package:looksy_app/presentation/pages/profile/profile_page.dart';
import 'package:looksy_app/presentation/pages/scan/scan.dart';
import 'package:looksy_app/presentation/pages/tips/tips.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (_selectedIndex == 2) {
      // Jika di halaman ScanPage (index 2), kembali ke HomePage
      setState(() {
        _selectedIndex = 0;
        _pageController.jumpToPage(0);
      });
      return false; // Mencegah keluar dari aplikasi
    }
    return true; // Mengizinkan keluar dari aplikasi jika di halaman lain
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Menangani aksi tombol "kembali"
      child: SafeArea(
        child: Scaffold(
          appBar: _selectedIndex == 2
              ? AppBar(
                  leading: IconButton(
                    icon: Icon(
                      IconsaxOutline.arrow_left,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 0; // Kembali ke HomePage
                        _pageController.jumpToPage(0);
                      });
                    },
                  ),
                  title: Text("Back", style: TextStyle(color: Colors.white)),
                  backgroundColor: neutralTheme,
                )
              : null,
          body: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomePage(),
              TipsPage(),
              ScanPage(),
              HistoryPage(),
              ProfilePage(),
            ],

          ),
          // Menampilkan BottomNavigationBar kecuali di halaman ScanPage
          bottomNavigationBar: _selectedIndex != 2
              ? BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  selectedLabelStyle:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  unselectedLabelStyle:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  selectedItemColor: neutralTheme,
                  unselectedItemColor: neutralTheme,
                  showUnselectedLabels: true,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: (_selectedIndex == 0)
                          ? Icon(IconsaxBold.home_1,
                              size: 24, color: neutralTheme)
                          : Icon(IconsaxOutline.home,
                              size: 24, color: neutralTheme),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: (_selectedIndex == 1)
                          ? Icon(IconsaxBold.magicpen,
                              size: 24, color: neutralTheme)
                          : Icon(IconsaxOutline.magicpen,
                              size: 24, color: neutralTheme),
                      label: 'Tips',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: neutralTheme,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _selectedIndex == 2
                              ? IconsaxBold.scan
                              : IconsaxOutline.scan,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: (_selectedIndex == 3)
                          ? Icon(IconsaxBold.document_text,
                              size: 24, color: neutralTheme)
                          : Icon(IconsaxOutline.document_text,
                              size: 24, color: neutralTheme),
                      label: 'History',
                    ),
                    BottomNavigationBarItem(
                      icon: (_selectedIndex == 4)
                          ? Icon(IconsaxBold.user,
                              size: 24, color: neutralTheme)
                          : Icon(IconsaxOutline.user,
                              size: 24, color: neutralTheme),
                      label: 'Profile',
                    ),
                  ],
                )
              : null, // Tidak menampilkan BottomNavigationBar jika di halaman ScanPage
        ),
      ),
    );
  }
}
