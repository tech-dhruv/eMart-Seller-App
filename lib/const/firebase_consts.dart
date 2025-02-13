import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

//Collections
const vendorsCollection = "vendors";
const productsCollection = "products";
const chatsCollection = "chats";
const messagesCollection = "messages";
const ordersCollection = 'orders';