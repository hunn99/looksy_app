import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looksy_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:looksy_app/presentation/pages/profile/change_password.dart';
import 'package:looksy_app/presentation/pages/profile/edit_page.dart';
import 'package:looksy_app/presentation/pages/profile/help_center.dart';
import 'package:looksy_app/presentation/pages/profile/save_page.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/modals/dialog.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:looksy_app/presentation/widgets/modals/dialogsuccess.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              final user = state.user; // Dapatkan data pengguna dari state
              return Column(
                children: [
                  // Header Profil
                  Container(
                    color: neutralTheme,
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Foto Profil
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: neutralTheme[200],
                              radius: 32,
                              backgroundImage: user.profileImage != null
                                  ? NetworkImage(user.profileImage!)
                                  : null,
                              child: user.profileImage == null
                                  ? const Icon(Icons.person, size: 50)
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.username,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  user.email,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey[300]),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Username dan Email

                        // Ikon Edit Profil
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
                  // Daftar Opsi
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Container untuk Save, Change Password, dan Help Center
                        Container(
                          // margin: const EdgeInsets.symmetric(horizontal: 20),
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
                                        builder: (context) =>
                                            ChangePasswordPage()),
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
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFFE7E7E7)),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: ProfileOption(
                            icon: const Icon(IconsaxOutline.logout,
                                size: 24, color: redTheme),
                            title: 'Logout',
                            titleColor: redTheme,
                            iconColor: redTheme,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => const LogoutDialog(),
                              );
                            },
                            hasDivider: false,
                            showArrowIcon: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              // Jika user belum login atau ada masalah autentikasi
              return const Center(child: Text('No user data available'));
            }
          },
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
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.titleColor,
    this.iconColor,
    this.hasDivider = false,
    this.showArrowIcon = true,
  });

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
