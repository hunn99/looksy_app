import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:looksy_app/presentation/pages/scan/result.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:path_provider/path_provider.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late CameraController controller;

  Future<void> initializeCamera() async {
    var cameras = await availableCameras();
    controller = CameraController(
      cameras[
          1], // Pastikan ini adalah kamera depan jika Anda ingin membalik gambar
      ResolutionPreset.high,
      enableAudio: false,
    );
    await controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<File> takePicture() async {
    Directory root = await getTemporaryDirectory();
    String directoryPath = '${root.path}/Scan_Face';
    await Directory(directoryPath).create(recursive: true);
    String filePath = '$directoryPath/${DateTime.now()}.jpg';

    try {
      XFile picture = await controller.takePicture();
      await picture.saveTo(filePath);
      return File(filePath);
    } catch (e) {
      return File('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: neutralTheme,
        body: FutureBuilder(
            future: initializeCamera(),
            builder: (_, snapshot) => (snapshot.connectionState ==
                    ConnectionState.done)
                ? Column(
                    children: [
                      Stack(
                        children: [
                          // Layer untuk CameraPreview
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width * 1.65,
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(
                                  math.pi), // Membalik gambar horizontal
                              child: CameraPreview(controller),
                            ),
                          ),
                          // Overlay untuk image asset
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/Subtract.png',
                              fit: BoxFit.cover, // Mengisi seluruh ukuran
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white, // Warna background luar
                                border: Border.all(
                                    color: Colors.black,
                                    width: 2), // Garis tepi hitam
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  backgroundColor:
                                      Colors.white, // Warna background dalam
                                  padding: EdgeInsets.all(
                                      20), // Sesuaikan padding agar ukuran lingkaran sesuai
                                  elevation: 0, // Menghilangkan bayangan tombol
                                ),
                                onPressed: () async {
                                  if (!controller.value.isTakingPicture) {
                                    File result = await takePicture();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResultPage(
                                          images: result,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: const CircularProgressIndicator(),
                    ),
                  )),
      ),
    );
  }
}
