


import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quizeapp/main.dart';
import 'package:quizeapp/startpage.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:quizeapp/variable.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class resultpage extends StatefulWidget {
  int answers_count = 0;
  int totqua = 0;
   resultpage({super.key, required  this.answers_count, required this.totqua});
  @override
  State<resultpage> createState() => _resultpageState();
}

class _resultpageState extends State<resultpage> {

  final sc_controller = ScreenshotController();


  

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var score = widget.answers_count * 100 / widget.totqua;
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: Color.fromARGB(251, 28, 39, 109)
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: (){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> startpage()), (route) => false);

                  }, 
                  icon: Icon(Icons.close , color: Colors.white60,size: 40,)
                ),
                  
              ),
              SizedBox(height: 30,),
              Screenshot(
                controller:  sc_controller,
                child: 
               // build_image(size , score , widget.answers_count , widget.totqua , sc_controller)
                
                
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    padding: EdgeInsets.all(10),
                   // height: size.height/1.5,
                    width: size.width,
                    decoration: BoxDecoration(
                      
                      
                    ),
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.all(20)),
                        Container(
                          child: Image.asset("images/w1.png", scale: 4,),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("Congrats!", style: TextStyle(fontSize: 30 , fontWeight: FontWeight.w900 ),),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: AutoSizeText(
                            "${score.toStringAsFixed(0) }% Score",
                           // maxFontSize: 45,
                           maxLines: 1,
                            minFontSize: 45,
                            wrapWords: true,
                             style: TextStyle( fontWeight: FontWeight.bold , color: Color.fromARGB(255, 26, 116, 72) ),),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: AutoSizeText("Quiz Completed Successfully.",
                          maxLines: 1,
                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.black87 ),),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 40 , left: 40 , top: 5),
                          child: AutoSizeText("You attempt ${widget.totqua} question and from that ${widget.answers_count} answer is correct.",
                          maxLines: 2,
                           style: TextStyle(fontSize: 18 , color: Colors.black87 ),),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 40 , left: 40 , top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Share with us : ", style: TextStyle(fontSize: 18 , color: Colors.black54 ),),
                              GestureDetector(
                                onTap: ()  async{
                                  final image = await sc_controller.capture();
                                  saveandshare(image);
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.facebook),
                                    Icon(Icons.whatsapp),
                                    Icon(Icons.telegram),
                                  ],
                                ),
                              ),
                             
                              
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            var imag =await sc_controller.capture();
                            if(imag == null) return;

                            await save_image(imag);
                           
                          
                          }, 
                          icon: Icon(Icons.screenshot)
                        ),
                        Padding(padding: EdgeInsets.all(20)),
                      ],
                    ),
                  ),
                ),
             
              ),
            ],
          ),

        ),
        
    
      ),
    );
  }
  Future saveandshare(Uint8List? image) async{
    final directory = await getApplicationDocumentsDirectory();
    log("diectory : $directory");
    final img = File('${directory.path}/flutter.jpg');
    img.writeAsBytesSync(image!);
    log(img.path);
    await Share.shareFiles([img.path , ],text: share_set);

  }


  Future<String> save_image(Uint8List imag) async{
    await [Permission.storage].request();
    var time = DateTime.now();
    var name = 'screenshot_$time';
    final result = await ImageGallerySaver.saveImage(imag , name: name);
    return result['filePath'];
    
  }
}
Widget build_image(Size size, double score, int answers_count, int totqua, ScreenshotController sc_controller){
  return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        padding: EdgeInsets.all(10),
       // height: size.height/1.5,
        width: size.width,
        decoration: BoxDecoration(
          
          
        ),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(20)),
            Container(
              child: Image.asset("images/w1.png", scale: 4,),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text("Congrats!", style: TextStyle(fontSize: 30 , fontWeight: FontWeight.w900 ),),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: AutoSizeText(
                "${score.toStringAsFixed(0) }% Score",
               // maxFontSize: 45,
               maxLines: 1,
                minFontSize: 45,
                wrapWords: true,
                 style: TextStyle( fontWeight: FontWeight.bold , color: Color.fromARGB(255, 26, 116, 72) ),),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: AutoSizeText("Quiz Completed Successfully.",
              maxLines: 1,
               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.black87 ),),
            ),
            Container(
              padding: EdgeInsets.only(right: 40 , left: 40 , top: 5),
              child: AutoSizeText("You attempt ${totqua} question and from that ${answers_count} answer is correct.",
              maxLines: 2,
               style: TextStyle(fontSize: 18 , color: Colors.black87 ),),
            ),
            Container(
              padding: EdgeInsets.only(right: 40 , left: 40 , top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Share with us : ", style: TextStyle(fontSize: 18 , color: Colors.black54 ),),
                  Icon(Icons.facebook),
                  Icon(Icons.whatsapp),
                  Icon(Icons.telegram),
                  
                ],
              ),
            ),
            IconButton(
              onPressed: () async {
                var imag =await sc_controller.captureFromWidget(build_image(size, score, answers_count, totqua, sc_controller));
               
              
              }, 
              icon: Icon(Icons.screenshot)
            ),
            Padding(padding: EdgeInsets.all(20)),
          ],
        ),
      ),
    );
}