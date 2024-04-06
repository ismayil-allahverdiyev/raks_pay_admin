import 'package:get/get.dart';
import '../../controllers/app/app_controller.dart';
import '../../controllers/home/home_controller.dart';
import '../../data/provider/api_client.dart';
import '../../data/repository/repository.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        repository: Repository(
          apiClient: ApiClient(),
        ),
      ),
    );
  }
}
