import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mazha_app/Product%20Uploads/Furniture%20Upload/beds_wardrobes.dart';
import 'package:mazha_app/Product%20Uploads/Furniture%20Upload/homeDecor_garden.dart';
import 'package:mazha_app/Product%20Uploads/Furniture%20Upload/kids_furniture.dart';
import 'package:mazha_app/Product%20Uploads/Furniture%20Upload/otherHouseholditems.dart';
import 'package:mazha_app/Product%20Uploads/Furniture%20Upload/sofa_dinning.dart';
import '../../screens/sell.dart';
import '../../utils/next_screen.dart';

class SelectFurniture extends StatefulWidget {
  const SelectFurniture({super.key});

  @override
  State<SelectFurniture> createState() => _SelectFurnitureState();
}

class _SelectFurnitureState extends State<SelectFurniture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Furniture", style: TextStyle(color: Color(0xFF333333),),),
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
                nextScreen(context, SofaDinning());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Sofa & Dinning',
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
                nextScreen(context, BedsWardrobes());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Beds & Wardrobes',
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
                nextScreen(context, HomeDecorGarden());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Home Decor & Garden',
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
                nextScreen(context, KidsFurniture());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Kids Furniture',
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
                nextScreen(context, OtherHouseholdItems());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Other Household Items',
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
