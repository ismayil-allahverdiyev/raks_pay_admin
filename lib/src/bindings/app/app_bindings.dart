import 'package:get/get.dart';
import '../../controllers/app/app_controller.dart';
import '../../data/provider/api_client.dart';
import '../../data/repository/repository.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppController>(
      () => AppController(
        repository: Repository(
          apiClient: ApiClient(),
        ),
      ),
    );
  }
}
