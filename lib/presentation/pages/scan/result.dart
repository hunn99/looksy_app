import 'dart:math' as math;
import 'dart:io';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looksy_app/presentation/bloc/scan/scan_bloc.dart';
import 'package:looksy_app/presentation/pages/scan/detail.dart';
import 'package:looksy_app/presentation/utils/text.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/buttons/button.dart';
import 'package:looksy_app/presentation/widgets/card/card_recommendation.dart';
import 'package:looksy_app/presentation/widgets/empthy/noRecommendation.dart'; // Pastikan untuk mengimpor ScanBloc

class ResultPage extends StatefulWidget {
  final File images;
  const ResultPage({super.key, required this.images});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    // Triggering the event to start the image upload and face shape detection
    context.read<ScanBloc>().add(UploadImageEvent(widget.images));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
              height: 300,
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              child: BlocBuilder<ScanBloc, ScanState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Container(
                        width: 180,
                        height: double
                            .infinity, // Tentukan ukuran yang sesuai jika perlu
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.file(
                              widget.images,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Face Shape', style: bodyGrey2),
                            state is ScanLoading // Show loading spinner when scanning
                                ? const CircularProgressIndicator()
                                : state is ScanFailed // Show error message if failed
                                    ? const Text(
                                        'No Face Shape Detected',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: redTheme,
                                        ),
                                      )
                                    : state is ScanSuccess // Show face shape if successful
                                        ? Text(
                                            state.hairstyles.first.faceShape,
                                            style: headingBlack,
                                          )
                                        : Text(
                                            'Tidak ada hasil',
                                            style: heading3Black,
                                          ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            BlocBuilder<ScanBloc, ScanState>(
              builder: (context, state) {
                if (state is ScanLoading) {
                  // Tampilkan indikator loading
                  return Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      color: neutralTheme,
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white), // Warna putih
                        ),
                      ),
                    ),
                  );
                } else if (state is ScanFailed) {
                  // Tampilkan pesan error
                  return const NoRecommendationFound();
                } else if (state is ScanSuccess) {
                  // Tampilkan hasil scan dengan daftar hairstyle
                  return Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      color: neutralTheme,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Choose your hairstyle',
                            style: headingWhite,
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.hairstyles.length,
                              itemBuilder: (context, index) {
                                final hairstyle = state.hairstyles[index];
                                bool isSelected = selectedIndex == index;

                                return Row(
                                  children: [
                                    HairstyleItem(
                                      imageUrl: hairstyle.photo,
                                      hairstyleName: hairstyle.hairStyle,
                                      isSelected: isSelected,
                                      onSelect: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                      index: index,
                                    ),
                                    const SizedBox(width: 12),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          LargeFillButtonWhite(
                            label: 'Choose',
                            onPressed: selectedIndex != null
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HairStyleDetailPage(
                                          hairstyle: state
                                              .hairstyles[selectedIndex ?? 0],
                                        ),
                                      ),
                                    );
                                  }
                                : () {}, // Disable button if no card is selected
                            isDisabled: selectedIndex ==
                                null, // Disable button if no selection
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
      ),
    );
  }
}
