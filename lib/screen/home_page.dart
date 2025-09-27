import 'package:flutter/material.dart';
import 'package:olah_data/data/game_store_data.dart';
import 'package:olah_data/screen/login_page.dart';
import 'package:olah_data/screen/detail_page.dart';
import 'package:olah_data/screen/profile_page.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        // automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              // pindah ke ProfilePage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {
              _logout(context);
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Selamat Datang $username",
              style: const TextStyle(fontSize: 25),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return _gameStore(context, index);
                  },
                  itemCount: gameList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const LoginPage();
        },
      ),
      (route) => false,
    );
  }

  Widget _gameStore(context, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(game: gameList[index]),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.amber,
          border: Border.all(width: 2),
        ),
        child: Column(
          children: [
            Image.network(
              gameList[index].imageUrls[0],
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Text(
              gameList[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text("Review : ${gameList[index].reviewAverage}"),
          ],
        ),
      ),
    );
  }
}
