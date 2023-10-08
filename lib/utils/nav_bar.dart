import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Chats/screens/chats.dart';
import '../screens/favourites.dart';
import '../screens/home.dart';
import '../screens/profile.dart';
import '../screens/sell.dart';
import 'next_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  static int currenTab = 0;
  static Widget currentScreen = Home();

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  final List<Widget> screens = [Home(), Favourite(), Chat(), Profile()];

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: PageStorage(
          child: NavBar.currentScreen,
          bucket: bucket,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white,),
          onPressed: () {
            nextScreen(context, Sell());
          },
          backgroundColor: Color(0xFF4EDB86),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        extendBody: true,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          child: Container(
            height: displayWidth * .145,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          NavBar.currentScreen = Home();
                          NavBar.currenTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.house_fill,
                            color: NavBar.currenTab == 0 ? Color(0xFF4EDB86) : Colors.grey,
                          ),
                          Text("Home", style: TextStyle(color: NavBar.currenTab == 0 ? Color(0xFF4EDB86) : Colors.grey, fontSize: 10),)
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          NavBar.currentScreen = Favourite();
                          NavBar.currenTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.heart_fill,
                            color: NavBar.currenTab == 1 ? Color(0xFF4EDB86) : Colors.grey,
                          ),
                          Text("Favourites", style: TextStyle(color: NavBar.currenTab == 1 ? Color(0xFF4EDB86) : Colors.grey, fontSize: 10),)
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          NavBar.currentScreen = Chat();
                          NavBar.currenTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.chat_bubble_text_fill,
                            color: NavBar.currenTab == 2 ? Color(0xFF4EDB86) : Colors.grey,
                          ),
                          Text("Chats", style: TextStyle(color: NavBar.currenTab == 2 ? Color(0xFF4EDB86) : Colors.grey, fontSize: 10),)
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          NavBar.currentScreen = Profile();
                          NavBar.currenTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.profile_circled,
                            color: NavBar.currenTab == 3 ? Color(0xFF4EDB86) : Colors.grey,
                          ),
                          Text("Profile", style: TextStyle(color: NavBar.currenTab == 3 ? Color(0xFF4EDB86) : Colors.grey, fontSize: 10),)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
