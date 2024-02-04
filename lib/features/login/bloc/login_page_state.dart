sealed class LoginPageState {
  bool get isLoading {
    switch (this) {
      case LoginPageStateDefault():
        return false;
      case LoginPageStateLoading():
        return true;
    }
  }
}

class LoginPageStateDefault extends LoginPageState {}

class LoginPageStateLoading extends LoginPageState {}
