// Kotlin-like functions

extension ObjectExt<T> on T {
  R let<R>(R Function(T that) op) => op(this);
}

extension AsyncExtension<T> on Future<T> {
  Future<T?> callTrowable({
    void Function(Exception error)? onError,
    void Function(T value)? onSuccess,
  }) async {
    try {
      final result = await this;
      onSuccess?.call(result);
      return result;
    } on Exception catch (error) {
      onError?.call(error);
    }
    return null;
  }
}
