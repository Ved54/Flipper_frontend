import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mazha_app/Product%20Uploads/Commercial%20Vehicle%20and%20Spare%20Upload/com%20_vehicle.dart';
import 'package:mazha_app/Product%20Uploads/Commercial%20Vehicle%20and%20Spare%20Upload/spare_parts.dart';
import '../../screens/sell.dart';
import '../../utils/next_screen.dart';

class SelectCommSpare extends StatefulWidget {
  const SelectCommSpare({super.key});

  @override
  State<SelectCommSpare> createState() => _SelectCommSpareState();
}

class _SelectCommSpareState extends State<SelectCommSpare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text("Commercial Vehicles & Spares", style: TextStyle(color: Color(0xFF333333),),),
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
                nextScreen(context, CommUpload());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Commercial & Other Vehicles',
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
                nextScreen(context, CommSparePart());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Spare Parts',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
        ],
      )
    );
  }
}
