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

  Result<T> onSuccess(void Function(T) callback) {
    if (isSuccess) {
      callback(value as T);
    }
    return this;
  }

  Result<T> onFailure(void Function(Error) callback) {
    if (isFailure) {
      callback(error!);
    }
    return this;
  }
}

class Error {
  int? code;
  String? message;

  Error({this.code, this.message});
}
