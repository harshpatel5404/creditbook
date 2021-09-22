import 'package:creditbook/controller/controller.dart';
import 'package:creditbook/models/user_model.dart';
import 'package:creditbook/screens/userLogin/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../dashboard.dart';
import '../../widgets/InputDeco_design.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  List<UserModel> userlist = [];

  final Controller controller = Get.put(Controller());
  void getUsers() async {
    final box = await Hive.openBox<UserModel>('users');
    setState(() {
      userlist = box.values.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    void searchemailpass(String email, String password) {
      var semail;
      var spass;

      userlist.forEach((e) {
        semail = e.email.toLowerCase();
        spass = e.password.toLowerCase();

        print("email $email");
        print("pass $password");
        print("semail $semail");
        print("spass $spass");

        if (semail == email && spass == password) {
          controller.isLogin.value = true;
          print("match");
        }
      });
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage("assets/login.png"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: buildInputDecoration(Icons.email, "Email"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter email';
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return 'Enter valid Email';
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
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          searchemailpass(_email.text, _password.text);
                          print("object");
                          if (_formkey.currentState!.validate()) {
                            if (controller.isLogin.value) {
                              Get.off(() => Dashboard());
                            } else {
                              final snackBar = SnackBar(
                                  content:
                                      Text('Email and Password are wrong!'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                            return;
                          }
                        },
                        child: Text(
                          "Login",
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Don't have an account ? ",
                      style: TextStyle(color: Colors.blue, fontSize: 16)),
                  InkWell(
                    onTap: () {
                      Get.to(() => SignupPage());
                    },
                    child: Text("Sign Up",
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
    );
  }
}
