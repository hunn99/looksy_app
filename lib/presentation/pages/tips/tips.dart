import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looksy_app/data/datasources/remote_datasources/tips_remote_datasources.dart';
import 'package:looksy_app/main.dart';
import 'package:looksy_app/presentation/utils/text.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'package:looksy_app/presentation/widgets/card/card_tips.dart';
import 'tips_detail.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({super.key});

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  final TipsServices _tipsServices = TipsServices();
  List<Map<String, dynamic>> hairTipsData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHairTips();
  }

  // Fungsi untuk memuat data tips dari API
  Future<void> _loadHairTips() async {
    try {
      final fetchedTips = await _tipsServices.fetchHairTips();
      setState(() {
        hairTipsData = fetchedTips;
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching hair tips: $error');
      setState(() {
        hairTipsData = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          _loadHairTips();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Hair Tips Care', style: heading3White),
            backgroundColor: neutralTheme,
            toolbarHeight: 80,
            leading: null,
          ),
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 12.0,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: hairTipsData.length,
                    itemBuilder: (context, index) {
                      final tipsData = hairTipsData[index];
                      print('Tips Data: $tipsData'); // Debug data tips

                      return TipsCard(
                        imagePath: tipsData['photo'],
                        title: tipsData['hair_type'],
                        subtitle: 'Hair Type',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TipsDetailPage(
                                title: tipsData['hair_type'],
                                subtitle: 'Hair Type',
                                imagePath: tipsData['photo'],
                                characteristic: tipsData['characteristic_hair'],
                                description: tipsData['description'],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
