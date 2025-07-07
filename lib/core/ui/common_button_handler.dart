class CommonButtonHandler {
  final String title;
  final bool isEnabled;
  final bool isStartActivityIndicator;

  CommonButtonHandler({
    required this.title,
    required this.isEnabled,
    this.isStartActivityIndicator = false,
  });

  CommonButtonHandler copyWith({
    String? title,
    bool? isEnabled,
    bool? isStartActivityIndicator,
  }) {
    return CommonButtonHandler(
      title: title ?? this.title,
      isEnabled: isEnabled ?? this.isEnabled,
      isStartActivityIndicator:
          isStartActivityIndicator ?? this.isStartActivityIndicator,
    );
  }
}