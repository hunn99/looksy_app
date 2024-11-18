import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
// import 'package:looksy/presentation/pages/onboarding/onboarding.dart';
import 'package:looksy_app/presentation/pages/profile/change_password.dart';
import 'package:looksy_app/presentation/pages/profile/edit_page.dart';
import 'package:looksy_app/presentation/pages/profile/help_center.dart';
import 'package:looksy_app/presentation/pages/profile/save_page.dart';
import 'package:looksy_app/presentation/services/auth_services.dart'; 
import 'package:go_router/go_router.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // Menambahkan SafeArea di sini
        child: Column(
          children: [
            // Header Profil
            Container(
              width: double.infinity,
              color: neutralTheme,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 16), // Jarak awal
                  // Foto Profil
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/Straight.jpg'),
                  ),
                  const SizedBox(width: 16), // Jarak antara foto dan teks
                  // Kolom untuk Nama dan Email
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Satria Abrar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'satria.abrar@gmail.com',
                          style: TextStyle(
                              color: neutralTheme[300]!,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  // Ikon Edit
                  IconButton(
                    icon: const Icon(IconsaxOutline.edit_2,
                        size: 24, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfilePage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Daftar Opsi
            Expanded(
              child: Column(
                children: [
                  // Container untuk Save, Change Password, dan Help Center
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFE7E7E7)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        ProfileOption(
                          icon: const Icon(IconsaxBold.archive_1,
                              size: 24, color: neutralTheme),
                          title: 'Save',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SavePage()),
                            );
                          },
                          hasDivider: true,
                        ),
                        ProfileOption(
                          icon: const Icon(IconsaxBold.shield_security,
                              size: 24, color: neutralTheme),
                          title: 'Change Password',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangePasswordPage()),
                            );
                          },
                          hasDivider: true,
                        ),
                        ProfileOption(
                          icon: const Icon(IconsaxBold.message_question,
                              size: 24, color: neutralTheme),
                          title: 'Help Center',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HelpCenterPage()),
                            );
                          },
                          hasDivider: false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFE7E7E7)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ProfileOption(
                      icon: const Icon(IconsaxOutline.logout, size: 24, color: redTheme),
                      title: 'Logout',
                      titleColor: redTheme,
                      iconColor: redTheme,
                      onTap: () async {
                        await AuthServices().logout(); // Panggil logout
                        context.go('/login');
                        // Navigator.of(context).pushAndRemoveUntil(
                        //   MaterialPageRoute(builder: (context) => const OnboardingPage()),
                        //   (Route<dynamic> route) => false, // Menghapus semua route yang ada
                        // );
                      },
                      hasDivider: false,
                      showArrowIcon: false,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final Widget icon;
  final String title;
  final Color? titleColor;
  final Color? iconColor;
  final GestureTapCallback onTap;
  final bool hasDivider;
  final bool showArrowIcon;

  const ProfileOption({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.titleColor,
    this.iconColor,
    this.hasDivider = false,
    this.showArrowIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: hasDivider
              ? const Border(
                  bottom: BorderSide(color: Color(0xFFE7E7E7)),
                )
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                const SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: titleColor ?? neutralTheme,
                  ),
                ),
              ],
            ),
            if (showArrowIcon)
              const Icon(IconsaxOutline.arrow_right_3,
                  size: 20, color: neutralTheme),
          ],
        ),
      ),
    );
  }
}
