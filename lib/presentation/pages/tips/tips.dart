import 'package:flutter/material.dart';
import 'package:looksy_app/presentation/utils/theme.dart';
import 'straight_detail.dart';
import 'wavy_detail.dart';
import 'curly_detail.dart';
import 'frizz_detail.dart';

class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Hair Tips Care',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: neutralTheme,
          toolbarHeight: 80,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 12.0,
              childAspectRatio: 0.8,
            ),
            children: [
              _buildTipCard(context, "Straight", StraightDetailPage()),
              _buildTipCard(context, "Wavy", WavyDetailPage()),
              _buildTipCard(context, "Curly", const CurlyDetailPage()),
              _buildTipCard(context, "Frizzy", const FrizzDetailPage()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipCard(BuildContext context, String title, Widget detailPage) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => detailPage),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(
                  "assets/images/$title.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hair Care Tips",
                    style: TextStyle(fontSize: 12, color: neutralTheme[300]!),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
