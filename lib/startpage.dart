import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quizeapp/homepage.dart';
import 'package:quizeapp/resultpage.dart';

class startpage extends StatefulWidget {
  const startpage({super.key});

  @override
  State<startpage> createState() => _startpageState();
}

class _startpageState extends State<startpage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0,
        backgroundColor:  Color.fromARGB(252, 37, 51, 145),
        toolbarHeight: 100,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            
            color: Color.fromARGB(255, 34, 52, 122),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50) )
          ),
          child: Center(
            child: Row(
              children: [
                
                Flexible(flex: 1,
                  child: Container(
                    width: size.width,
                    padding: EdgeInsets.all(10),
                   
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>resultpage(answers_count: 2,totqua: 3,)));
                      },
                      child: Image.asset("images/menu.png", scale: 12,color: Colors.white70,)),
                  )
                ),
                Flexible(flex: 4,
                  child: Container(
                    alignment: Alignment.center,
                    
                    child: Text("Quiz App", style: TextStyle(
                      fontSize: 30,
                      color: Colors.white
                    ),),

                  )
                ),
                Flexible(flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: size.width,
                    child: CircleAvatar(
                      radius: 26,
                      backgroundColor: Color.fromARGB(255, 220, 220, 220),
                      child: CircleAvatar(
                        backgroundColor: Colors.white70,
                        radius: 25,
                        child: Icon(Icons.person,color: Color.fromARGB(255, 78, 78, 78),),
                    
                      ),
                    ),
                    

                  )
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color:  Color.fromARGB(252, 37, 51, 145)
        ),
        child: Column(
          children: [
            SizedBox(height: size.height / 40,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>homepage()));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                 // height: size.height / 10,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 34, 52, 122),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Icon(Icons.science, color: Colors.white70,size: 40,)),
                      Padding(padding: EdgeInsets.all(10)),
                      Flexible(
                        flex: 4,
                        child: AutoSizeText("Science And Technology",maxLines: 1, maxFontSize: 25,
                         style: TextStyle(
                          overflow: TextOverflow.clip,
                           color: Colors.white
                          ),),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}