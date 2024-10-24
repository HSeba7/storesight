class PawsException implements Exception {
  late int httpError;
  late String errorType;
  late String errorCode;
  late String errorMessage;
}

class ValidationErrorException extends PawsException {
  final Map<String, List<String>> errors;

  ValidationErrorException(this.errors) {
    httpError = 400;
    errorCode = 'validation-error';
    errorMessage = 'Validation failed';
  }
}

class ApiException extends PawsException {
  ApiException.authenticationError() {
    httpError = 401;
    errorCode = 'authentication-error';
    errorMessage = 'Unauthenticated';
  }

  ApiException(String errorCode, String errorMessage) {
    this.errorCode = errorCode;
    this.errorMessage = errorMessage;
  }

  ApiException.fromJson(int statusCode, Map<String, dynamic> json) {
    httpError = statusCode;
    errorCode = statusCode.toString();

    if (json['errors'] != null) {
      final errors = (json['errors'] as Map<String, dynamic>?)?.map(
        (field, messages) => MapEntry(
          field,
          (messages as List?)
                  ?.map((message) => message?.toString() ?? "")
                  .toList() ??
              [],
        ),
      );

      throw ValidationErrorException(errors!);
    } else if (json['error'] != null) {
      errorMessage = json['error'];
    } else if (json['message'] != null) {
      errorMessage = json['message'];
    } else {
      errorMessage = "Something went wrong";
    }
  }

  @override
  String toString() {
    return 'ApiException{errorCode: $errorCode, errorMessage:$errorMessage}';
  }
}

class BusinessException extends PawsException {
  BusinessException(String errorCode, String errorMessage) {
    this.errorCode = errorCode;
    this.errorMessage = errorMessage;
  }
}
