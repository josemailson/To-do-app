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
    test('caso de sucesso', () async {
      when(
        () => firebaseAuth.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((invocation) async => userCredential);
      when((() => userCredential.user)).thenReturn(user);
      //act
      final result = await repository.login('jmailsons@gmail.com', '99221902');
      //assert
      // result.runtimeType == UserModel
      expect(result, isA<UserModel>());
      //result.email == 'jmailsons@gmail.com'
      expect(result.email, 'jmailsons@gmail.com');
    });

    //erro não existe usuário
    test('se nao vier user, throw exception', () async {
      when(
        () => firebaseAuth.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((invocation) async => userCredential);
      //act
      //assert
      expect(() => repository.login('jmailsons@gmail.com', '99221902'),
          throwsA(isA<Exception>()));
    });
    //erro conexão com o firebase
    test('se não houver conexão, throw exception', () async {
      when(
        () => firebaseAuth.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(
            named: 'password',
          ),
        ),
      ).thenThrow(Exception());
      expect(() => repository.login('jmailsons@gmail.com', '99221902'),
          throwsException);
    });
  });
}
