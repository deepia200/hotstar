import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotstar/provider/wallet_provider.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int selectedTab = 0;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController bankController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final TextEditingController walletIdController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final wallet = Provider.of<WalletProvider>(context, listen: false);
    nameController.text = wallet.userName;
    bankController.text = "Digital Bank of Flutter";
    accountController.text = wallet.accountNumber;
    walletIdController.text = "WLT-${wallet.accountNumber.substring(0, 4)}XXXX";
    ifscController.text = "DIGI0001234";
  }

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 130),
            child: Text('Wallet',
              style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: selectedTab == 0
                  ? SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.indigo, Colors.green],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(bankController.text,
                              style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          Text("Name: ${wallet.userName}",
                              style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text("Account No: ${wallet.accountNumber}",
                              style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text("Wallet ID: WLT-${wallet.accountNumber.substring(0, 4)}XXXX",
                              style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text("IFSC Code: DIGI0001234",
                              style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("₹${wallet.balance.toStringAsFixed(2)}",
                                  style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    buildEditField("Name", nameController),
                    buildEditField("Bank Name", bankController),
                    buildEditField("Account Number", accountController),
                    buildEditField("Wallet ID", walletIdController),
                    buildEditField("IFSC Code", ifscController),
                  ],
                ),
              )
                  : Padding(
                padding: const EdgeInsets.all(16.0),
                child: wallet.transactions.isEmpty
                    ? const Center(
                  child: Text(
                    "No transactions yet",
                    style: TextStyle(color: Colors.white70),
                  ),
                )
                    : ListView.builder(
                  itemCount: wallet.transactions.length,
                  itemBuilder: (context, index) {
                    final tx = wallet.transactions[index];
                    return ListTile(
                      title: Text(tx.title,
                          style: GoogleFonts.roboto(color: Colors.white)),
                      subtitle: Text(
                          "${tx.date.day}/${tx.date.month}/${tx.date.year}",
                          style: GoogleFonts.roboto(color: Colors.white70)),
                      trailing: Text("₹${tx.amount.toStringAsFixed(2)}",
                          style: GoogleFonts.roboto(color: Colors.white)),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedTab,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.white70,
          onTap: (index) {
            setState(() {
              selectedTab = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet), label: "Wallet"),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: "Transactions"),
          ],
        ),
      ),
    );
  }

  Widget buildEditField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white24),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
