import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  static const ROUTE_NAME = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: Color.fromARGB(255, 48, 100, 160),
                  child: Center(
                    child: Image.asset(
                      'assets/avatarUserLogIn.png',
                      width: 128,
                    ),
                  ),
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  'CINTA FILM',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromARGB(221, 31, 31, 31),
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
                Icon(Icons.favorite,
                    size: 40, color: Color.fromARGB(255, 187, 9, 9))
              ]),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  alignment: Alignment.center,
                  color: Colors.blueAccent,
                  child: Text(
                    'cinta film merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.',
                    style: TextStyle(
                        color: Color.fromARGB(221, 255, 255, 255),
                        fontSize: 20),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
            ),
          )
        ],
      ),
    );
  }
}
