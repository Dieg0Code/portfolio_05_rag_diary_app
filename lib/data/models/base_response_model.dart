class BaseResponseModel<T> {
  final int code;
  final String status;
  final String msg;
  final T data;

  BaseResponseModel({
    required this.code,
    required this.status,
    required this.msg,
    required this.data,
  });

  factory BaseResponseModel.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return BaseResponseModel<T>(
      code: json['code'],
      status: json['status'],
      msg: json['msg'],
      data: fromJsonT(json['data']),
    );
  }
}
