import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mazha_app/Product%20Uploads/Electronic%20and%20Appliance%20Upload%20/tv_video_audio.dart';
import '../../screens/sell.dart';
import '../../utils/next_screen.dart';

class SelectElecApp extends StatefulWidget {
  const SelectElecApp({super.key});

  @override
  State<SelectElecApp> createState() => _SelectElecAppState();
}

class _SelectElecAppState extends State<SelectElecApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Electronics & Appliances", style: TextStyle(color: Color(0xFF333333),),),
        leading: IconButton(
          onPressed: (){nextScreen(context, Sell());},
          icon: const Icon(CupertinoIcons.arrow_left, color: Color(0xFF333333),),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 40,
            child: ListTile(
              onTap: (){
                nextScreen(context, TVAudioVideo());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('TVs, Video - Audio',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          // Divider(),
          // SizedBox(
          //   height: 40,
          //   child: ListTile(
          //     // onTap: (){
          //     //   nextScreen(context, MobilePhoneUpload());
          //     // },
          //     contentPadding: EdgeInsets.only(left: 20, right: 20),
          //     title: Text('Kitchen & Other Appliances',
          //       style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
          //     trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
          //       color: Color(0xFF333333),),
          //   ),
          // ),
          // Divider(),
          // SizedBox(
          //   height: 40,
          //   child: ListTile(
          //     // onTap: (){
          //     //   nextScreen(context, MobilePhoneUpload());
          //     // },
          //     contentPadding: EdgeInsets.only(left: 20, right: 20),
          //     title: Text('Computers & Laptops',
          //       style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
          //     trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
          //       color: Color(0xFF333333),),
          //   ),
          // ),
          // Divider(),
          // SizedBox(
          //   height: 40,
          //   child: ListTile(
          //     // onTap: (){
          //     //   nextScreen(context, MobilePhoneUpload());
          //     // },
          //     contentPadding: EdgeInsets.only(left: 20, right: 20),
          //     title: Text('Cameras & Lenses',
          //       style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
          //     trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
          //       color: Color(0xFF333333),),
          //   ),
          // ),
          // Divider(),
          // SizedBox(
          //   height: 40,
          //   child: ListTile(
          //     // onTap: (){
          //     //   nextScreen(context, MobilePhoneUpload());
          //     // },
          //     contentPadding: EdgeInsets.only(left: 20, right: 20),
          //     title: Text('Games & Entertainment',
          //       style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
          //     trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
          //       color: Color(0xFF333333),),
          //   ),
          // ),
          //
        ],
      ),
    );
  }
}
