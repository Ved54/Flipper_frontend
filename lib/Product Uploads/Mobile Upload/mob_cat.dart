import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mazha_app/Product%20Uploads/Mobile%20Upload/mobile_phone_upload.dart';
import 'package:mazha_app/Product%20Uploads/Mobile%20Upload/tablet_upload.dart';
import 'package:mazha_app/screens/sell.dart';
import '../../utils/next_screen.dart';
import 'accessories_upload.dart';

class SelectMobile extends StatefulWidget {
  const SelectMobile({super.key});

  @override
  State<SelectMobile> createState() => _SelectMobileState();
}

class _SelectMobileState extends State<SelectMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Mobiles", style: TextStyle(color: Color(0xFF333333),),),
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
                nextScreen(context, MobilePhoneUpload());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Mobile Phones',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
          SizedBox(
            height: 40,
            child: ListTile(
              onTap: (){
                nextScreen(context, AccessoriesUpload());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Accessories',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
          SizedBox(
            height: 40,
            child: ListTile(
              onTap: (){
                nextScreen(context, TabletUpload());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Tablets',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),), trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
