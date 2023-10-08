import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mazha_app/Chats/screens/chat_screen.dart';
import 'package:mazha_app/utils/next_screen.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../provider/firebase_provider.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  @override
  void initState() {
    super.initState();
    Provider.of<FirebaseProvider>(context, listen: false)
        .getAllUsers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text("Chats", style: TextStyle(color: Color(0xFF333333), fontSize: 25),),
        backgroundColor: Colors.white,
        actions: [
          // IconButton(
          //   onPressed: () => Navigator.of(context).push(
          //       MaterialPageRoute(
          //           builder: (_) =>
          //           const UsersSearchScreen())),
          //   icon: const Icon(Icons.search,
          //       color: Colors.black),
          // ),
        ],
      ),
      body: Consumer<FirebaseProvider>(
        builder: (context, value, child){
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: value.users.length,
            separatorBuilder: (context, index) =>
            const SizedBox(height: 15),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => value
                .users[index].uid !=
                FirebaseAuth.instance.currentUser?.uid
                ? UserItem(user: value.users[index])
                : const SizedBox(),
          );
        },
      )
    );
  }
}

class UserItem extends StatefulWidget {
  const UserItem({super.key, required this.user});
  final UserModel user;
  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        nextScreen(context, ChatScreen(userId: widget.user.uid));
      },
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(widget.user.image),
      ),
      title: Text(
        widget.user.name,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        widget.user.email,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      trailing: Icon(Icons.chat),
    );
  }
}


