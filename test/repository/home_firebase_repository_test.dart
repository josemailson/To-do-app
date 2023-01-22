import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_app/repository/home_firebase_repository.dart';

void main() {
  late HomeFirebaseRepository homeFirebaseRepository;
  late FakeFirebaseFirestore firestoreMock;

  setUp(() {
    firestoreMock = FakeFirebaseFirestore();
    homeFirebaseRepository = HomeFirebaseRepository(firestoreMock);
  });

  group('getTodo method', () {
    test('return empty list', () async {
      final result = await homeFirebaseRepository.getToDos('');
      expect(result, isEmpty);
    });
    test('return a list', () async {
      await firestoreMock.collection('ToDoList').add(
        {
          'title': 'title',
          'description': 'description',
          'date': 123,
          'userId': 'userId',
          'isDone': false
        },
      );
      final result = await homeFirebaseRepository.getToDos('userId');
      expect(result.length, 1);
      expect(result[0].date, DateTime.fromMillisecondsSinceEpoch(123));
    });
  });
  group('deleteToDo method', () {
    test('deleted item success', () async {
      await firestoreMock.collection('ToDoList').add(
        {
          'title': 'title',
          'description': 'description',
          'date': 123,
          'userId': 'userId',
          'isDone': false
        },
      );
      final result = await homeFirebaseRepository.getToDos('userId');
      final toDoId = result[0].id!;
      expect(toDoId, isNotEmpty);
      final deleted = await homeFirebaseRepository.deleteToDo(toDoId);
      expect(deleted, true);
    });
  });
}
