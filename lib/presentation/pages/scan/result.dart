import 'dart:math' as math;
import 'dart:io';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looksy_app/domain/entities/hairstyle.dart';
import 'package:looksy_app/presentation/bloc/scan/scan_bloc.dart';
import 'package:looksy_app/presentation/pages/scan/detail.dart';
import 'package:looksy_app/presentation/utils/text.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/buttons/button.dart';
import 'package:looksy_app/presentation/widgets/card/card_recommendation.dart'; // Pastikan untuk mengimpor ScanBloc

class ResultPage extends StatefulWidget {
  final File images;
  const ResultPage({super.key, required this.images});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();
    print(widget.images);
    // Triggering the event to start the image upload and face shape detection
    context.read<ScanBloc>().add(UploadImageEvent(widget.images));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(IconsaxOutline.arrow_left, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Result', style: TextStyle(color: Colors.white)),
        backgroundColor: neutralTheme,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: BlocBuilder<ScanBloc, ScanState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      SizedBox(
                        width: 180,
                        height: 220,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              widget.images,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text('Face Shape', style: bodyGrey2),
                      state is ScanLoading // Show loading spinner when scanning
                          ? const CircularProgressIndicator()
                          : state is ScanFailed // Show error message if failed
                              ? const Text(
                                  'Wajah tidak terdeteksi',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: redTheme,
                                  ),
                                )
                              : state is ScanSuccess // Show face shape if successful
                                  ? Text(
                                      state.hairstyles.first.faceShape,
                                      style: heading3Black,
                                    )
                                  : Text(
                                      'Tidak ada hasil',
                                      style: heading3Black,
                                    ),
                    ],
                  );
                },
              ),
            ),
          ),
          BlocBuilder<ScanBloc, ScanState>(
            builder: (context, state) {
              if (state is ScanLoading) {
                // Tampilkan indikator loading
                return const Center(child: CircularProgressIndicator());
              } else if (state is ScanFailed) {
                // Tampilkan pesan error
                return const Center(
                  child: Text(
                    'Wajah tidak terdeteksi',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: redTheme,
                    ),
                  ),
                );
              } else if (state is ScanSuccess) {
                // Tampilkan hasil scan dengan daftar hairstyle
                return Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    color: neutralTheme,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Choose your hairstyle',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.hairstyles.length,
                            itemBuilder: (context, index) {
                              final hairstyle = state.hairstyles[index];
                              return HairstyleItem(
                                imageUrl: hairstyle.photo,
                                hairstyleName: hairstyle.hairStyle,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        LargeFillButtonWhite(
                          label: 'Next',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HairStyleDetailPage(
                                    hairstyle: state.hairstyles.first),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                // Kondisi default jika tidak ada data
                return const Center(child: Text('Tidak ada hasil.'));
              }
            },
          ),
        ],
      ),
    );
  }

  // Helper method to build hairstyle items
}
