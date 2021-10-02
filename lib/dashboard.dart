import 'package:creditbook/add_contacts.dart';
import 'package:creditbook/main.dart';
import 'package:creditbook/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  bool isget =true;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue[800],
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_)=> AddContacts()));
        },
        label: Row(
          children: [Icon(Icons.add), Text("Add Customer")],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                // Background with gradient
                Container(
                  color: Colors.blue[800],
                  height: MediaQuery.of(context).size.height * 0.21,
                ),

                Card(
                    margin:
                        EdgeInsets.only(left: 15.0, right: 15.0, top: 100.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.16,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "25000",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.green),
                                  ),
                                  Text("You will give"),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "25000",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.red),
                                  ),
                                  Text("You will get"),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            height: 5,
                          ),
                          Text(
                            "View Report >",
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          ),
                        ],
                      ),
                    )),

                Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.blue[800],
                    leading: Icon(Icons.book_outlined,size: 25,),
                    title: Row(
                      children: [
                        Text("Credit Book"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(Icons.edit_outlined),
                        )
                      ],
                    ),
                    actions: [
                      Icon(Icons.paid_outlined,size: 30,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.calendar_today_outlined,size: 25,),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SearchWidget(
              hintText: 'Serch Customer ',
              onChanged: (String value) {},
              text: '',
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.70,
              child: ListView.builder(
                
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          leading: CircleAvatar(backgroundColor: Colors.blue),
                          title: Text("Hello",style: TextStyle(fontSize: 18),),
                          subtitle: Text("ooooooooo"),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("25000",style: TextStyle(color: isget?Colors.green:Colors.red,fontSize: 18)),
                              Text("You Will Give"),
                            ],
                          ),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(
                          
                          height: 5,
                        ),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
