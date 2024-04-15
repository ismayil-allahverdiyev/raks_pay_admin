import 'package:get/get.dart';
import '../bindings/app/app_bindings.dart';
import '../bindings/home/home_bindings.dart';
import '../bindings/reviews/reviews_bindings.dart';
import '../ui/app.dart';
import '../ui/home/home_page.dart';
import '../ui/reviews/reviews_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => const AppPage(),
      binding: AppBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.REVIEWS,
      page: () => const ReviewsPage(),
      binding: ReviewsBinding(),
    ),
  ];
}
