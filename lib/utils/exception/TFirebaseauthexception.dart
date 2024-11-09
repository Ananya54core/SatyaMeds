class TFirebaseAuthException implements Exception {
  final String code;
  TFirebaseAuthException(this.code);

  String get message {
    switch (code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'wrong-password':
        return 'The password is incorrect.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'user-disabled':
        return 'The user account has been disabled.';
      case 'too-many-requests':
        return 'Too many requests. Try again later.';
      case 'operation-not-allowed':
        return 'Signing in with this method is not allowed.';
      case 'email-already-in-use':
        return 'The email is already registered. Please use a different email.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please log in again.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address but different sign-in credentials.';
      case 'invalid-credential':
        return 'The credential is not valid.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account.';
      case 'invalid-verification-code':
        return 'The verification code is invalid.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid.';
      case 'session-expired':
        return 'The session has expired. Please try again.';
      case 'invalid-phone-number':
        return 'The phone number is not valid.';
      case 'quota-exceeded':
        return 'The quota for this operation has been exceeded. Please try again later.';
      case 'missing-verification-code':
        return 'The verification code is missing.';
      case 'missing-verification-id':
        return 'The verification ID is missing.';
      case 'app-not-authorized':
        return 'This app is not authorized to use Firebase Authentication. Please verify your Firebase project configuration.';
      case 'invalid-api-key':
        return 'The API key is invalid. Please verify your Firebase project configuration.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }

  @override
  String toString() {
    return 'TFirebaseAuthException(code: $code, message: $message)';
  }
}
