import 'package:flutter/cupertino.dart';

class WalletModel with ChangeNotifier {
  String userName = "John Doe";
  String accountNumber = "1234 5678 9012";
  String bankName = "Digital Bank of Flutter";
  String walletId = "WLT-1234XXXX";
  String ifscCode = "DIGI0001234";
  double totalBalance = 15420.75;

  List<Map<String, String>> transactionHistory = [
    {"date": "2025-05-05", "amount": "-₹499", "desc": "Netflix Subscription"},
    {"date": "2025-05-04", "amount": "+₹1000", "desc": "Wallet Top-up"},
    {"date": "2025-05-03", "amount": "-₹149", "desc": "Prime Video Rental"},
    {"date": "2025-05-02", "amount": "-₹299", "desc": "Disney+ Hotstar Premium"},
    {"date": "2025-05-01", "amount": "-₹199", "desc": "ZEE5 Subscription"},
  ];


  void updateUserDetails({
    String? newName,
    String? newBankName,
    String? newAccountNumber,
    String? newWalletId,
    String? newIfscCode,
  }) {
    if (newName != null) userName = newName;
    if (newBankName != null) bankName = newBankName;
    if (newAccountNumber != null) accountNumber = newAccountNumber;
    if (newWalletId != null) walletId = newWalletId;
    if (newIfscCode != null) ifscCode = newIfscCode;
    notifyListeners();
  }
}
