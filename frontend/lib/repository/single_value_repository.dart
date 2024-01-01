class SingleValueRepository<T> {
  T? _value;

  T? get() => _value;

  void addOrUpdate(T newValue) {
    _value = newValue;
  }

  void clear() {
    _value = null;
  }
}
