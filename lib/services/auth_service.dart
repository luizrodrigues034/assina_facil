import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/user.dart';

class AuthService extends ChangeNotifier {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;
  User? get firebaseUser => _auth.currentUser;

  bool get isLoggedIn => _auth.currentUser != null;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> initialize() async {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        _loadUserData(user.uid);
      } else {
        _currentUser = null;
      }
      notifyListeners();
    });
  }

  Future<void> _loadUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        _currentUser = UserModel.fromJson({'id': uid, ...doc.data()!});
      } else {
        // Se não existe no Firestore, cria a partir do Firebase Auth
        final firebaseUser = _auth.currentUser;
        if (firebaseUser != null) {
          _currentUser = UserModel.fromFirebaseUser(firebaseUser);
        }
      }
    } catch (e) {
      print('Erro ao carregar dados do usuário: $e');
      // Fallback para dados do Firebase Auth
      final firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        _currentUser = UserModel.fromFirebaseUser(firebaseUser);
      }
    }
  }

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String cpf,
    required String password,
  }) async {
    try {
      // Criar usuário no Firebase Auth
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) return false;

      // Atualizar display name
      await user.updateDisplayName('$firstName $lastName');

      // Salvar dados adicionais no Firestore
      final userData = UserModel(
        id: user.uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        cpf: cpf,
        createdAt: DateTime.now(),
      );

      await _firestore.collection('users').doc(user.uid).set(userData.toJson());

      // Carregar dados do usuário
      await _loadUserData(user.uid);

      return true;
    } on FirebaseAuthException catch (e) {
      print('Erro no registro: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('Erro inesperado no registro: $e');
      rethrow;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        await _loadUserData(user.uid);
        notifyListeners();
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      print('Erro no login: [31m${e.code}[0m - ${e.message}');
      rethrow;
    } catch (e) {
      print('Erro inesperado no login: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      _currentUser = null;
      notifyListeners();
    } catch (e) {
      print('Erro no logout: $e');
      rethrow;
    }
  }

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? cpf,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('Usuário não autenticado');

      // Atualizar display name se necessário
      if (firstName != null || lastName != null) {
        final newFirstName = firstName ?? _currentUser?.firstName ?? '';
        final newLastName = lastName ?? _currentUser?.lastName ?? '';
        await user.updateDisplayName('$newFirstName $newLastName');
      }

      // Atualizar dados no Firestore
      final updates = <String, dynamic>{};
      if (firstName != null) updates['firstName'] = firstName;
      if (lastName != null) updates['lastName'] = lastName;
      if (cpf != null) updates['cpf'] = cpf;

      if (updates.isNotEmpty) {
        await _firestore.collection('users').doc(user.uid).update(updates);
      }

      // Recarregar dados do usuário
      await _loadUserData(user.uid);
    } catch (e) {
      print('Erro ao atualizar perfil: $e');
      rethrow;
    }
  }

  Future<void> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('Usuário não autenticado');

      // Deletar dados do Firestore
      await _firestore.collection('users').doc(user.uid).delete();

      // Deletar conta do Firebase Auth
      await user.delete();
      _currentUser = null;
      notifyListeners();
    } catch (e) {
      print('Erro ao deletar conta: $e');
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print('Erro ao resetar senha: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('Erro inesperado ao resetar senha: $e');
      rethrow;
    }
  }

  String getAuthErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Usuário não encontrado';
      case 'wrong-password':
        return 'Senha incorreta';
      case 'email-already-in-use':
        return 'Email já está em uso';
      case 'weak-password':
        return 'Senha muito fraca';
      case 'invalid-email':
        return 'Email inválido';
      case 'user-disabled':
        return 'Conta desabilitada';
      case 'too-many-requests':
        return 'Muitas tentativas. Tente novamente mais tarde';
      case 'operation-not-allowed':
        return 'Operação não permitida';
      default:
        return 'Erro de autenticação: $code';
    }
  }
}
