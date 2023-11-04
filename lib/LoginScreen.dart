import 'package:flutter/material.dart';
import 'package:multi_role_app/HomeScreen.dart';
import 'package:multi_role_app/StudentScreen.dart';
import 'package:multi_role_app/TeacherScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    //Variables
    final emailController = TextEditingController();
    final passController = TextEditingController();

    List<String> listItems = ['Admin', 'Teacher', 'Student'];
    String? dropDownValue = listItems[0];

    //Scaffold
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Sign Up')),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 50,
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  hintText: 'Enter Email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: passController,
                obscureText: true,
                obscuringCharacter: '*',
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Enter Password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              DropdownButton(
                value: dropDownValue,
                onChanged: (String? val) async {
                  dropDownValue = val!;

                  SharedPreferences pref =
                      await SharedPreferences.getInstance();

                  if (dropDownValue == 'Admin') {
                    pref.setString('userType', 'admin');
                  }
                  if (dropDownValue == 'Student') {
                    pref.setString('userType', 'student');
                  }
                  if (dropDownValue == 'Teacher') {
                    pref.setString('userType', 'teacher');
                  }
                },
                items: listItems.map((e) {
                  return DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  );
                }).toList(),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    prefs.setString('email', emailController.text.toString());
                    prefs.setString('password', passController.text.toString());

                    prefs.setBool('isLogin', true);

                    if (prefs.getString('userType') == 'teacher') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => TeacherScreen())));
                    } else if (prefs.getString('userType') == 'student') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => StudentScreen())));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
