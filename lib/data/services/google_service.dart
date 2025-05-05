import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  static final _googleApi = GoogleSignIn();

  ///TODO google login sürecinden devam edilecek
  static Future<GoogleSignInAccount?> googleLogin() async {
    return await _googleApi.signIn();
  }
}
