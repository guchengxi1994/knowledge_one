class Demo {
  final String message;
  const Demo(this.message);

  @Deprecated('`message` is only for demo')
  String get expires => message;

  @override
  String toString() => "Demo feature: $message";
}
