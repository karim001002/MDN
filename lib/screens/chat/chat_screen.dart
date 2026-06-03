// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_app/core/localization/app_localizations.dart';
import 'package:medical_app/services/chat_service.dart';
import 'package:medical_app/providers/auth_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String chatRoomId;
  final String receiverName;

  const ChatScreen({super.key, required this.chatRoomId, required this.receiverName});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage(String senderId) async {
    if (_messageController.text.trim().isNotEmpty) {
      await _chatService.sendMessage(
        widget.chatRoomId,
        senderId,
        _messageController.text.trim(),
      );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final currentUser = ref.watch(authStateProvider).value; // Get current user from auth provider

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(title: Text(appLocalizations.chat)),
        body: Center(child: Text('Please log in to chat.')),
      );
    }

    final senderId = currentUser.uid;

    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverName)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _chatService.getMessages(widget.chatRoomId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.all(8.w),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message['senderId'] == senderId;
                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                        decoration: BoxDecoration(
                          color: isMe ? Theme.of(context).primaryColor : Colors.grey[300],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            topRight: Radius.circular(15.r),
                            bottomLeft: isMe ? Radius.circular(15.r) : Radius.circular(0),
                            bottomRight: isMe ? Radius.circular(0) : Radius.circular(15.r),
                          ),
                        ),
                        child: Text(
                          message['messageContent'],
                          style: TextStyle(color: isMe ? Colors.white : Colors.black, fontSize: 15.sp),
                        ),
                      ).animate().fadeIn(duration: 300.ms).slideX(begin: isMe ? 0.2 : -0.2, end: 0),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...', // TODO: Localize this
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.r)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                FloatingActionButton(
                  onPressed: () => _sendMessage(senderId),
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
