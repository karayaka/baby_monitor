import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  final googleSignIn = GoogleSignIn.instance;

  Future<GoogleSignInAccount?> googleLogin() async {
    await googleSignIn.initialize(
      serverClientId:
          "498075473311-jv1e6bnhb5bjb9ej024vunupa1bhbfvp.apps.googleusercontent.com",
    );
    return await GoogleSignIn.instance.authenticate();
  }
}
