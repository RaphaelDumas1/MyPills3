abstract class Crud<T> {
  Future<int> create(T item);
  Future<T?> findById(int id);
  Future<int> update(T item);
  Future<int> delete(int id);
  Future<List<T>> findAll();
}
