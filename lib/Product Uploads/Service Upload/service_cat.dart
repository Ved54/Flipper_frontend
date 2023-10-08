import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mazha_app/Product%20Uploads/Service%20Upload/edu_classes.dart';
import 'package:mazha_app/Product%20Uploads/Service%20Upload/elecRepair_services.dart';
import 'package:mazha_app/Product%20Uploads/Service%20Upload/homeRenovation_repair.dart';
import 'package:mazha_app/Product%20Uploads/Service%20Upload/legal_documentationService.dart';
import 'package:mazha_app/Product%20Uploads/Service%20Upload/other_services.dart';
import 'package:mazha_app/Product%20Uploads/Service%20Upload/packer_mover.dart';
import 'package:mazha_app/Product%20Uploads/Service%20Upload/tours_travels.dart';
import '../../screens/sell.dart';
import '../../utils/next_screen.dart';
import 'cleaning_pestControl.dart';
import 'health_beauty.dart';

class SelectService extends StatefulWidget {
  const SelectService({super.key});

  @override
  State<SelectService> createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Services", style: TextStyle(color: Color(0xFF333333),),),
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
                nextScreen(context, EducationClasses());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Education & Classes',
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
                nextScreen(context, ToursTravels());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Tours & Travel',
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
                nextScreen(context, ElectronicsRepairServices());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Electronics Repair & Services',
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
                nextScreen(context, HealthBeauty());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Health & Beauty',
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
                nextScreen(context, HomeRenovationRepair());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Home Renovation & Repair',
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
                nextScreen(context, CleaningPestControl());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Cleaning & Pest Control',
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
                nextScreen(context, LegalDocumentationService());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Legal & Documentation Services',
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
                nextScreen(context, PackersMovers());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Packers & Movers',
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
                nextScreen(context, OtherServices());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Other Services',
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
