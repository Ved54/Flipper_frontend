import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mazha_app/Product%20Uploads/Fashion%20Upload/kids_fashion.dart';
import 'package:mazha_app/Product%20Uploads/Fashion%20Upload/men_fashion.dart';
import 'package:mazha_app/Product%20Uploads/Fashion%20Upload/women_fashion.dart';
import '../../screens/sell.dart';
import '../../utils/next_screen.dart';

class SelectFashion extends StatefulWidget {
  const SelectFashion({super.key});

  @override
  State<SelectFashion> createState() => _SelectFashionState();
}

class _SelectFashionState extends State<SelectFashion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Fashion", style: TextStyle(color: Color(0xFF333333),),),
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
                nextScreen(context, MenFashion());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Men',
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
                nextScreen(context, WomenFashion());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Women',
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
                nextScreen(context, KidsFashion());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Kids',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
