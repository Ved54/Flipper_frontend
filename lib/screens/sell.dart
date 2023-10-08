import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mazha_app/Product%20Uploads/Book,%20Sport%20and%20Hobby%20Upload/bsh_cat.dart';
import 'package:mazha_app/Product%20Uploads/Car%20Upload/Car_Upload.dart';
import 'package:mazha_app/Product%20Uploads/Commercial%20Vehicle%20and%20Spare%20Upload/comm_spare_cat.dart';
import 'package:mazha_app/Product%20Uploads/Electronic%20and%20Appliance%20Upload%20/elec_app_cat.dart';
import 'package:mazha_app/Product%20Uploads/Fashion%20Upload/fas_cat.dart';
import 'package:mazha_app/Product%20Uploads/Furniture%20Upload/fur_cat.dart';
import 'package:mazha_app/Product%20Uploads/Job%20Upload/job_cat.dart';
import 'package:mazha_app/Product%20Uploads/Mobile%20Upload/mob_cat.dart';
import 'package:mazha_app/Product%20Uploads/Pet%20Upload/pet_upload.dart';
import 'package:mazha_app/Product%20Uploads/Property%20Upload/property_upload.dart';
import 'package:mazha_app/Product%20Uploads/Service%20Upload/service_cat.dart';
import 'package:mazha_app/utils/nav_bar.dart';
import 'package:mazha_app/utils/next_screen.dart';

import '../Product Uploads/Bike Upload/bike_cat.dart';

class Sell extends StatefulWidget {
  const Sell({super.key});

  @override
  State<Sell> createState() => _SellState();
}

class _SellState extends State<Sell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Choose a Category", style: TextStyle(color: Color(0xFF333333),),),
        leading: IconButton(
          onPressed: () {
            nextScreen(context, NavBar());
          },
          icon: const Icon(
            CupertinoIcons.arrow_left, color: Color(0xFF333333),),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 40,
            child: ListTile(
              onTap: () {
                nextScreen(context, UploadCar());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Cars',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              leading: Icon(
                Icons.car_crash_sharp, size: 30, color: Color(0xFF333333),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
          SizedBox(
            height: 40,
            child: ListTile(
              onTap: () {
                nextScreen(context, UploadProperty());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Properties',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              leading: Icon(Icons.house, size: 30, color: Color(0xFF333333),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
          SizedBox(
            height: 40,
            child: ListTile(
              onTap: () {
                nextScreen(context, SelectMobile());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Mobiles',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              leading: Icon(
                Icons.phone_android, size: 30, color: Color(0xFF333333),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
          SizedBox(
            height: 40,
            child: ListTile(
              onTap: (){
                nextScreen(context, SelectJob());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Jobs',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              leading: Icon(Icons.cabin, size: 30, color: Color(0xFF333333),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
          SizedBox(
            height: 40,
            child: ListTile(
              onTap: (){
                nextScreen(context, SelectBike());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Bikes',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              leading: Icon(
                Icons.motorcycle, size: 30, color: Color(0xFF333333),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
          SizedBox(
            height: 40,
            child: ListTile(
              onTap: () {
                nextScreen(context, SelectElecApp());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Electronics & Appliances',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              leading: Icon(Icons.computer, size: 30, color: Color(0xFF333333),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
          SizedBox(
            height: 40,
            child: ListTile(
              onTap: () {
                nextScreen(context, SelectCommSpare());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Commercial Vehicles & Spares',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              leading: Icon(
                Icons.fire_truck_rounded, size: 30, color: Color(0xFF333333),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
          SizedBox(
            height: 40,
            child: ListTile(
              onTap: () {
                nextScreen(context, SelectFurniture());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Furniture',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              leading: Icon(Icons.chair, size: 30, color: Color(0xFF333333),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
          SizedBox(
            height: 40,
            child: ListTile(
              onTap: () {
                nextScreen(context, SelectFashion());
              },
              contentPadding: EdgeInsets.only(left:20, right: 20),
              title: Text('Fashion',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              leading: Icon(
                Icons.favorite_sharp, size: 30, color: Color(0xFF333333),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
          SizedBox(
            height: 40,
            child: ListTile(
              onTap: () {
                nextScreen(context, SelectBSH());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Books, Sports & Hobbies',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              leading: Icon(
                Icons.sports_gymnastics, size: 30, color: Color(0xFF333333),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
          SizedBox(
            height: 40,
            child: ListTile(
              onTap: () {
                nextScreen(context, PetUpload());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Pets',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              leading: Icon(
                Icons.pets_sharp, size: 30, color: Color(0xFF333333),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
          SizedBox(
            height: 40,
            child: ListTile(
                onTap: () {
                  nextScreen(context, SelectService());
                },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Services',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              leading: Icon(Icons.design_services_outlined, size: 30,
                color: Color(0xFF333333),),
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