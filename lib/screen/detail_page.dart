import 'package:flutter/material.dart';
import 'package:olah_data/models/game_store_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final GameStore game;

  const DetailPage({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(game.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // gambar utama
            Center(
              child: Image.network(
                game.imageUrls[0],
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            Text(
              game.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text("Release Date: ${game.releaseDate}"),
            Text("Price: ${game.price}"),
            Text("Review: ${game.reviewAverage} (${game.reviewCount} reviews)"),

            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: game.tags.map((tag) => Chip(label: Text(tag))).toList(),
            ),

            const SizedBox(height: 16),
            Text(game.about, style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                final Uri url = Uri.parse(game.linkStore);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
              icon: const Icon(Icons.open_in_new),
              label: const Text("Buka di Steam Store"),
            ),

            const SizedBox(height: 20),
            // tampilkan gambar lain
            const Text(
              "Gallery",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: game.imageUrls.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(game.imageUrls[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
