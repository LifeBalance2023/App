class Result<T> {
  T? value;
  Error? error;

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

  Result<T> mapFailure(Error Function(Error) transform) {
    if (isFailure) {
      return Result.failure(transform(error!));
    } else {
      return Result.success(value);
    }
  }

}

class Error {
  int? code;
  String? message;

  Error({this.code, this.message});
}
