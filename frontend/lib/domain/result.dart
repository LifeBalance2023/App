import 'package:frontend/domain/box.dart';

class Result<T> {
  Box<T> _valueBox = EmptyBox();
  Box<ResultError> _errorBox = EmptyBox();

  bool get isSuccess => _valueBox is ValueBox<T>;
  bool get isFailure => _errorBox is ValueBox<ResultError>;

  T get value => (_valueBox as ValueBox<T>).value;
  ResultError get error => (_errorBox as ValueBox<ResultError>).value;

  Result.success(T value) {
    this._valueBox = ValueBox(value);
  }
  Result.failure(ResultError error) {
    this._errorBox = ValueBox(error);
  }
  Result._failure(this._errorBox);

  Result<U> map<U>(U Function(T) transform) {
    if (isSuccess) {
      return Result.success(transform(value));
    }
    return Result._failure(_errorBox);
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
