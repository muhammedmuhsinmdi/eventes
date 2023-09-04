import 'dart:developer';

import 'package:evantez/src/model/core/models/employeetype/employeetype_model.dart';

abstract class IEmployeeTypeRepository{
  Future save(EmployeeType model);
  Future update(EmployeeType model);
  Future getById(int id);
  Future getAll();  
}

class EmployeeTypeRepository implements IEmployeeTypeRepository {
  @override
  Future getAll() async{
    var datas = [
      {"id":1,"name":"Boys","code":"B-1001"},
      {"id":2,"name":"Supervisor","code":"S-1001"},
      {"id":3,"name":"Boys A","code":"B-1003"},
      {"id":4,"name":"Boys B","code":"B-1004"},
      {"id":5,"name":"Boys C","code":"B-1005"},
      {"id":6,"name":"Boys D","code":"B-1006"},
    ];
    var result = EmployeeType.listFromMap(datas);
    return result;
  }

  @override
  Future getById(int id) async{
    var result = {"id":id,"name":"Boys","code":"B-1001"};
    return EmployeeType.fromJson(result);
  }

  @override
  Future save(EmployeeType model) async{
    log(">>>>>>>>>>${model.toJson()}<<<<<<<<<<<<");
  }

  @override
  Future update(EmployeeType model) async{
    log(">>>>>>>>>>${model.toJson()}<<<<<<<<<<<<");
  }

}
