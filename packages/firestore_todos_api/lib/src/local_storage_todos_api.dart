import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todos_api/todos_api.dart';

class FirestoreTodosApi extends TodosApi {
  final CollectionReference<Map<String, dynamic>> _todoCollection =
      FirebaseFirestore.instance.collection('todos');

  @override
  Stream<List<Todo>> getTodos(String uid) {
    print(uid);
    return _todoCollection
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        return Todo.fromJson(data);
      }).toList();
    });
  }

  @override
  Future<void> saveTodo(Todo todo) {
    return _todoCollection.add(todo.toJson());
  }

  @override
  Future<void> editTodo(Todo todo) {
    return _todoCollection.doc(todo.id).update(todo.toJson());
  }

  @override
  Future<void> deleteTodo(String id) async {
    await _todoCollection.doc(id).delete();
  }

  @override
  Future<int> clearCompleted() async {
    final querySnapshot =
        await _todoCollection.where('isCompleted', isEqualTo: true).get();

    final batch = FirebaseFirestore.instance.batch();
    for (var doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
    return querySnapshot.size;
  }

  @override
  Future<int> completeAll({required bool isCompleted}) async {
    final querySnapshot = await _todoCollection
        .where('isCompleted', isNotEqualTo: isCompleted)
        .get();

    final batch = FirebaseFirestore.instance.batch();
    for (var doc in querySnapshot.docs) {
      batch.update(doc.reference, {'isCompleted': isCompleted});
    }

    await batch.commit();
    return querySnapshot.size;
  }

}