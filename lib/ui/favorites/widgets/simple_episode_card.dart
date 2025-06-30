import 'package:app/ui/_core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SimpleEpisodeCard extends StatelessWidget {
  const SimpleEpisodeCard({
    super.key,
    required this.title,
    required this.date,
    required this.numberCharacters,
    required this.episode,
    required this.imagePath,
  });

  final String title;
  final String date;
  final String numberCharacters;
  final String episode;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.shade800, spreadRadius: 1, blurRadius: 7)],
      ),
      child: Row(
        spacing: 10,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 120,
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Episode: ',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        TextSpan(
                          text: episode,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Title: ',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        TextSpan(
                          text: title,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Date: ',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        TextSpan(
                          text: date,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Number of Characters: ',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        TextSpan(
                          text: numberCharacters,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: NetworkImage(imagePath), fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
