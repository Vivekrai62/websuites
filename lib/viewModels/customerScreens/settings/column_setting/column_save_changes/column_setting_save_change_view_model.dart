import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../Utils/utils.dart';
import '../../../../../data/models/requestModels/customer/setting/field_setting/field_setting_save_change-request_model.dart';
import '../../../../../data/repositories/repositories.dart';

class ColumnSettingSaveChangesViewModel extends GetxController{

  final _api = Repositories();
  RxBool loading = false.obs;
  Future<void> settingColumnSaveChange(BuildContext context) async {

    // List<ColumnField> column = [
    //   ColumnField(id: "2c90bb28-2184-4700-b9b2-0fe4bba2f447", leadField: "First Name", fieldName: "first_name"),
    //   ColumnField(id: "e56c6786-68ef-45c0-a9ee-4a01bb6d4b70", leadField: "Name", fieldName: "name", status: true),
    //   ColumnField(id: "9abbb940-8a52-4392-96e8-7623c37cb332", leadField: "Organization Name", fieldName: "organization_name"),
    //   ColumnField(id: "2401b356-4593-4692-92ae-0e171a6bb37e", leadField: "LastName", fieldName: "last_name"),
    //   ColumnField(id: "fde554af-6c64-441a-b434-4203a701e81f", leadField: "Primary Email", fieldName: "primary_email"),
    //   ColumnField(id: "6444668a-17f5-4257-ab2b-bff9023e5131", leadField: "Secondary Email", fieldName: "secondary_email"),
    //   ColumnField(id: "fa50c858-6395-40a4-a370-9e6bf7222945", leadField: "Primary Contact", fieldName: "primary_contact"),
    //   ColumnField(id: "a3fb8ddd-e751-4e00-b5b0-20ffb95e8aa9", leadField: "Contact Info", fieldName: "contact_info"),
    //   ColumnField(id: "7d5de90b-3275-40ac-8145-e892d9aaddcd", leadField: "Secondary Contact", fieldName: "secondary_contact"),
    //   ColumnField(id: "bc832916-8020-4c1d-b0c3-d41852fdde09", leadField: "City", fieldName: "city", status: true),
    //   ColumnField(id: "1fe38be2-8434-4dc7-a531-d545a015f0c8", leadField: "Source", fieldName: "source", status: true),
    //   ColumnField(id: "7bdbb9bb-9868-4cd9-af40-d2f65defd55c", leadField: "Division", fieldName: "divisions"),
    //   ColumnField(id: "8bc56df6-b872-4671-9237-b6533dac535e", leadField: "Address", fieldName: "address"),
    //   ColumnField(id: "ad3e1af3-4aef-4d9c-a44f-289c9a3b12ac", leadField: "Primary Address", fieldName: "primary_address"),
    //   ColumnField(id: "31f4f93d-f8ae-41b2-9553-e6fd3a85816f", leadField: "Customer Type", fieldName: "customer_type"),
    //   ColumnField(id: "9f8eb88a-0a22-47bb-adf2-7889949dcb53", leadField: "Created At", fieldName: "created_at"),
    //   ColumnField(id: "3a1ec993-a7ea-437a-bae7-9912d4a3e44d", leadField: "campaign", fieldName: "campaign"),
    //   ColumnField(id: "d8cba44e-4442-482d-8a84-df15b2e0a85f", leadField: "Updated At", fieldName: "updated_at"),
    //   ColumnField(id: "516d912e-487f-4047-a462-43c25022f675", leadField: "reminder", fieldName: "reminder"),
    //   ColumnField(id: "90f7b838-a541-4c7e-8745-d6dfd26f58a2", leadField: "last_activity", fieldName: "last_activity"),
    //   ColumnField(id: "5743511e-246b-4175-944b-069b17ad6476", leadField: "assignee", fieldName: "assignee"),
    //   ColumnField(id: "553d5a77-38a4-462a-aa1a-52bd4eb1d71e", leadField: "Status", fieldName: "status", status: true),
    // ];
    print("Column Field $Column");
    ColumnField request = ColumnField(id: "553d5a77-38a4-462a-aa1a-52bd4eb1d71e", leadField: "Status", fieldName: "status", status: true);
    loading.value = true;
    _api.customerSettingColumnSaveChanges(request.toJson()).then((response) {
      if (response.isNotEmpty) {
        for (var responseData in response) {
          if (kDebugMode) {
            print("Customer Setting Column Save changes  ${responseData.type}");
            print("Customer Setting Column  Save changes  ${responseData.fieldName}");
            print("Customer Setting Column  Save changes ${responseData.filter}");
          }
          Utils.snackbarSuccess('Customer  Setting Column List Save changes');
        }
        loading.value = false;
      }
      else{
        Utils.snackbarFailed('Customer Safe Area Product data  not found');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    );
  }

}