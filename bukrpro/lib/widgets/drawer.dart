import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/audio_page.dart';

class CustDrawer extends StatelessWidget {
  const CustDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 100,
                        child: Image.network(
                            'https://media.istockphoto.com/id/1857528212/vector/beautiful-woman-doctor-in-a-lab-coat-with-a-stethoscope.jpg?s=2048x2048&w=is&k=20&c=vlm0peV18DM5Vt7qI-97x9GbkyhUORrp-LOTBcy0A3Q=')),
                    Text(
                      'book',
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black38),
                    ),
                  ],
                ),
              )),
          ListTile(
            leading: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/chatslist');
                },
                child: Text(
                  'Chats',
                  style: GoogleFonts.comfortaa(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38),
                )),
          ),
          ListTile(
            leading: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AudioRecorderScreen()));
                },
                child: Text(
                  'record audio',
                  style: GoogleFonts.comfortaa(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38),
                )),
          ),
          ListTile(
            leading: TextButton(
                onPressed: () async {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  'log out',
                  style: GoogleFonts.comfortaa(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38),
                )),
          )
        ],
      ),
    );
  }
}
