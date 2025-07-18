import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../Utils/utils.dart';
import '../../data/repositories/repositories.dart';

class HomeScreenLatestCustomersViewModel{
  final _api = Repositories();

  RxBool loading = false.obs;
  Future<void> DB_LatestCustomers(BuildContext context)async{

    loading.value = true;
    _api.dbLatestCustomersApi().then((value){
      if(value.items != null){
        Utils.snackbarSuccess('leads customer_list fetched');

      }else{
        Utils.snackbarFailed('leads customer_list not fetched');
      }
      loading.value = false;

    }).onError((error, stackTrace){
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }
}

