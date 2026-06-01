import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Get current user (null if not logged in)
  User? get currentUser => _auth.currentUser;

  // Stream that notifies when user logs in/out
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      // Create the account in Firebase Auth
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = credential.user;

      if (user != null) {
        // Update display name
        await user.updateDisplayName(fullName);

        // Save user info to Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'fullName': fullName,
          'email': email,
          'avatarUrl': '',
          'selectedTopics': [],
          'articlesRead': 0,
          'minutesSaved': 0,
          'isDarkMode': true,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return user;
    } on FirebaseAuthException catch (e) {
      // Convert Firebase errors to readable messages
      throw _handleAuthError(e);
    }
  }


  Future<User?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }


  Future<User?> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      // Open Google sign-in popup
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled
        return null;
      }

      // Get authentication details
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      User? user = userCredential.user;

      // If this is a NEW Google user, save them to Firestore
      if (user != null && userCredential.additionalUserInfo!.isNewUser) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'fullName': user.displayName ?? 'User',
          'email': user.email,
          'avatarUrl': user.photoURL ?? '',
          'selectedTopics': [],
          'articlesRead': 0,
          'minutesSaved': 0,
          'isDarkMode': true,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return user;
    } catch (e) {
      throw 'Google sign-in failed: ${e.toString()}';
    }
  }


  Future<void> signOut() async {
    try {
      //  Completely severs the connection to the Google account
      await _googleSignIn.disconnect();
    } catch (e) {
      print("Google disconnect error: $e");
    }

    // Sign out of Firebase
    await _auth.signOut();
  }


  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'Password is too weak (min 6 characters)';
      case 'email-already-in-use':
        return 'This email is already registered';
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-not-found':
        return 'No account found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'invalid-credential':
        return 'Invalid email or password';
      case 'network-request-failed':
        return 'Check your internet connection';
      default:
        return e.message ?? 'An error occurred';
    }
  }
}