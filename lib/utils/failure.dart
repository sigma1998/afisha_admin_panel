abstract class BaseFailure {
}

class Failure extends BaseFailure {
  String message = 'problem occurred';
}

class NetworkFailure extends BaseFailure {
  String message = 'no internet connection';
}