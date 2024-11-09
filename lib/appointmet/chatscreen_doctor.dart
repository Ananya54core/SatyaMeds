import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_android/url_launcher_android.dart';


class ChatScreenDoc extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreenDoc> {
  final List<Map<String, String>> messages = [];
  final TextEditingController _controller = TextEditingController();

  // A list of responses from the doctor's side
  final List<String> doctorResponses = [
    "Hello! How can I help you today?",
    "Can you please provide more details about your symptoms?",
    "It sounds like you need to take some rest. Have you tried that?",
    "I'm here to assist you. What seems to be the issue?",
    "Based on what you're saying, I recommend scheduling a follow-up.",
    "Let’s discuss your current medications. Are you taking anything?",
    "Thanks for reaching out. How long have you been experiencing this?",
    "That’s quite common. I’ll guide you through some steps to manage it.",
    "Could you tell me more about how this started?",
    "Let's look into that. Do you have any other symptoms?",
  ];

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        // Add the user's message
        messages.add({"sender": "user", "text": _controller.text.trim()});
        _controller.clear();

        // Simulate a response from the doctor after a delay
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            // Add a random response from the doctor
            final randomResponse = doctorResponses[Random().nextInt(doctorResponses.length)];
            messages.add({"sender": "doctor", "text": randomResponse});
          });
        });
      });
    }
  }

  Widget _buildMessage(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isUser ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(color: isUser ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Doctor'),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: ()=>Get.to((),
          ),
          selectedIcon: IconButton(
            icon: Icon(Icons.videocam),
            onPressed: ()=>Get.to(())
          ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/onboarding/chatbg.jpg'), // Replace with your background image path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[messages.length - 1 - index];
                  final isUser = message["sender"] == "user";
                  return _buildMessage(message["text"]!, isUser);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
