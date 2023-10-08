import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mazha_app/Product%20Uploads/Bike%20Upload/bike_upload.dart';
import 'package:mazha_app/Product%20Uploads/Bike%20Upload/cycle_upload.dart';
import 'package:mazha_app/Product%20Uploads/Bike%20Upload/scooty_upload.dart';
import 'package:mazha_app/Product%20Uploads/Bike%20Upload/sparePart_upload.dart';
import '../../screens/sell.dart';
import '../../utils/next_screen.dart';


class SelectBike extends StatefulWidget {
  const SelectBike({super.key});

  @override
  State<SelectBike> createState() => _SelectBikeState();
}

class _SelectBikeState extends State<SelectBike> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Bikes", style: TextStyle(color: Color(0xFF333333),),),
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
                nextScreen(context, BikeUpload());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Motorcycles',
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
                nextScreen(context, ScootyUpload());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Scooters',
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
                nextScreen(context, SparePart());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Spare Parts',
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
                nextScreen(context, CycleUpload());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Bicycles',
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
