import 'package:frontend/domain/box.dart';

class Result<T> {
  Box<T> _value = EmptyBox();
  Box<ResultError> _error = EmptyBox();

  bool get isSuccess => _value is ValueBox<T>;
  bool get isFailure => _error is ValueBox<ResultError>;

  T get value => (_value as ValueBox<T>).value;
  ResultError get error => (_error as ValueBox<ResultError>).value;

  Result.success(T value) {
    this._value = ValueBox(value);
  }
  Result.failure(ResultError error) {
    this._error = ValueBox(error);
  }
  Result._failure(this._error);

  Result<U> map<U>(U Function(T) transform) {
    if (isSuccess) {
      return Result.success(transform(value));
    }
    return Result._failure(_error);
  }

  Result<T> mapFailure(ResultError Function(ResultError) transform) {
    if (isFailure) {
      return Result.failure(transform(error));
    }

    return this;
  }

  Result<U> flatMap<U>(Result<U> Function(T) transform) {
    if (isSuccess) {
      try {
        return transform(value);
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
        return await transform(value);
      } catch (e) {
        return Result.failure(ResultError(message: e.toString()));
      }
    } else {
      return Result.failure(error);
    }
  }

  Result<T> onSuccess(void Function(T) callback) {
    if (isSuccess) {
      callback(value);
    }
    return this;
  }

  Result<T> onFailure(void Function(ResultError) callback) {
    if (isFailure) {
      callback(error);
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
}

class ResultError {
  int? code;
  String? message;

  ResultError({this.code, this.message});
}
