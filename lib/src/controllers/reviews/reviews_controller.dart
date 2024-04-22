import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raks_pay_admin/src/data/models/reviews/review_model.dart';
import 'package:raks_pay_admin/src/data/models/transaction/transaction_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';
import '../../data/repository/repository.dart';

class ReviewsController extends GetxController {
  final Repository repository;
  ReviewsController({required this.repository});

  var store = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  var reviews = <ReviewModel>[].obs;

  var selectedImage = Rxn<File>();
  var mainTextController = TextEditingController();
  var titleTextController = TextEditingController();
  var descriptionTextController = TextEditingController();
  var usernameTextController = TextEditingController();
  var fromTextController = TextEditingController();

  var isSelectionOn = false.obs;
  var selectedReviews = <ReviewModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getReviews();
  }

  getReviews() async {
    await store.collection('reviews').get().then(
      (QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc.exists) {
            reviews.add(
              ReviewModel.fromJson(
                {
                  'id': doc.id,
                  ...doc.data() as Map<String, dynamic>,
                },
              ),
            );
          }
        }
      },
    );
    reviews.sort((a, b) => a.date.compareTo(b.date));
    reviews = reviews.reversed.toList().obs;
    reviews.refresh();
  }

  selectImage() async {
    selectedImage.value = await repository.selectImage();
  }

  updateReview(String id, ReviewModel review) async {
    var image;
    if (selectedImage.value != null)
      image =
          await storageRef.child('reviews/$id').putFile(selectedImage.value!);

    var data = {
      'main':
          mainTextController.text == "" ? review.main : mainTextController.text,
      'title': titleTextController.text == ""
          ? review.title
          : titleTextController.text,
      'description': descriptionTextController.text == ""
          ? review.description
          : descriptionTextController.text,
      'image': selectedImage.value != null
          ? await image.ref.getDownloadURL()
          : review.image,
    };

    await store.collection('reviews').doc(id).update(data);

    Get.back();

    reviews.clear();

    await getReviews();
  }

  deleteReview(String id) async {
    await store.collection('reviews').doc(id).delete();

    reviews.clear();

    await getReviews();
  }

  addReview() async {
    if (selectedImage.value == null ||
        mainTextController.text == "" ||
        titleTextController.text == "" ||
        descriptionTextController.text == "" ||
        usernameTextController.text == "" ||
        fromTextController.text == "") {
      Get.snackbar('Error', 'Please fill in all the fields');
      return;
    }

    var image;
    if (selectedImage.value != null) {
      var uuid = Uuid().v4();
      image =
          await storageRef.child('reviews/$uuid').putFile(selectedImage.value!);
    }

    if (image == null) {
      Get.snackbar('Error', 'Please select an image');
      return;
    }

    var data = {
      'main': mainTextController.text,
      'title': titleTextController.text,
      'description': descriptionTextController.text,
      'name': usernameTextController.text,
      'image':
          selectedImage.value != null ? await image.ref.getDownloadURL() : '',
      'from': fromTextController.text,
      'date': DateTime.now(),
    };

    await store.collection('reviews').add(data);

    Get.back();

    reviews.clear();

    await getReviews();
  }

  selectReviews() async {
    if (selectedReviews.value.length == 3) {
      isSelectionOn.value = false;
      for (int i = 0; i < selectedReviews.length; i++) {
        await store.collection("selected_reviews").doc((i + 1).toString()).set({
          "title": selectedReviews[i].main + " " + selectedReviews[i].title,
          "description": selectedReviews[i].description,
          "name": selectedReviews[i].name,
          "from": selectedReviews[i].from,
          "date": DateTime.now(),
        });
      }

      selectedReviews.clear();
    } else {
      repository.showMessage(
          title: 'Error', message: 'Please select 3 reviews');
    }
  }
}
