import '../../localization/localized_strings.dart';

class ApiFailure {
  final List<String>? messages;

  const ApiFailure({this.messages});

  String get publicError => (messages ?? []).join('\n');

  factory ApiFailure.fromJson(Map<String, dynamic> json) {
    return ApiFailure(messages: json['messages'].cast<String>());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messages'] = messages;
    return data;
  }
}

class NoInternetApiFailure extends ApiFailure {
  NoInternetApiFailure()
    : super(
        messages: [
          LocalizedStrings.pleaseCheckYourInternetConnectionAndTryAgain,
        ],
      );
}
