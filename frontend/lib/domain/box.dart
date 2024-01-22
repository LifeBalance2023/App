abstract class Box<T> {}

class EmptyBox<T> extends Box<T> {}

class ValueBox<T> extends Box<T> {
  final T value;

  ValueBox(this.value);
}