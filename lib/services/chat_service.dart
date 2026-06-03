// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create or get a chat room
  Future<String> getOrCreateChatRoom(String user1Id, String user2Id) async {
    // Ensure consistent chat room ID regardless of user order
    List<String> participants = [user1Id, user2Id]..sort();
    String chatRoomId = participants.join('_');

    DocumentSnapshot chatRoomDoc = await _firestore.collection('chat_rooms').doc(chatRoomId).get();

    if (!chatRoomDoc.exists) {
      await _firestore.collection('chat_rooms').doc(chatRoomId).set({
        'participants': participants,
        'createdAt': FieldValue.serverTimestamp(),
        'lastMessageAt': FieldValue.serverTimestamp(),
      });
    }
    return chatRoomId;
  }

  // Send a message
  Future<void> sendMessage(String chatRoomId, String senderId, String messageContent, {String messageType = 'text'}) async {
    await _firestore.collection('chat_rooms').doc(chatRoomId).collection('messages').add({
      'senderId': senderId,
      'messageContent': messageContent,
      'messageType': messageType,
      'timestamp': FieldValue.serverTimestamp(),
    });
    // Update lastMessageAt in chat room
    await _firestore.collection('chat_rooms').doc(chatRoomId).update({
      'lastMessageAt': FieldValue.serverTimestamp(),
    });
  }

  // Get messages for a chat room
  Stream<QuerySnapshot> getMessages(String chatRoomId) {
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Update typing status
  Future<void> updateTypingStatus(String chatRoomId, String userId, bool isTyping) async {
    await _firestore.collection('chat_rooms').doc(chatRoomId).collection('typing_status').doc(userId).set({
      'isTyping': isTyping,
      'lastUpdated': FieldValue.serverTimestamp(),
    });
  }

  // Get typing status for a chat room (excluding current user)
  Stream<QuerySnapshot> getTypingStatus(String chatRoomId, String currentUserId) {
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('typing_status')
        .where('isTyping', isEqualTo: true)
        .snapshots();
  }

  // Update online status (presence system)
  Future<void> updateUserOnlineStatus(String userId, bool isOnline) async {
    await _firestore.collection('online_status').doc(userId).set({
      'isOnline': isOnline,
      'lastSeen': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Get online status of a user
  Stream<DocumentSnapshot> getUserOnlineStatus(String userId) {
    return _firestore.collection('online_status').doc(userId).snapshots();
  }
}
