import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String title;
  final String posterPath;
  const DetailPage({Key? key, required this.title, required this.posterPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Back',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        titleSpacing: -20,
        leadingWidth: 70,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Center(child: Text(title, style: TextStyle(fontSize: 20),)),
            ),
            SizedBox(height: 400 ,child: Image.network('https://image.tmdb.org/t/p/w185/$posterPath', fit: BoxFit.cover,))
          ],
        ),
      ),
    );
  }
}
