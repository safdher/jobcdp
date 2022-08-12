import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jobcdp/model/userModel.dart';

class Singleton {
  static final Singleton _instance = Singleton.internal();
  Singleton.internal();
  factory Singleton() => _instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  UserModel? user;
}
