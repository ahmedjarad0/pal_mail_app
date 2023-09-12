class ApiResponse<T> {
  StatusCode status;
  T? data;
  String? message;

  ApiResponse.loading(this.message) : status = StatusCode.LOADING;
  ApiResponse.completed(this.data) : status = StatusCode.COMPLETED;
  ApiResponse.error(this.message) : status = StatusCode.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum StatusCode { LOADING, COMPLETED, ERROR }