class Result<T> {
  T? value;
  ApiError? error;

  bool get isSuccess => value != null;
  bool get isFailure => error != null;

  Result.success(this.value);
  Result.failure(this.error);

  Result<U> map<U>(U Function(T) transform) {
    if (isSuccess) {
      return Result.success(transform(value as T));
    } else {
      return Result.failure(error);
    }
  }

  // Map the failure
  Result<T> mapFailure(ApiError Function(ApiError) transform) {
    if (isFailure) {
      return Result.failure(transform(error!));
    } else {
      return Result.success(value);
    }
  }

}

class ApiError {
  int? code;
  String? message;

  ApiError({this.code, this.message});
}
