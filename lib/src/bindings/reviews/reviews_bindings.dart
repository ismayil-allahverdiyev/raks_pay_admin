import 'package:get/get.dart';
import '../../controllers/reviews/reviews_controller.dart';
import '../../data/provider/api_client.dart';
import '../../data/repository/repository.dart';

class ReviewsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewsController>(
      () => ReviewsController(
        repository: Repository(
          apiClient: ApiClient(),
        ),
      ),
    );
  }
}
