class ApiException implements Exception {
  final String message;
  const ApiException(this.message);
  
  @override
  String toString() => message;
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException() : super('Unauthorized');
}

class ForbiddenException extends ApiException {
  const ForbiddenException() : super('Access denied');
}

class NotFoundException extends ApiException {
  const NotFoundException() : super('Resource not found');
}