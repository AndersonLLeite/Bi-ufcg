import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/auth/auth_repository.dart';
import './login_service.dart';

class LoginServiceImpl implements LoginService {
  final AuthRepository authRepository;

  LoginServiceImpl({required this.authRepository});

  @override
  Future<void> execute(
      {required String username, required String password}) async {
    final accessToken =
        await authRepository.login(username: username, password: password);
    final sp = await SharedPreferences.getInstance();
    sp.setString('accessToken', accessToken);
  }
}
