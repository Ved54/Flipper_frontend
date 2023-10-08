import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mazha_app/Product%20Uploads/Book,%20Sport%20and%20Hobby%20Upload/books_upload.dart';
import 'package:mazha_app/Product%20Uploads/Book,%20Sport%20and%20Hobby%20Upload/gym_fitness.dart';
import 'package:mazha_app/Product%20Uploads/Book,%20Sport%20and%20Hobby%20Upload/musical_instruments.dart';
import 'package:mazha_app/Product%20Uploads/Book,%20Sport%20and%20Hobby%20Upload/sports_equipments.dart';
import '../../screens/sell.dart';
import '../../utils/next_screen.dart';
import 'other_hobbies.dart';

class SelectBSH extends StatefulWidget {
  const SelectBSH({super.key});

  @override
  State<SelectBSH> createState() => _SelectBSHState();
}

class _SelectBSHState extends State<SelectBSH> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Books, Sports & Hobbies", style: TextStyle(color: Color(0xFF333333),),),
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
                nextScreen(context, BookUpload());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Books',
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
                nextScreen(context, GYMFitness());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Gym & Fitness',
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
                nextScreen(context, MusicalInstruments());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Musical Instruments',
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
                nextScreen(context, SportsEquipments());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Sports Equipments',
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
                nextScreen(context, HobbiesUpload());
              },
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              title: Text('Other Hobbies',
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
