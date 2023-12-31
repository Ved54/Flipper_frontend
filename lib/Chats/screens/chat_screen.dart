import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:mazha_app/utils/nav_bar.dart';
import 'package:mazha_app/utils/next_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/GraphQL.dart';
import '../provider/firebase_provider.dart';
import '../services/mediaService.dart';
import '../models/message.dart';
import '../models/user.dart';
import '../provider/firebase_firestore_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.userId});
  final String userId;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
      ..getUserById(widget.userId)
      ..getMessages(widget.userId);
    super.initState();
  }
  var mdno;
  @override
  Widget build(BuildContext context) {
    final String userQuery = '''
  query{
  usersbyid(flipperUser: "${widget.userId}"){
    mobileNumber
  }
}
  ''';

    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          GraphQLProvider(
            client: client,
            child: graphql.Query(
                options: QueryOptions(
                  document: gql(userQuery),
                ),
                builder: (QueryResult result, {fetchMore, refetch}) {
                  if (result.hasException) {
                    print("Exception");
                    print(result.exception.toString());
                    return Center(child: CircularProgressIndicator());
                  }

                  if (result.isLoading) {
                    print("Loading");
                    return Center(child: CircularProgressIndicator());
                  }
                  final Map<String, dynamic> data = result.data?['usersbyid'];
                  mdno = data['mobileNumber']??0;

                  return SizedBox();
                }),
          ),
          Expanded(child: ChatMessages(receiverId: widget.userId)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChatTextField(receiverId: widget.userId),
          ),
        ],
      ),
    );
  }

  Future<void> _launchCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '$mdno',
    );
    await launchUrl(launchUri);
  }

  AppBar _buildAppBar() => AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: (){nextScreen(context, NavBar());},
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.white,
        title: Consumer<FirebaseProvider>(
          builder: (context, value, child) =>
            value.user != null
                ? Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(value.user!.image),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.user!.name,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      value.user!.name,
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: (){
                    _launchCall();
                    print(mdno);
                    },
                  icon: Icon(Icons.call),
                )
              ],
            )
            : const SizedBox(),
        ),
      );
}

class ChatTextField extends StatefulWidget {
  const ChatTextField({super.key, required this.receiverId});
  final String receiverId;
  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final controller = TextEditingController();
  Uint8List? file;
  @override
  void initState(){
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            controller: controller,
            hintText: 'Add Messages...',
          ),
        ),
        SizedBox(
          width: 5,
        ),
        CircleAvatar(
          radius: 20,
          child: IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: () => _sendText(context),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        CircleAvatar(
          radius: 20,
          child: IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.white),
            onPressed: _sendImage,
          ),
        ),
      ],
    );
  }

  Future<void> _sendText(BuildContext context) async {
    if (controller.text.isNotEmpty) {
      await FirebaseFirestoreService.addTextMessage(
          content: controller.text, receiverId: widget.receiverId);
      controller.clear();
      FocusScope.of(context).unfocus();
    }
    FocusScope.of(context).unfocus();
  }

  Future<void> _sendImage() async {
    final pickedImage = await MediaService.pickImage();
    setState(() => file = pickedImage);
    if (file != null) {
      await FirebaseFirestoreService.addImageMessage(
        receiverId: widget.receiverId,
        file: file!,
      );
    }
  }

}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.hintText,
    this.onPressedSuffixIcon,
    this.obscureText,
    this.onChanged,
  });

  final TextEditingController controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? labelText;
  final String? hintText;
  final bool? obscureText;
  final VoidCallback? onPressedSuffixIcon;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        obscureText: obscureText ?? false,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: onPressedSuffixIcon,
                  icon: Icon(suffixIcon),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFF4EDB86)),
          ),
        ),
      );
}

class ChatMessages extends StatelessWidget {
  ChatMessages({super.key, required this.receiverId});

  final String receiverId;

  @override
  Widget build(BuildContext context) {

    return Consumer<FirebaseProvider>(
        builder: (context, value, child) => value.messages.isEmpty
            ? const Expanded(child: EmptyWidget(icon: Icons.waving_hand, text: 'Say Hello'),)
            : Expanded(
          child: ListView.builder(
            itemCount: value.messages.length,
            itemBuilder: (context, index) {
              final isTextMessage =
                  value.messages[index].messageType == MessageType.text;
              final isMe = receiverId != value.messages[index].senderId;

              return isTextMessage
                  ? MessageBubble(
                isMe: isMe,
                message: value.messages[index],
                isImage: false,
              )
                  : MessageBubble(
                isMe: isMe,
                message: value.messages[index],
                isImage: true,
              );
            },
          ),
        )
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.isMe,
    required this.isImage,
    required this.message,
  });

  final bool isMe;
  final bool isImage;
  final Message message;

  @override
  Widget build(BuildContext context) => Align(
        alignment: isMe ? Alignment.topRight : Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
              color: isMe ? Color(0xFF4EDB86) : Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              isImage
                  ? Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(message.content),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Text(message.content,
                      style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      );
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget(
      {super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 200),
        Text(
          text,
          style: const TextStyle(fontSize: 30),
        ),
      ],
    ),
  );
}

