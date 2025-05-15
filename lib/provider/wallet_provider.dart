import 'package:flutter/material.dart';

class Transaction {
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    required this.title,
    required this.amount,
    required this.date,
  });
}

class WalletProvider with ChangeNotifier {
  double _balance = 0.0;
  final List<Transaction> _transactions = [];

  // Wallet Info
  String _userName = "John Doe";
  String _accountNumber = "1234 5678 9012";
  String _bankName = "Digital Bank of Flutter";
  String _walletId = "WLT-1234XXXX";
  String _ifscCode = "DIGI0001234";

  // Getters
  double get balance => _balance;
  List<Transaction> get transactions => _transactions;
  String get userName => _userName;
  String get accountNumber => _accountNumber;
  String get bankName => _bankName;
  String get walletId => _walletId;
  String get ifscCode => _ifscCode;

  // Method to add money
  void addMoney(double amount, String title) {
    _balance += amount;
    _transactions.insert(
      0,
      Transaction(
        title: title,
        amount: amount,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  // Method to reset wallet
  void resetWallet() {
    _balance = 0.0;
    _transactions.clear();
    notifyListeners();
  }

  // Method to update wallet info
  void updateWalletInfo({
    required String userName,
    required String accountNumber,
    required String bankName,
    required String walletId,
    required String ifscCode,
  }) {
    _userName = userName;
    _accountNumber = accountNumber;
    _bankName = bankName;
    _walletId = walletId;
    _ifscCode = ifscCode;
    notifyListeners();
  }
}
