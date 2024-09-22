import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
        borderRadius: BorderRadius.all(Radius.circular(20)));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buktor Pro',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Login',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'UserName',
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  // hintText: 'Password',
                  labelText: 'Password',
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Forgot Password',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/chatslist');
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.greenAccent),
                  fixedSize: WidgetStatePropertyAll(Size(double.infinity, 50))

                  //   minimumSize: WidgetStatePropertyAll(Size(double.infinity, 50))
                  ),
            ),
          ]),
    );
  }
}
