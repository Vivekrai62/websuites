import 'package:get/get.dart';
import '../../../../data/repositories/repositories.dart';
import '../../../data/models/responseModels/products/activation_forms/ProductsActivationsFormsResModel.dart';

class ActivationsFormsViewModel extends GetxController {
  final _api = Repositories();
  RxBool loading = false.obs;

  RxList<ProductsActivationsFormsResModel> productActivationsList =
      <ProductsActivationsFormsResModel>[].obs; // Observable customer_list
  RxList<ProductsActivationsFormsResModel> filteredProductActivationsList =
      <ProductsActivationsFormsResModel>[].obs;

  Future<void> productActivations() async {
    loading.value = true;
    try {
      final value = await _api.productActivations();
      // print("API Response: $value"); // Log raw response
      if (value.isNotEmpty) {
        productActivationsList.value = value; // Update observable role
        filteredProductActivationsList.value = value; // Update filtered role
        // print("Updated productGstList with ${productGstList.length} items"); // Confirm update
        for (var data in value) {
          // print("Product GST List name: ${data.name}");
          // print("Product GST List id: ${data.id}");
          // print("Product GST List cgst: ${data.cgst}");
          // print("Product GST List status: ${data.status}");
        }
        // Utils.snackbarSuccess('Product GST List fetched');
      } else {
        // print("API returned empty role");
        // Utils.snackbarFailed('Product GST List is empty');
      }
    } catch (error) {
      // print("Error fetching product GST role: $error");
      // print("StackTrace: $stackTrace");
      // Utils.snackbarFailed('Error fetching product GST List: $error');
    } finally {
      loading.value = false; // Ensure loading is false even on error
    }
  }

  // Method to filter the product customer_list based on the search query
  void filterProductGstList(String query) {
    if (query.isEmpty) {
      filteredProductActivationsList.value =
          productActivationsList; // Reset to the full customer_list if the query is empty
    } else {
      filteredProductActivationsList.value =
          productActivationsList.where((product) {
        return product.name?.toLowerCase().contains(query.toLowerCase()) ??
            false;
      }).toList();
    }
  }
}
