import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raks_pay_admin/src/controllers/reviews/reviews_controller.dart';
import 'package:raks_pay_admin/src/ui/reviews/widgets/edit_dialog.dart';

import '../theme/app_colors.dart';

class ReviewsPage extends GetView<ReviewsController> {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'Reviews',
          style: TextStyle(
            color: whiteColor,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 4),
          Expanded(
            child: Obx(
              () {
                return ListView.builder(
                  itemCount: controller.reviews.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black54,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: (Get.width - 40) * 0.085,
                                      backgroundImage: NetworkImage(
                                        controller.reviews[index].image,
                                      ),
                                    ),
                                    SizedBox(
                                      width: (Get.width - 40) * 0.03,
                                    ),
                                    SizedBox(
                                      width: (Get.width - 40) * 0.7,
                                      child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  "${controller.reviews[index].main} ",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                            TextSpan(
                                              text: controller
                                                  .reviews[index].title,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: (Get.width - 40) * 0.01,
                                    ),
                                    SizedBox(
                                      width: (Get.width - 40) * 0.05,
                                      child: IconButton(
                                        onPressed: () {
                                          print("object");
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: (Get.width - 40) * 0.04,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  controller.reviews[index].description,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.dialog(
                                      EditDialogWidget(
                                        review: controller.reviews[index],
                                      ),
                                    ).then((value) {
                                      controller.selectedImage.value = null;
                                      controller.mainTextController.clear();
                                      controller.titleTextController.clear();
                                      controller.descriptionTextController
                                          .clear();
                                    });
                                  },
                                  child: const Text("Edit"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
