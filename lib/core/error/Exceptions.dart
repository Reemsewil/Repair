class ServerException implements Exception {
  ServerException({required this.message});
  String message;
}

class ValidationException implements Exception {}

class InternetException implements Exception {}

class PasswordException implements ValidationException {
  String message;
  PasswordException(this.message);
}

class CodeException implements ValidationException {
  String message;
  CodeException(this.message);
}

class PhoneException implements ValidationException {
  String? message;
  PhoneException(this.message);
}

class UsernameException implements ValidationException {
  String? message;
  UsernameException(this.message);
}

class PasswordMustContainOneUppercase implements Exception {
  String? message;
  PasswordMustContainOneUppercase(this.message);
}

class EmptyException implements Exception {
  String message;
  EmptyException(this.message);
}
