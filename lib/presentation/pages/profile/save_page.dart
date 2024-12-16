import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looksy_app/presentation/pages/profile/save_detail.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/card/card_tips.dart';

import '../../bloc/hairstyle/hairstyle_bloc.dart';
import '../navigation/navigation.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  SavePageState createState() => SavePageState();
}

class SavePageState extends State<SavePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Save',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Ikon kembali
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const NavigationPage(
                initialIndex: 3,
              ),
            ));
          },
        ),
        backgroundColor: neutralTheme,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<HairstyleBloc, HairstyleState>(
        builder: (context, state) {
          if (state is HairstyleFailed) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          if (state is HairstyleSuccess) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: state.hairstyle.length,
                itemBuilder: (context, index) {
                  final hairstyle =
                      state.hairstyle[state.hairstyle.length - index - 1];
                  return TipsCard(
                    imagePath: hairstyle.photo,
                    title: hairstyle.hairStyle, // Hair Style
                    subtitle: 'Hair Style',
                    // subtitle: "For ${hairstyle.faceShape} Face",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SaveDetailPage(
                            hairstyle: hairstyle,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
