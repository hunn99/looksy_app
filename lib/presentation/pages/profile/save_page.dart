import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looksy_app/presentation/pages/profile/save_detail.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/card/card_tips.dart';

import '../../bloc/hairstyle/hairstyle_bloc.dart';
import '../navigation/navigation.dart';

class SavePage extends StatefulWidget {
  const SavePage({Key? key}) : super(key: key);

  @override
  _SavePageState createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  // List<Hairstyle> hairstyles = [
  //   Hairstyle(
  //     name: "Buzz Cut",
  //     faceShape: "Square",
  //     imageUrl: "assets/images/Wavy.jpg",
  //     characteristics:
  //         "The Buzz Cut is characterized by very short and uniform hair length all over the head. This style offers a clean, neat appearance with sharp and defined hairlines.",
  //     faceSuitability:
  //         "This style is most suitable for oval, square, or triangular face shapes, as the short cut accentuates facial bone structure and the jawline.",
  //     maintenance:
  //         "The Buzz Cut requires minimal upkeep. Simply keep the scalp clean and moisturized to prevent dryness. A trim every 1-2 weeks helps maintain its neat look.",
  //     impression:
  //         "The Buzz Cut gives off a masculine, practical, and bold look. It’s often seen as a symbol of a minimalist yet stylish appearance.",
  //   ),
  //   Hairstyle(
  //     name: "Pompadour",
  //     faceShape: "Oval",
  //     imageUrl: "assets/images/Wavy.jpg",
  //     characteristics:
  //         "The Pompadour is a classic style that adds volume to the top while keeping the sides short. It’s bold and timeless.",
  //     faceSuitability:
  //         "This style works best for oval or square faces, enhancing the balance of facial features.",
  //     maintenance:
  //         "Requires regular styling and occasional trimming to maintain volume and neatness.",
  //     impression:
  //         "The Pompadour gives off a sophisticated yet daring impression, ideal for those who love vintage-inspired looks.",
  //   ),
  // ];

  // List<Hairstyle> savedHairstyles = [];

  // @override
  // void initState() {
  //   context.read<HairstyleBloc>().add(const GetHairstyleEvent());
  //   super.initState();
  // }

  // void toggleSave(Hairstyle hairstyle) {
  //   setState(() {
  //     if (savedHairstyles.contains(hairstyle)) {
  //       savedHairstyles.remove(hairstyle);
  //     } else {
  //       savedHairstyles.add(hairstyle);
  //     }
  //   });
  // }

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
          if (state is HairstyleLoading) {
            return const Center(child: CircularProgressIndicator());
          }
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
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: state.hairstyle.length,
                itemBuilder: (context, index) {
                  final hairstyle = state.hairstyle[index];
                  // bool isSaved = savedHairstyles.contains(hairstyle);
                  return TipsCard(
                    imagePath: hairstyle.photo,
                    title: hairstyle.hairStyle,
                    subtitle: "For ${hairstyle.faceShape} Face",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HairstyleDetailPage(
                            faceShape: hairstyle.faceShape,
                            hairstyleName: hairstyle.hairStyle,
                            imageUrl: hairstyle.photo,
                            characteristics: hairstyle.characteristics,
                            faceSuitability: hairstyle.faceSuitability,
                            maintenance: hairstyle.maintenance,
                            impression: hairstyle.impression,
                            //onSave: () => toggleSave(hairstyle), // Pass the save toggle function
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

class Hairstyle {
  final String name;
  final String faceShape;
  final String imageUrl;
  final String characteristics;
  final String faceSuitability;
  final String maintenance;
  final String impression;

  Hairstyle({
    required this.name,
    required this.faceShape,
    required this.imageUrl,
    required this.characteristics,
    required this.faceSuitability,
    required this.maintenance,
    required this.impression,
  });

  @override
  bool operator ==(other) {
    return other is Hairstyle && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
