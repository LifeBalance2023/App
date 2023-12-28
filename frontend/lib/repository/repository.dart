import '../domain/identifiable.dart';

typedef RepositoryCallback<T> = void Function(RepositoryAction action, T? entity);

enum RepositoryAction { addOrUpdate, delete }

class Repository<T extends Identifiable> {
  final Map<String, T> _data = {};
  final List<RepositoryCallback<T>> _listeners = [];

  void addListener(RepositoryCallback<T> listener) {
    _listeners.add(listener);
  }

  void removeListener(RepositoryCallback<T> listener) {
    _listeners.remove(listener);
  }

  T? get(String id) => _data[id];

  List<T> getAll() => _data.values.toList();

  void addOrUpdate(T entity) {
    _data[entity.id] = entity;
    _notifyListeners(RepositoryAction.addOrUpdate, entity);
  }

  bool delete(String id) {
    if (_data.containsKey(id)) {
      var deletedEntity = _data[id];
      _data.remove(id);
      _notifyListeners(RepositoryAction.delete, deletedEntity);
      return true;
    }
    return false;
  }

  void replaceAll(List<T> entities) {
    _data.clear();
    entities.forEach(addOrUpdate);
  }

  void _notifyListeners(RepositoryAction action, T? entity) {
    for (var listener in _listeners) {
      listener(action, entity);
    }
  }
}
