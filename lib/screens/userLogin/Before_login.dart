import 'package:creditbook/controller/controller.dart';
import 'package:creditbook/screens/userLogin/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Beforelogin extends StatefulWidget {
  Beforelogin({Key? key}) : super(key: key);

  @override
  _BeforeloginState createState() => _BeforeloginState();
}

List data = [
  {
    "img": "beforelogin1.png",
    "title": "What is credit book ?",
    "txt":
        "Credit book App is an app which help user manage their all exprnce and income. "
  },
  {
    "img": "beforelogin2.png",
    "title": "Why we use credit book ?",
    "txt":
        "Our Credit book app is 100% free, secure, safe with best user interface to manage your transaction."
  },
  {"img": "beforelogin3.png", "title": "Ready to save money", "txt": ""},
];

final controller = Get.put(Controller());
var ind = 0;

class _BeforeloginState extends State<Beforelogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.60,
              child: PageView.builder(
                onPageChanged: (index) {
                  controller.selectind.value = index;
                  if (index == 2) {
                    controller.btntxt.value = "Start";
                  } else {
                    controller.btntxt.value = "Skip";
                  }
                },
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            height: 200,
                            width: 200,
                            child: Image.asset("assets/${data[index]["img"]}")),
                        Text(
                          data[index]["title"],
                           textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30, color: Colors.lightBlue[900]),
                        ),
                        Text(
                         
                          data[index]["txt"],
                           textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 18, color: Colors.blue[400]),
                        ),
                      ],
                    ),
                  );
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              data.length,
              (index) => Obx(() {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: controller.selectind.value == index
                          ? Colors.orangeAccent
                          : Colors.grey,
                    ),
                    height: 10,
                    width: controller.selectind.value == index ? 25 : 10,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: Obx(()=>
         Visibility(
          visible: controller.selectind.value == 2 ? true : false,
          child: FloatingActionButton.extended(
            label: Text(
              "Start",
              style: TextStyle(fontSize: 15),
            ),
            onPressed: () {

               controller.getPermission(context); 
              
              Get.to(() => SignupPage());
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        ),
      ),
    );
  }
}
