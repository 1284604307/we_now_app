
/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
class ResultData {
  var data;
  bool isSuccess;
  int code;
  var headers;

  ResultData(this.data, this.isSuccess, this.code, {this.headers});
}