sealed class LoginEvent {
  const LoginEvent();
}

class LoginEventButtonSignInTap extends LoginEvent {
  final String username;
  final String password;

  const LoginEventButtonSignInTap({
    required this.username,
    required this.password,
  });
}
