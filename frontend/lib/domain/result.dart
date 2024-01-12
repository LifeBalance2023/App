class Result<T> {
  T? value;
  ResultError? error;
  bool _isVoidSuccess = false;

  bool get isSuccess => value != null || _isVoidSuccess;
  bool get isFailure => error != null;

  Result.success(T this.value);
  Result.failure(this.error);
  Result.voidSuccess() {
    _isVoidSuccess = true;
  }

  Result<U> map<U>(U Function(T) transform) {
    if (isSuccess) {
      return Result.success(transform(value as T));
    } else {
      return Result.failure(error);
    }
  }

  Result<T> mapFailure(ResultError Function(ResultError) transform) {
    if (isFailure) {
      return Result.failure(transform(error!));
    } else {
      return Result.success(value as T);
    }
  }

  Result<U> flatMap<U>(Result<U> Function(T) transform) {
    if (isSuccess) {
      try {
        return transform(value as T);
      } catch (e) {
        return Result.failure(ResultError(message: e.toString()));
      }
    } else {
      return Result.failure(error);
    }
  }

  Future<Result<U>> flatMapFuture<U>(Future<Result<U>> Function(T) transform) async {
    if (isSuccess) {
      try {
        return await transform(value as T);
      } catch (e) {
        return Result.failure(ResultError(message: e.toString()));
      }
    } else {
      return Result.failure(error);
    }
  }

  Result<T> onSuccess(void Function(T) callback) {
    if (isSuccess) {
      callback(value as T);
    }
    return this;
  }

  Result<T> onFailure(void Function(ResultError) callback) {
    if (isFailure) {
      callback(error!);
    }
    return this;
  }

  static Result<U> runCatching<U>(U Function() operation) {
    try {
      return Result.success(operation());
    } catch (e) {
      return Result.failure(ResultError(message: e.toString()));
    }
  }

  static Future<Result<U>> runCatchingAsync<U>(Future<U> Function() operation) async {
    try {
      U result = await operation();
      return Result.success(result);
    } catch (e) {
      return Result.failure(ResultError(message: e.toString()));
    }
  }

  static Future<Result<void>> runVoidCatchingAsync(Future<void> Function() operation) async {
    try {
      await operation();
      return Result.voidSuccess();
    } catch (e) {
      return Result.failure(ResultError(message: e.toString()));
    }
  }
}

class ResultError {
  int? code;
  String? message;

  ResultError({this.code, this.message});
}
