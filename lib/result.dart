class Result<T> {
  final T? value;
  final Error? error;

  Result({required this.value, required this.error});

  bool hasValue() => this.value != null;
}
