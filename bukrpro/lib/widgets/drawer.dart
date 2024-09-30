import 'package:bukrpro/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustDrawer extends StatelessWidget {
  const CustDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
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
              )),
          ListTile(
            leading: TextButton(
                onPressed: () {
                  Get.to(() => TextFieldTest());
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
                onPressed: () {},
                child: Text(
                  'calls',
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
