
class UserInput {
  final String predictionInput;

  UserInput({required this.predictionInput});

  Map<String, dynamic> toJson() {
    return {
      'prediction_input': predictionInput,
    };
  }
}

class HTTPValidationError {
  final List<ValidationError> detail;

  HTTPValidationError({required this.detail});

  factory HTTPValidationError.fromJson(Map<String, dynamic> json) {
    return HTTPValidationError(
      detail: List<ValidationError>.from(
        json['detail'].map((v) => ValidationError.fromJson(v)),
      ),
    );
  }
}

class ValidationError {
  final List<dynamic> loc;
  final String msg;
  final String type;

  ValidationError({
    required this.loc,
    required this.msg,
    required this.type,
  });

  factory ValidationError.fromJson(Map<String, dynamic> json) {
    return ValidationError(
      loc: List<dynamic>.from(json['loc']),
      msg: json['msg'],
      type: json['type'],
    );
  }
}
