class CustomException implements Exception {
  final String message;
  final String prefix;

  CustomException(this.message, this.prefix);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class BadRequestException extends CustomException {
  BadRequestException(String message) : super(message, "Bad Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException(String message) : super(message, "Unauthorised: ");
}

class ForbiddenException extends CustomException {
  ForbiddenException(String message) : super(message, "Forbidden: ");
}

class NotFoundException extends CustomException {
  NotFoundException(String message) : super(message, "Not Found: ");
}

class ConflictException extends CustomException {
  ConflictException(String message) : super(message, "Conflict: ");
}

class PreconditionFailedException extends CustomException {
  PreconditionFailedException(String message)
      : super(message, "Precondition Failed: ");
}

class InternalServerErrorException extends CustomException {
  InternalServerErrorException(String message)
      : super(message, "Internal Server Error: ");
}

CustomException newHTTPException(int statusCode, String message) {
  switch (statusCode) {
    case 400:
      return BadRequestException(message);
    case 401:
      return UnauthorisedException(message);
    case 403:
      return ForbiddenException(message);
    case 404:
      return NotFoundException(message);
    case 409:
      return ConflictException(message);
    case 412:
      return PreconditionFailedException(message);
    case 500:
    default:
      return InternalServerErrorException(message);
  }
}
