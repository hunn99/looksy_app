import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:looksy_app/data/datasources/remote_datasources/auth_remote_datasources.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/form/text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:looksy_app/presentation/bloc/auth/auth_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    // Mengambil data dari AuthBloc untuk mengisi form
    final user = (context.read<AuthBloc>().state as AuthSuccess).user;
    _nameController.text = user.username;
    _emailController.text = user.email;
  }

  // Fungsi untuk memilih gambar
  Future<void> _pickImage() async {
    if (kIsWeb) {
      // Untuk aplikasi web, menggunakan file_picker
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        setState(() {
          _image = File(result.files.single.path!); // Perbarui _image
        });
        print("Image selected: ${_image?.path}"); // Debug
      }
    } else {
      // Untuk perangkat mobile, menggunakan image_picker
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path); // Perbarui _image
        });
        print("Image selected: ${_image?.path}"); // Debug
      }
    }
  }

  // Fungsi untuk menyimpan perubahan ke backend
  void _saveChanges() async {
    final authService = AuthServices();

    final result = await authService.updateProfile(
      username: _nameController.text,
      email: _emailController.text,
      profileImagePath: _image?.path,
    );

    result.fold(
      (error) {
        // Tampilkan pesan kesalahan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $error')),
        );
      },
      (updatedUser) {
        // Tampilkan pesan berhasil
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );

        // Kembali ke halaman sebelumnya
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
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
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Foto Profil
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: _image != null
                              ? FileImage(
                                  _image!) // Gambar dari file yang dipilih
                              : (state.user.profileImage != null
                                  ? NetworkImage(state.user
                                      .profileImage!) // Gambar dari backend
                                  : null),
                          child:
                              _image == null && state.user.profileImage == null
                                  ? const Icon(Icons.person,
                                      size: 50) // Ikon default
                                  : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
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
                    CustomTextField(
                      label: "Name",
                      hintText: "Enter your name",
                      controller: _nameController,
                    ),
                    const SizedBox(height: 20),
                    // Field untuk Email
                    CustomTextField(
                      label: "Email",
                      hintText: "Enter your email",
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 30),
                    // Tombol Simpan
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: neutralTheme,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: _saveChanges,
                        child: const Text(
                          "Save Changes",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
