import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raks_pay_admin/src/controllers/reviews/reviews_controller.dart';
import 'package:raks_pay_admin/src/ui/reviews/widgets/add_dialog.dart';
import 'package:raks_pay_admin/src/ui/reviews/widgets/edit_dialog.dart';

import '../theme/app_colors.dart';

class ReviewsPage extends GetView<ReviewsController> {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: () {
          Get.dialog(
            const AddDialogWidget(),
          ).then((value) {
            controller.selectedImage.value = null;
            controller.mainTextController.clear();
            controller.titleTextController.clear();
            controller.descriptionTextController.clear();
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
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
        actions: [
          Obx(
            () {
              return IconButton(
                onPressed: () {
                  controller.isSelectionOn.value =
                      !controller.isSelectionOn.value;
                },
                icon: Icon(
                  controller.isSelectionOn.value
                      ? Icons.cancel
                      : Icons.select_all,
                  color:
                      controller.isSelectionOn.value ? redColor : primaryColor,
                ),
              );
            },
          ),
          Obx(
            () {
              return controller.isSelectionOn.value
                  ? Obx(
                      () {
                        return IconButton(
                          onPressed: () {
                            controller.selectReviews();
                          },
                          icon: Icon(
                            controller.selectedReviews.length == 3
                                ? Icons.check_circle
                                : Icons.check_circle_outline,
                            color: controller.selectedReviews.length == 3
                                ? primaryColor
                                : redColor,
                          ),
                        );
                      },
                    )
                  : const SizedBox();
            },
          ),
        ],
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
                                      width: (Get.width - 40) * 0.09,
                                      child: IconButton(
                                        onPressed: () {
                                          controller.deleteReview(
                                              controller.reviews[index].id);
                                          // print("object");
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
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
                                Obx(
                                  () {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            controller.isSelectionOn.value &&
                                                    controller.selectedReviews
                                                        .contains(controller
                                                            .reviews[index])
                                                ? redColor
                                                : primaryColor,
                                      ),
                                      onPressed: () {
                                        if (controller.isSelectionOn.value) {
                                          if (controller.selectedReviews
                                              .contains(
                                                  controller.reviews[index])) {
                                            controller.selectedReviews.remove(
                                                controller.reviews[index]);
                                          } else {
                                            if (controller
                                                    .selectedReviews.length ==
                                                3) {
                                              Get.snackbar("Error",
                                                  "You can only select 3 reviews");
                                              return;
                                            }
                                            controller.selectedReviews
                                                .add(controller.reviews[index]);
                                          }
                                        } else {
                                          controller.mainTextController.text =
                                              controller.reviews[index].main;
                                          controller.titleTextController.text =
                                              controller.reviews[index].title;
                                          controller.descriptionTextController
                                                  .text =
                                              controller
                                                  .reviews[index].description;

                                          Get.dialog(
                                            EditDialogWidget(
                                              review: controller.reviews[index],
                                            ),
                                          ).then((value) {
                                            controller.selectedImage.value =
                                                null;
                                            controller.mainTextController
                                                .clear();
                                            controller.titleTextController
                                                .clear();
                                            controller.descriptionTextController
                                                .clear();
                                          });
                                        }
                                      },
                                      child: Text(
                                        controller.isSelectionOn.value
                                            ? controller.selectedReviews
                                                    .contains(controller
                                                        .reviews[index])
                                                ? "Remove"
                                                : "Select"
                                            : "Edit",
                                      ),
                                    );
                                  },
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
