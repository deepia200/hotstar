import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyIncomeScreen extends StatelessWidget {
  const MyIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double totalAdded = 15000.0;
    final double totalSpent = 6000.0;
    final double currentBalance = totalAdded - totalSpent;

    final List<Map<String, dynamic>> transactions = [
      {
        'date': '2025-05-01',
        'type': 'Credit',
        'description': 'Wallet Top-Up',
        'amount': 5000.0,
      },
      {
        'date': '2025-05-03',
        'type': 'Debit',
        'description': 'Movie Purchase',
        'amount': 2000.0,
      },
      {
        'date': '2025-05-06',
        'type': 'Credit',
        'description': 'Referral Bonus',
        'amount': 3000.0,
      },
      {
        'date': '2025-05-08',
        'type': 'Debit',
        'description': 'OTT Subscription',
        'amount': 4000.0,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallet Details',
          style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWalletSummary(currentBalance, totalAdded, totalSpent),
            const SizedBox(height: 20),
            Text(
              'Transaction History',
              style: GoogleFonts.roboto(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return _buildTransactionCard(transactions[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletSummary(double balance, double added, double spent) {
    return Column(
      children: [
        _buildSummaryRow('Current Balance', balance, Colors.green),
        const SizedBox(height: 8),
        _buildSummaryRow('Total Added', added, Colors.blue),
        const SizedBox(height: 8),
        _buildSummaryRow('Total Spent', spent, Colors.red),
      ],
    );
  }

  Widget _buildSummaryRow(String label, double amount, Color color) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
          ),
          Text(
            '₹${amount.toStringAsFixed(2)}',
            style: GoogleFonts.roboto(color: color, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> txn) {
    final isCredit = txn['type'] == 'Credit';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Card(
        color: Colors.grey[850],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    txn['description'],
                    style: GoogleFonts.roboto(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    txn['date'],
                    style: GoogleFonts.roboto(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
              Text(
                '${isCredit ? '+' : '-'}₹${txn['amount'].toStringAsFixed(2)}',
                style: GoogleFonts.roboto(
                  color: isCredit ? Colors.green : Colors.red,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
