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

  String userName = "John Doe";
  String accountNumber = "1234 5678 9012";

  double get balance => _balance;
  List<Transaction> get transactions => _transactions;

  void addMoney(double amount, String title) {
    _balance += amount;
    _transactions.insert(0, Transaction(
      title: title,
      amount: amount,
      date: DateTime.now(),
    ));
    notifyListeners();
  }

  void resetWallet() {
    _balance = 0.0;
    _transactions.clear();
    notifyListeners();
  }
}
