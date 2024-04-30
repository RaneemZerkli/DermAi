import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'Chatbot_Controller.dart';

class ChatScreen extends StatelessWidget {
  final Chatbot_Controller _chatController = Get.put(Chatbot_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<Chatbot_Controller>(
              builder: (controller) => Stack(
                children:[ ListView.builder(
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    final isResponse = index % 2 != 0;
                    return Align(
                      alignment: isResponse ? Alignment.centerLeft : Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: isResponse ? Colors.orange[200] : Colors.teal,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Text(
                          message,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                  if (controller.isLoading.value)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        child: Center(
                          child: SpinKitWave(
                            color: Colors.white,
                            size: 50.0,
                          ),
                        ),
                      ),
                    ),

                ],
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _chatController.textEditingController,
              onChanged: (input) {
                _chatController.handleUserInput(input);
              },
              decoration: InputDecoration(

                hintText: 'Type a message...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send,color: Colors.teal,),
                  onPressed: () {
                    _chatController.sendMessage();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
