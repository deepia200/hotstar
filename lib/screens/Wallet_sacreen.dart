import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/wallet_provider.dart';

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
    bankController.text = wallet.bankName;
    accountController.text = wallet.accountNumber;
    walletIdController.text = wallet.walletId;
    ifscController.text = wallet.ifscCode;
  }

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text('Wallet Card', style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20),),
          backgroundColor: Colors.black,
          centerTitle: true,
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
                    // Wallet Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1A1F71), Color(0xFF3A4750)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            offset: const Offset(0, 6),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Bank name & icon
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                wallet.bankName,
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const Icon(Icons.credit_card, color: Colors.white54),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Account number
                          Text(
                            "**** **** **** ${wallet.accountNumber.substring(wallet.accountNumber.length - 4)}",
                            style: GoogleFonts.robotoMono(
                              color: Colors.white,
                              fontSize: 22,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Wallet ID & IFSC
                          Text("Wallet ID: ${wallet.walletId}",
                              style: GoogleFonts.roboto(
                                  color: Colors.white70, fontSize: 12)),
                          Text("IFSC Code: ${wallet.ifscCode}",
                              style: GoogleFonts.roboto(
                                  color: Colors.white70, fontSize: 12)),
                          const SizedBox(height: 16),
                          // Card holder & balance
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("CARD HOLDER",
                                      style: TextStyle(
                                          color: Colors.white60, fontSize: 10)),
                                  Text(wallet.userName,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text("BALANCE",
                                      style: TextStyle(
                                          color: Colors.white60, fontSize: 10)),
                                  Text("₹${wallet.balance.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Editable fields
                    buildEditField("Name", nameController),
                    buildEditField("Bank Name", bankController),
                    buildEditField("Account Number", accountController),
                    buildEditField("Wallet ID", walletIdController),
                    buildEditField("IFSC Code", ifscController),

                    // Save button
                    // Save button with gradient
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.blueAccent, Colors.pinkAccent],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            wallet.updateWalletInfo(
                              userName: nameController.text,
                              accountNumber: accountController.text,
                              bankName: bankController.text,
                              walletId: walletIdController.text,
                              ifscCode: ifscController.text,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Wallet Info Updated")),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text(
                            "Save Changes",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),


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
