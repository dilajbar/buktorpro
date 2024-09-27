import 'package:bukrpro/screens/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
            padding: const EdgeInsets.only(
                left: 10, bottom: 50, right: 22, top: 160),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(bottom: 60),
                      child: const Text(
                        'Buktor Pro',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      )),
                ),
                CustomTextField(
                  nameController: nameController,
                  name: 'Username',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  nameController: passwordController,
                  name: 'Password',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 20),
                    child: SizedBox(
                        width: double.infinity,
                        // height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(ChatList());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5473bb),
                            //  elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            //shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 50,
                            ),
                          ),
                          //
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ))),
              ],
            )));
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, required this.nameController, required this.name});

  final TextEditingController nameController;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(3, 3),
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 10)
          ]),
      child: TextFormField(
          autofocus: false,
          controller: nameController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Enter Correct Name";
            } else {
              return null;
            }
          },
          onSaved: (value) {
            nameController.text = value!;
          },
          // textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              hintStyle: const TextStyle(color: Colors.grey),
              //   prefixIcon: Icon(Icons.vpn_key),
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: name,
              border: InputBorder.none)),
    );
  }
}
