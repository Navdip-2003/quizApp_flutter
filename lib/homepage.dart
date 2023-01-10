import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:quizeapp/resultpage.dart';
import 'package:quizeapp/startpage.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  var ss = {
  "questions": [
  {
  "question": "What is the scientific name of a butterfly?",
  "answers": [
  "Apis",
  "Coleoptera",
  "Formicidae",
  "Rhopalocera"
  ],
  "correctIndex": 3
  },
  {
  "question": "How hot is the surface of the sun?",
  "answers": [
  "1,233 K",
  "5,778 K",
  "12,130 K",
  "101,300 K"
  ],
  "correctIndex": 1
  },
  {
  "question": "Who are the actors in The Internship?",
  "answers": [
  "Ben Stiller, Jonah Hill",
  "Courteney Cox, Matt LeBlanc",
  "Kaley Cuoco, Jim Parsons",
  "Vince Vaughn, Owen Wilson"
  ],
  "correctIndex": 3
  },
  {
  "question": "What is the capital of Spain?",
  "answers": [
  "Berlin",
  "Buenos Aires",
  "Madrid",
  "San Juan"
  ],
  "correctIndex": 2
  },
  {
  "question": "What are the school colors of the University of Texas at Austin?",
  "answers": [
  "Black, Red",
  "Blue, Orange",
  "White, Burnt Orange",
  "White, Old gold, Gold"
  ],
  "correctIndex": 2
  },
  {
  "question": "What is 70 degrees Fahrenheit in Celsius?",
  "answers": [
  "18.8889",
  "20",
  "21.1111",
  "158"
  ],
  "correctIndex": 2
  },
  {
  "question": "When was Mahatma Gandhi born?",
  "answers": [
  "October 2, 1869",
  "December 15, 1872",
  "July 18, 1918",
  "January 15, 1929"
  ],
  "correctIndex": 0
  },
  {
  "question": "How far is the moon from Earth?",
  "answers": [
  "7,918 miles (12,742 km)",
  "86,881 miles (139,822 km)",
  "238,400 miles (384,400 km)",
  "35,980,000 miles (57,910,000 km)"
  ],
  "correctIndex": 2
  },
  {
  "question": "What is 65 times 52?",
  "answers": [
  "117",
  "3120",
  "3380",
  "3520"
  ],
  "correctIndex": 2
  },
  {
  "question": "How tall is Mount Everest?",
  "answers": [
  "6,683 ft (2,037 m)",
  "7,918 ft (2,413 m)",
  "19,341 ft (5,895 m)",
  "29,029 ft (8,847 m)"
  ],
  "correctIndex": 3
  },
  {
  "question": "When did The Avengers come out?",
  "answers": [
  "May 2, 2008",
  "May 4, 2012",
  "May 3, 2013",
  "April 4, 2014"
  ],
  "correctIndex": 1
  },
  {
  "question": "What is 48,879 in hexidecimal?",
  "answers": [
  "0x18C1",
  "0xBEEF",
  "0xDEAD",
  "0x12D591"
  ],
  "correctIndex": 1
  }
  ]
  };
  
  int index = 0;
  List qua_database = [
    {
      "question": "What is the capital of Spain?",
      "answers": [
      "Berlin",
      "Buenos Aires","Madrid" , "San"
      ],
      "correctIndex": "Madrid"
      
    },
    {
      "question": "What is 48,879 in hexidecimal?",
      "answers": [
      "0x18C1",
      "0xBEEF",
      "0xDEAD",
      "0x12D591"
      ],
      "correctIndex": "0x18C1"
      
    },

  ];
  int answers_count = 0;
  Future get_data() async{
    var responce = await http.get(Uri.parse("https://opentdb.com/api.php?amount=10&category=18&difficulty=easy"));
    if(responce.statusCode == 200){
      print(jsonDecode(responce.body));
    }
  }
  Timer? time;
  var second = 5;
  void count_second(){
    
     time = Timer.periodic(Duration(seconds: 1), (timer) { 
      setState(() {
        if(second == 0){
          
          log("Timer end od Now !!");
         // timer.cancel();
        //  if(index+1 > qua_database.length ){
        //   log("This is last record !!");
        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> resultpage()));
        //  }
          print(qua_database.length);
          if(index+1 >= qua_database.length){
            log("message");
            time!.cancel();
            Navigator.push(context, MaterialPageRoute(builder:(context)=> resultpage(answers_count : answers_count, totqua : qua_database.length)));
          }
          index += 1;
          second = 5 ;
        }else{
           second -= 1;
        }
       
        
      });
     
    });
    

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count_second();
   
    
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    time!.cancel();
    
  }
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Science And Nature", style: TextStyle(
            color: Colors.white70
          ),),
          actions: [
            IconButton(
              onPressed: (){
                showDialog_back(context , time);
              }, 
              icon: Icon(Icons.close ,color: Colors.white70,)
            ),
            
          ],
          
          elevation: 0,
          leading: Icon(Icons.person),
          toolbarHeight: 80,
          backgroundColor: Color.fromARGB(252, 37, 51, 145),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 34, 52, 122),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20) )
            ),
          ),

        ),
      
        body: WillPopScope(
          onWillPop: ()  async{
            return showDialog_back(context, time); 
          },
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                     color: Color.fromARGB(252, 37, 51, 145)
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Container(
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text("Quiz : ${qua_database.length}", style: TextStyle(fontSize: 15,color: Colors.white70),),
              
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(second.toString()+" Sec", style: TextStyle(
                                          fontSize: 15, color: Colors.white70
                                        ),),
                                      )
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              endIndent: 20,
                              indent: 20,
                              color: Colors.white,
                              height: 0,
                              
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      index >= qua_database.length ?
                      Container(
                        child: Center(
                          child: Text("okkk Well Done !!"),
                        ),
                      ):
                      Container(
                        padding: EdgeInsets.all(10),
                        height: size.height / 2,
                        width: size.width ,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("${index+1}. "+qua_database[index]["question"] , style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                              ),),
                            ),
                            SizedBox(height: 20,),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(qua_database[index]["answers"][0] == qua_database[index]["correctIndex"] ){
                                          answers_count += 1;
                                          log("Answer is Right !");
                                        }
                                        if(index+1 >= qua_database.length){
                                          log("this is last question");
                                          time!.cancel();
                                          Navigator.push(context, MaterialPageRoute(builder:(context)=> resultpage(answers_count : answers_count , totqua : qua_database.length )));
                                        }
                                        index += 1;
                                        second = 5 ;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      alignment: Alignment.topLeft,
                                     // height: 40,
                                      width: size.width ,
                                      decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            child: Text("A", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                            backgroundColor: Color.fromARGB(255, 167, 100, 0),
                                          ),
                                          Padding(padding: EdgeInsets.only(right: 10)),
                                          Text(qua_database[index]["answers"][0], style: TextStyle(
                                            fontSize: 15,fontWeight: FontWeight.bold
                                          ),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(qua_database[index]["answers"][1] == qua_database[index]["correctIndex"] ){
                                          answers_count += 1;
                                          log("Answer is Right !");
                                        }
                                        if(index+1 >= qua_database.length){
                                          log("this is last question");
                                          time!.cancel();
                                          Navigator.push(context, MaterialPageRoute(builder:(context)=> resultpage(answers_count : answers_count, totqua : qua_database.length)));
                                        }
                                        index += 1;
                                        second = 5 ;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                     // height: 40,
                                      width: size.width ,
                                      decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            child: Text("B", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                            backgroundColor:Color.fromARGB(255, 167, 100, 0),
                                          ),
                                          Padding(padding: EdgeInsets.only(right: 10)),
                                          Text(qua_database[index]["answers"][1], style: TextStyle(
                                            fontSize: 15,fontWeight: FontWeight.bold
                                          ),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(qua_database[index]["answers"][2] == qua_database[index]["correctIndex"] ){
                                          answers_count += 1;
                                          log("Answer is Right !");
                                        }
                                        if(index+1 >= qua_database.length){
                                          log("this is last question");
                                          time!.cancel();
                                          Navigator.push(context, MaterialPageRoute(builder:(context)=> resultpage(answers_count : answers_count, totqua : qua_database.length)));
                                        }
                                        index += 1;
                                        second = 5 ;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                    //  height: 40,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            child: Text("C", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                            backgroundColor: Color.fromARGB(255, 167, 100, 0),
                                          ),
                                          Padding(padding: EdgeInsets.only(right: 10)),
                                          Text(qua_database[index]["answers"][2], style: TextStyle(
                                            fontSize: 15,fontWeight: FontWeight.bold
                                          ),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(qua_database[index]["answers"][3] == qua_database[index]["correctIndex"] ){
                                          answers_count += 1;
                                          log("Answer is Right !");
                                        }
                                        if(index+1 >= qua_database.length){
                                          log("this is last question");
                                          time!.cancel();
                                          Navigator.push(context, MaterialPageRoute(builder:(context)=> resultpage(answers_count : answers_count, totqua : qua_database.length)));
                                        }
                                        index += 1;
                                        second = 5 ;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                     // height: 40,
                                      width: size.width ,
                                      decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            child: Text("D", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                            backgroundColor: Color.fromARGB(255, 167, 100, 0),
                                          ),
                                          Padding(padding: EdgeInsets.only(right: 10)),
                                          Text(qua_database[index]["answers"][3], style: TextStyle(
                                            fontSize: 15,fontWeight: FontWeight.bold
                                          ),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                        
                        },
                        child: Container(
                          alignment: Alignment.center,
                          
                          height: size.height / 15,
                          width: size.width / 2,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 200, 114, 2),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text("Skip", style: TextStyle(
                            color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold
                            
                          )),
                        ),
                      )
                    ],
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

showDialog_back(BuildContext context, Timer? time){
  showDialog(
    context: context,
    builder: (context) {
      return  AlertDialog(
         title: Text("Are You Sure !!"),
         content: Text("Do you want to leave this Quiz ?"),
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
         actions: [
           TextButton(onPressed: () {
              Navigator.pop(context);
             }, 
           child: Text("Cancel", style: TextStyle(fontSize: 20),)
           ),
           TextButton(
             onPressed: () {
            
               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>startpage()), (route) => false);
             
             }, 
           child: Text("Leave",style: TextStyle(fontSize: 20))
           )
         ],
       );
      
    },
  );
}