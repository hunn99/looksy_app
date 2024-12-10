import 'dart:io';
import 'dart:math' as math;

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:looksy_app/presentation/pages/scan/result.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:path_provider/path_provider.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  ScanPageState createState() => ScanPageState();
}

class ScanPageState extends State<ScanPage> {
  late CameraController controller;
  int selectedIndex = 1;
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    controller = CameraController(
      cameras[selectedIndex],
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );
    await controller.initialize();
    setState(() {
      isCameraInitialized = true;
    });
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
        body: isCameraInitialized
            ? Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 1.8,
                        child: selectedIndex == 1 // Kamera depan
                            ? Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: CameraPreview(controller),
                              )
                            : CameraPreview(
                                controller), // Kamera belakang tanpa transform
                      ),
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/Subtract.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          iconSize: 40,
                          icon: const Icon(IconsaxOutline.arrow_left,
                              color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: neutralTheme[100]!,
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: Colors.white,
                              elevation: 0,
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
                        IconButton(
                          iconSize: 40,
                          icon: const Icon(IconsaxOutline.refresh_circle,
                              color: Colors.white),
                          onPressed: () async {
                            await controller.dispose();
                            selectedIndex = selectedIndex == 0 ? 1 : 0;
                            await initializeCamera();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
