class Result<T> {
  T? value;
  ApiError? error;

  bool get isSuccess => value != null;
  bool get isFailure => error != null;

  Result.success(this.value);
  Result.failure(this.error);
}

class ApiError {
  int? code;
  String? message;

  ApiError({this.code, this.message});
}
