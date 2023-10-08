import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mazha_app/Product%20Uploads/Job%20Upload/accountant.dart';
import 'package:mazha_app/Product%20Uploads/Job%20Upload/bpo_telecaller.dart';
import 'package:mazha_app/Product%20Uploads/Job%20Upload/cook.dart';
import 'package:mazha_app/Product%20Uploads/Job%20Upload/data_entry_and_back_office.dart';
import 'package:mazha_app/Product%20Uploads/Job%20Upload/delivery_collection.dart';
import 'package:mazha_app/Product%20Uploads/Job%20Upload/designer.dart';
import 'package:mazha_app/Product%20Uploads/Job%20Upload/driver.dart';
import 'package:mazha_app/Product%20Uploads/Job%20Upload/hotel_travelExecutive.dart';
import 'package:mazha_app/Product%20Uploads/Job%20Upload/itEngineer_developer.dart';
import 'package:mazha_app/Product%20Uploads/Job%20Upload/office_assistant.dart';
import 'package:mazha_app/Product%20Uploads/Job%20Upload/operator_technician.dart';
import 'package:mazha_app/Product%20Uploads/Job%20Upload/other_jobs.dart';
import 'package:mazha_app/Product%20Uploads/Job%20Upload/receptionist_frontoffice.dart';
import 'package:mazha_app/Product%20Uploads/Job%20Upload/sales_and_marketing.dart';
import 'package:mazha_app/Product%20Uploads/Job%20Upload/teacher.dart';

import '../../screens/sell.dart';
import '../../utils/next_screen.dart';

class SelectJob extends StatefulWidget {
  const SelectJob({super.key});

  @override
  State<SelectJob> createState() => _SelectJobState();
}

class _SelectJobState extends State<SelectJob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Jobs", style: TextStyle(color: Color(0xFF333333),),),
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
                nextScreen(context, DataEntryBackOffice());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Data Entry & Back office',
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
                nextScreen(context, SalesAndMarketing());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Sales & Marketing',
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
                nextScreen(context, BPOTelecaller());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('BPO & Telecaller',
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
                nextScreen(context, Driver());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Driver',
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
                nextScreen(context, OfficeAssistant());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Office Assistent',
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
                nextScreen(context, DeliveryCollection());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Delivery & Collection',
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
                nextScreen(context, Teacher());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Teacher',
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
                nextScreen(context, Cook());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Cook',
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
                nextScreen(context, ReceptionistFrontOffice());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Receptionist & Front office',
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
                nextScreen(context, OperatorTechnician());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Operator & Technician',
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
                nextScreen(context, ItEngineerDeveloper());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('IT Engineer & Developer',
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
                nextScreen(context, HotelTravelExecutive());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Hotel & Travel Executive',
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
                nextScreen(context, Accountant());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Accountant',
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
                nextScreen(context, Designer());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Designer',
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
                nextScreen(context, OtherJob());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Other Jobs',
                style: TextStyle(fontSize: 15, color: Color(0xFF333333)),),
              trailing: Icon(Icons.arrow_forward_ios_sharp, size: 15,
                color: Color(0xFF333333),),
            ),
          ),
          Divider(),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
