import 'package:firebase_auth/firebase_auth.dart';
class Auth{
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
   Stream<User?> get _authStateChange =>_firebaseAuth.authStateChanges();


  Future<void> Login_function({required String email, required String password}) async{
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> Create_credential({required String email, required String password}) async{
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }


  Future<void> Signout() async{
    await _firebaseAuth.signOut();
  }
}