import 'dart:async';
import '../../commons/utils/pref.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final StreamController _controller = StreamController<AuthenticationStatus>();
  final LocalPref _pref = LocalPref();

  Stream<AuthenticationStatus> get status async* {
    try {
      final token = await _pref.getString(PrefKey.accessToken) ?? '';

      if (token.isNotEmpty) {
        yield AuthenticationStatus.authenticated;
      } else {
        yield AuthenticationStatus.unauthenticated;
      }
    } catch (_) {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
