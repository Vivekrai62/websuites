import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../../views/leadScreens/leadList/widgets/manat.dart';

class CustomerTypeViewModels extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;
  RxList<FilterOptionItem> customerTypeFilters = <FilterOptionItem>[].obs;

  Future<void> customerTypeList(BuildContext context) async {
    loading.value = true;
    try {
      final value = await _api.customerType();
      if (value.isNotEmpty) {
        // Map CustomerTypeResponseModel to FilterOptionItem and update the RxList
        customerTypeFilters.value = value
            .map((item) => FilterOptionItem(
                  label: item.name ??
                      'N/A', // Assuming name exists in CustomerTypeResponseModel
                  id: item
                      .id, // Assuming id exists in CustomerTypeResponseModel
                ))
            .toList();
        // Utils.snackbarSuccess('Data fetched');
      } else {
        // Utils.snackbarFailed('Customer Type data not fetched');
      }
    } catch (error) {
      // if (kDebugMode) {
      //   print(error.toString());
      // }
      // Utils.snackbarFailed('Error fetching data');
    } finally {
      loading.value = false;
    }
  }
}
