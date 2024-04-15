import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:raks_pay_admin/src/data/models/transaction/transaction_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/repository/repository.dart';

class HomeController extends GetxController {
  final Repository repository;
  HomeController({required this.repository});

  var store = FirebaseFirestore.instance;

  var transactions = <TransactionModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    getTransactionRequest();
  }

  getTransactionRequest() async {
    await store.collection('transactions').get().then(
      (QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc.exists) {
            transactions.add(
              TransactionModel.fromJson(
                doc.data()! as Map<String, dynamic>,
              ),
            );
          }
        }
      },
    );
    transactions.sort((a, b) => a.date.compareTo(b.date));
    transactions = transactions.reversed.toList().obs;
    transactions.refresh();
    print(transactions.value[0].date.toString());
  }

  openWhatsapp({required int index}) async {
    var androidUrl =
        "whatsapp://send?phone=${transactions[index].phoneCode + transactions[index].number}&text=${"Hi, We are contacting you from Raks Pay. Your transaction request has been approved. Please give use more details on your transaction. Thank you."}";
    try {
      await launchUrl(Uri.parse(androidUrl));
    } on Exception {
      repository.showMessage(
        title: "Error",
        message: 'WhatsApp is not installed.',
      );
    }
  }
}
