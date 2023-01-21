import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/model/user_model.dart';
import 'package:to_do_app/repository/sign_in_repository.dart';
import 'package:mocktail/mocktail.dart';

class FirebaseMock extends Mock implements FirebaseAuth {}

class UserCredentialMock extends Mock implements UserCredential {}

class UserMock extends Mock implements User {}

void main() {
  //arrange
  late FirebaseRepository repository;
  late FirebaseMock firebaseAuth;
  late UserCredentialMock userCredential;
  late UserMock user;

  setUp(() {
    firebaseAuth = FirebaseMock();
    repository = FirebaseRepository(firebaseAuth);
    userCredential = UserCredentialMock();
    user = UserMock();
  });

  //sucesso, se logou e devolveu um UserModel
  group('method login', () {
    test('success case for login', () async {
      when(
        () => firebaseAuth.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((invocation) async => userCredential);
      when((() => userCredential.user)).thenReturn(user);
      //act
      final result = await repository.login('user@email.com', 'user@123');
      //assert
      // result.runtimeType == UserModel
      expect(result, isA<UserModel>());
      //result.email == 'jmailsons@gmail.com'
      expect(result.email, 'user@email.com');
    });

    //erro não existe usuário
    test('no user returned, throw exception', () async {
      when(
        () => firebaseAuth.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((invocation) async => userCredential);
      //act
      //assert
      expect(() => repository.login('user@email.com', 'user@123'),
          throwsA(isA<Exception>()));
    });
    //erro conexão com o firebase
    test('no connection, throw exception', () async {
      when(
        () => firebaseAuth.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(
            named: 'password',
          ),
        ),
      ).thenThrow(Exception());
      expect(() => repository.login('user@email.com', 'user@123'),
          throwsException);
    });
  });

  group('method register', () {
    test('success case for sign up', () async {
      when(
        () => firebaseAuth.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((invocation) async => userCredential);
      when((() => userCredential.user)).thenReturn(user);
      final result = await repository.register('user@email.com', 'user@123');
      expect(result, isA<UserModel>());
      expect(result.email, 'user@email.com');
    });
    test('success sign up failure', () async {
      when(
        () => firebaseAuth.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(Exception());
      expect(() => repository.register('user@email.com', 'user@123'),
          throwsException);
    });
  });
}
