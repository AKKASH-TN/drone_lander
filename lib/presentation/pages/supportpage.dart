import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:drone_lander/presentation/resources/customdrawer.dart';

class Supportpage extends StatefulWidget {
  const Supportpage({super.key});

  @override
  State<Supportpage> createState() => _SupportpageState();
}

class _SupportpageState extends State<Supportpage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showCenterRefresh = false;
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _handleRefresh() async {
    setState(() {
      _showCenterRefresh = true;
      _messages.clear(); // Clear chat history on refresh
    });

    _controller.reset();
    _controller.forward();

    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() {
        _showCenterRefresh = false;
      });
      _controller.repeat();
    }
  }

  
  Future<void> _sendMessage(String message) async {
    
    setState(() {
      _messages.add({"sender": "user", "text": message});
    });

    try {
      
      final response = await http.post(
        Uri.parse('https://dialogflow.googleapis.com/v2/projects/dev-ruler-430515-b6/agent/sessions/YOUR_SESSION_ID:detectIntent'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer YOUR_ACCESS_TOKEN'
        },
        body: jsonEncode({
          'queryInput': {
            'text': {
              'text': message,
              'languageCode': 'en-US'
            }
          }
        }),
      );

      if (response.statusCode == 200) {
        final botResponse = json.decode(response.body);
        // Extract bot's response text
        final botMessage = botResponse['queryResult']['fulfillmentText'];
        
        setState(() {
          _messages.add({"sender": "bot", "text": botMessage});
        });
      }
    } catch (e) {
      print('Error sending message: $e');
      setState(() {
        _messages.add({"sender": "bot", "text": "Sorry, I couldn't process your request."});
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Existing header section from your original code
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Support',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      RotationTransition(
                        turns: _animation,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.purple[900],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.support_agent,
                            color: Colors.purpleAccent,
                            size: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) => IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: const Icon(
                            Icons.menu_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Text(
                        'Chatbot',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      IconButton(
                        onPressed: _handleRefresh,
                        icon: const Icon(
                          Icons.refresh_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Chat Messages ListView
                Expanded(
                  child: ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return Align(
                        alignment: message['sender'] == 'user' 
                          ? Alignment.centerRight 
                          : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: message['sender'] == 'user' 
                              ? Colors.purple[800] 
                              : Colors.grey[800],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            message['text'] ?? '',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Message Input Area
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            filled: true,
                            fillColor: Colors.grey[900],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () {
                          if (_messageController.text.isNotEmpty) {
                            _sendMessage(_messageController.text);
                            _messageController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Existing center refresh animation
          if (_showCenterRefresh)
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.purple[900]?.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: RotationTransition(
                  turns: _animation,
                  child: const Icon(
                    Icons.refresh_rounded,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}