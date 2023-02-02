import 'dart:async';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_chat/constant.dart';

import '../models/user.dart';

class CloudService{
  CloudService._();
  static final CloudService instance = CloudService._();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  bool createAccount({required String name, required String password}){
    fireStore.collection(Constant.userKey).doc(name).set({
      Constant.username:name,
      Constant.password:password
    }).then((value){
      return true;
    }).catchError((error){
      return false;
    });
    return true;
  }

  Future<bool> login({required String name, required String password}){
    final result = fireStore.collection(Constant.userKey).doc(name).get().then((DocumentSnapshot snapshot){
      if(snapshot.exists){
        final data = snapshot.data() as Map<String, dynamic>;
        print("RES: ${data[Constant.password] == password}");
        return (data[Constant.password] == password);
      }
      return false;
    }).catchError((error){
      return false;
    });
    return result;
  }

  Future<int> checkUserName({required String name}){
    final result = fireStore.collection(Constant.userKey).doc(name).get().then((DocumentSnapshot snapshot){
      if(snapshot.exists){
        return 1;
      }else{
        return 0;
      }
    }).catchError((error){
      return 2;
    });
    return result;
  }

  Future<List<User>> getFriend() async {
    final snapshot = await fireStore.collection(Constant.userKey).get();
    print("Adaa: ${snapshot.docs.map((e) => e.data())}");
    final data = snapshot.docs.map((e) => e.data());
    List<User> list = [];
    if (data.isNotEmpty) {
      for (var p in data) {
        list.add(User.fromJson(p));
      }
      print("DDDD: ${list.first.username}");
      return list;

    }
    return [];
  }

  Future sendMessage(String sender, String receiver, String message) async {
    await fireStore.collection(Constant.chatKey).doc("$sender-$receiver").get().then((DocumentSnapshot snapshot){
      if(!snapshot.exists){
        fireStore.collection(Constant.chatKey).doc("$sender-$receiver").set({
          Constant.chatKey:FieldValue.arrayUnion([
            {
              "sender": sender,
              "message": message,
              "time": DateTime.now()
            }
          ])
        });
      }else{
        print("DIIIIII: ${snapshot.data()}");
        fireStore.collection(Constant.chatKey).doc("$sender-$receiver").update({
          Constant.chatKey:FieldValue.arrayUnion([
            {
              "sender": sender,
              "message": message,
              "time": DateTime.now()
            }
          ])
        });
      }
    });
  }

  Stream<DocumentSnapshot> getMessage(String sender, String receiver){
    return fireStore.collection(Constant.chatKey).doc("$sender-$receiver").snapshots();
  }

}