import '../domain/identifiable.dart';

class Repository<T extends Identifiable> {
  final Map<String, T> _data = {};

  T? get(String id) => _data[id];

  List<T> getAll() => _data.values.toList();

  void addOrUpdate(T entity) {
    _data[entity.id] = entity;
  }

  bool delete(String id) {
    if (_data.containsKey(id)) {
      _data.remove(id);
      return true;
    }
    return false;
  }

  void replaceAll(List<T> entities) {
    _data.clear();
    entities.forEach(addOrUpdate);
  }
}