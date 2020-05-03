import 'package:flutter_app2/common/Api.dart';

/**
 * @createDate  2020/5/3
 */
class db_helper {

  static createDBsIfNotExists(){
    Api.db.execute("CREATE TABLE IF NOT EXISTS messages (id INTEGER,);");
  }



}