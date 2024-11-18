import 'package:flutter/material.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set default values or fetch existing user data here
    _nameController.text = "Satria Abrar"; // example default name
    _emailController.text = "satria.abrar@gmail.com"; // example default email
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          backgroundColor: neutralTheme,
          leading: IconButton(
            icon: const Icon(IconsaxOutline.arrow_left, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Foto Profil
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/Straight.jpg'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // Add image picker functionality here
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: neutralTheme,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          IconsaxOutline.camera,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Field untuk Nama
              TextField(
                controller: _nameController,
                style: TextStyle(
                  color: neutralTheme[300]!,
                ),
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: const TextStyle(
                    color: neutralTheme,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        BorderSide(color: neutralTheme[100]!, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: neutralTheme, width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Field untuk Email
              TextField(
                controller: _emailController,
                style: TextStyle(
                  color: neutralTheme[300]!,
                ),
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: const TextStyle(
                    color: neutralTheme,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        BorderSide(color: neutralTheme[100]!, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: neutralTheme, width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Tombol Simpan
              ElevatedButton(
                onPressed: () {
                  // Simpan perubahan (Update data pengguna)
                  // Add save functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: neutralTheme,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
