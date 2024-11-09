class TFirebaseException implements Exception {
  final String code;
  TFirebaseException(this.code);

  String get message {
    switch (code) {
      case 'unknown':
        return "An unknown error occurred. Please try again.";
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
        return 'This app is not authorized to use Firebase. Please verify your Firebase project configuration.';
      case 'invalid-api-key':
        return 'The API key is invalid. Please verify your Firebase project configuration.';
      case 'network-request-failed':
        return 'A network error occurred. Please check your connection and try again.';
      case 'internal-error':
        return 'An internal error occurred. Please try again later.';
      case 'timeout':
        return 'The operation timed out. Please try again later.';
      case 'permission-denied':
        return 'You do not have permission to perform this operation.';
      case 'unavailable':
        return 'The service is currently unavailable. Please try again later.';
      case 'already-exists':
        return 'The resource already exists.';
      case 'not-found':
        return 'The resource was not found.';
      case 'invalid-argument':
        return 'An invalid argument was provided.';
      case 'cancelled':
        return 'The operation was cancelled.';
      case 'data-loss':
        return 'Data loss occurred.';
      case 'resource-exhausted':
        return 'The resource limit has been reached.';
      case 'failed-precondition':
        return 'The operation was attempted under an invalid condition.';
      case 'aborted':
        return 'The operation was aborted.';
      case 'out-of-range':
        return 'The operation attempted to access data outside the valid range.';
      case 'unauthenticated':
        return 'You need to authenticate to perform this operation.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }

  @override
  String toString() {
    return 'TFirebaseException(code: $code, message: $message)';
  }
}
