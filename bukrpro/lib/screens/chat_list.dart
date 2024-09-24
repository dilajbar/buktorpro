import 'package:bukrpro/screens/chat_page.dart';
import 'package:bukrpro/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/chatModel.dart';
import '../providers/chatProvider.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
        borderRadius: BorderRadius.all(Radius.circular(20)));
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('hh:mm').format(now);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(
          'Chats',
          style: GoogleFonts.roboto(
              fontSize: 30, fontWeight: FontWeight.normal, color: Colors.black),
        ),
      ),
      drawer: const CustDrawer(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Name or Number',
                  hintStyle: TextStyle(fontSize: 15),
                  prefixIcon: Icon(Icons.search),
                  // border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: Messages.length,
                  itemBuilder: (context, index) {
                    final msg = Messages[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Text(msg.id.toString()),
                        ),
                        title: Text(
                          msg.name.toString(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(
                          msg.lastmsg.toString(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        trailing: Text(
                          formattedDate,
                          style: const TextStyle(fontSize: 15),
                        ),
                        onTap: () {
                          //   context.read<ChatProvider>().setSelectedchat(msg);

                          Navigator.pushNamed(context, '/chat');
                        },
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
