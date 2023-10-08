import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../screens/sell.dart';
import '../../utils/next_screen.dart';

class SelectPet extends StatefulWidget {
  const SelectPet({super.key});

  @override
  State<SelectPet> createState() => _SelectPetState();
}

class _SelectPetState extends State<SelectPet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Pets", style: TextStyle(color: Color(0xFF333333),),),
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
                nextScreen(context, ());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Fishes & Aquarium',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
          SizedBox(
            height: 40,
            child: ListTile(
              // onTap: (){
              //   nextScreen(context, MobilePhoneUpload());
              // },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Pet Food & Accessories',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
          SizedBox(
            height: 40,
            child: ListTile(
              // onTap: (){
              //   nextScreen(context, MobilePhoneUpload());
              // },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Dogs',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
          SizedBox(
            height: 40,
            child: ListTile(
              // onTap: (){
              //   nextScreen(context, MobilePhoneUpload());
              // },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Cats',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
          SizedBox(
            height: 40,
            child: ListTile(
              // onTap: (){
              //   nextScreen(context, MobilePhoneUpload());
              // },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Other Pets',
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
