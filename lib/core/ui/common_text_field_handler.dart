class CommonTextFieldHandler {
  final String value;
  final String label;
  final String placeholder;
  final String message;

  CommonTextFieldHandler({
    required this.value,
    required this.label,
    required this.placeholder,
    required this.message,
  });

  CommonTextFieldHandler copyWith({
    String? value,
    String? label,
    String? placeholder,
    String? message,
  }) {
    return CommonTextFieldHandler(
      value: value ?? this.value,
      label: label ?? this.label,
      placeholder: placeholder ?? this.placeholder,
      message: message ?? this.message,
    );
  }
}
