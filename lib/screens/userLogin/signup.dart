import 'package:creditbook/models/user_model.dart';
import 'package:creditbook/screens/userLogin/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../widgets/InputDeco_design.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage("assets/register.jpg"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10),
                        child: TextFormField(
                          controller: _name,
                          keyboardType: TextInputType.text,
                          decoration:
                              buildInputDecoration(Icons.person, "Full Name"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          decoration:
                              buildInputDecoration(Icons.email, "Email"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please a Enter';
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return 'Please a valid Email';
                            }
                            return null;
                          },
                          controller: _email,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration:
                              buildInputDecoration(Icons.phone, "Phone No"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter phone no ';
                            }
                            if (value.length != 10) {
                              return 'Enter correct phone no ';
                            }
                            return null;
                          },
                          controller: _phone,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10),
                        child: TextFormField(
                          controller: _password,
                          keyboardType: TextInputType.text,
                          decoration:
                              buildInputDecoration(Icons.lock, "Password"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please a Enter Password';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10),
                        child: TextFormField(
                          controller: _confirmpassword,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(
                              Icons.lock, "Confirm Password"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please re-enter password';
                            }
                            print(_password.text);
                            print(_confirmpassword.text);

                            if (_password.text != _confirmpassword.text) {
                              return "Password does not match";
                            }

                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              UserModel users = UserModel(
                                  name: _name.text,
                                  email: _email.text,
                                  phone: _phone.text,
                                  password: _password.text);
                              var box = await Hive.openBox<UserModel>('users');
                              box.add(users);
                              Get.off(()=>SigninPage());
                              return;
                            } else {
                              print("UnSuccessfull");
                            }
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 17.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account ? ",
                        style: TextStyle(color: Colors.blue, fontSize: 16)),
                    InkWell(
                      onTap: () {
                        Get.to(()=>SigninPage());
                      },
                      child: Text("Sign In",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                              fontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
