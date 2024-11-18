import 'dart:io';
import 'dart:math' as math;

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:looksy_app/presentation/utils/theme.dart';

class ResultPage extends StatefulWidget {
  ResultPage({super.key, required this.images});
  final File images;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              IconsaxOutline.arrow_left,
              color: neutralTheme,
            ),
            onPressed: () {
              context.pop('/scan');
            },
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 12),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 160,
                      height: 220,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(
                            math.pi), // Membalik gambar secara horizontal
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              12), // Sesuaikan radius sesuai kebutuhan
                          child: Image.file(
                            widget.images,
                            fit: BoxFit
                                .cover, // Meny esuaikan gambar agar memenuhi Container
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Face Shape',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: neutralTheme[300]),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'Tidak berbentuk',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: neutralTheme,
                          letterSpacing: -1),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: neutralTheme,
                child: const Column(
                  children: [
                    Text('Choose your hairstyle',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
