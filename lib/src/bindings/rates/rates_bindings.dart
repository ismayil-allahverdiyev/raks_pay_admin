import 'package:get/get.dart';
import '../../controllers/app/app_controller.dart';
import '../../controllers/rates/rates_controller.dart';
import '../../data/provider/api_client.dart';
import '../../data/repository/repository.dart';

class RatesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RatesController>(
      () => RatesController(
        repository: Repository(
          apiClient: ApiClient(),
        ),
      ),
    );
  }
}
