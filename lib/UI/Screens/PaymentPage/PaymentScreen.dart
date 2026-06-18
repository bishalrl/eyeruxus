// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:share_plus/share_plus.dart';
//
// class PaymentPage extends StatefulWidget {
//   const PaymentPage({Key? key}) : super(key: key);
//
//   @override
//   State<PaymentPage> createState() => _PaymentPageState();
// }
//
// class _PaymentPageState extends State<PaymentPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _accountController = TextEditingController();
//   String _selectedMethod = "JazzCash";
//
//   final List<Map<String, dynamic>> _transactions = [];
//   final List<String> _savedAccounts = [
//     "03001234567",
//     "PK00TEST123456789",
//   ]; // Favorites
//
//   double _walletBalance = 25000; // Demo balance
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }
//
//   String _generateTxnId() {
//     final rand = Random();
//     return "TXN${rand.nextInt(99999999)}";
//   }
//
//   void _confirmPayment(String type) {
//     final txnId = _generateTxnId();
//     final amount = double.tryParse(_amountController.text) ?? 0;
//
//     showDialog(
//       context: context,
//       builder:
//           (context) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         title: Text("$type Confirmation"),
//         content: Text(
//           "Are you sure you want to $type PKR ${_amountController.text} "
//               "via $_selectedMethod to ${_accountController.text}?\n\nTxn ID: $txnId",
//         ),
//         actions: [
//           TextButton(
//             child: const Text("Cancel"),
//             onPressed: () => Navigator.pop(context),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.indigo,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: const Text("Confirm"),
//             onPressed: () {
//               setState(() {
//                 _transactions.add({
//                   "id": txnId,
//                   "type": type,
//                   "amount": _amountController.text,
//                   "method": _selectedMethod,
//                   "account": _accountController.text,
//                   "time": DateTime.now(),
//                 });
//                 if (type == "Send") _walletBalance -= amount;
//                 if (type == "Receive") _walletBalance += amount;
//               });
//               Navigator.pop(context);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text("$type Successful! Txn ID: $txnId"),
//                   backgroundColor: Colors.green,
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         title: const Text("Payment Gateway"),
//         centerTitle: true,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.indigo, Colors.blueAccent],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: Colors.white,
//           labelColor: Colors.white,
//           unselectedLabelColor: Colors.white70,
//           tabs: const [
//             Tab(icon: Icon(Icons.send), text: "Send"),
//             Tab(icon: Icon(Icons.download), text: "Receive"),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           _buildWalletCard(), // 🔹 Wallet balance on top
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [_buildSendPaymentUI(), _buildReceivePaymentUI()],
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: _buildTransactionHistory(),
//     );
//   }
//
//   /// 🔹 Wallet Card
//   Widget _buildWalletCard() {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Colors.indigo, Colors.blueAccent],
//         ),
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.indigo.withOpacity(0.3),
//             blurRadius: 10,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text(
//             "Wallet Balance",
//             style: TextStyle(color: Colors.white70, fontSize: 16),
//           ),
//           Text(
//             "PKR ${_walletBalance.toStringAsFixed(0)}",
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// 🔹 Send Payment
//   Widget _buildSendPaymentUI() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           _buildPaymentCard("Send Payment", Colors.indigo),
//           const SizedBox(height: 20),
//           _buildGradientButton("Send Payment", Icons.send, Colors.indigo, () {
//             if (_amountController.text.isNotEmpty &&
//                 _accountController.text.isNotEmpty) {
//               _confirmPayment("Send");
//             }
//           }),
//         ],
//       ),
//     );
//   }
//
//   /// 🔹 Receive Payment with QR + Share
//   Widget _buildReceivePaymentUI() {
//     final qrData =
//         "Receive PKR ${_amountController.text} via $_selectedMethod at ${_accountController.text}";
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           _buildPaymentCard("Receive Payment", Colors.green),
//           const SizedBox(height: 20),
//           _buildGradientButton(
//             "Request Payment",
//             Icons.download,
//             Colors.green,
//                 () {
//               if (_amountController.text.isNotEmpty &&
//                   _accountController.text.isNotEmpty) {
//                 _confirmPayment("Receive");
//               }
//             },
//           ),
//           const SizedBox(height: 20),
//           Card(
//             elevation: 5,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   const Text(
//                     "Scan to Pay",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.indigo,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   QrImageView(
//                     data: qrData,
//                     size: 200,
//                     backgroundColor: Colors.white,
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ElevatedButton.icon(
//                         onPressed: () {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text("Account copied!")),
//                           );
//                         },
//                         icon: const Icon(Icons.copy),
//                         label: const Text("Copy"),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.indigo,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//                       ElevatedButton.icon(
//                         onPressed: () {
//                           Share.share(qrData);
//                         },
//                         icon: const Icon(Icons.share),
//                         label: const Text("Share"),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.green,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// 🔹 Payment Card
//   Widget _buildPaymentCard(String title, Color color) {
//     return Card(
//       elevation: 8,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: color,
//               ),
//             ),
//             const SizedBox(height: 20),
//             _buildTextField(
//               _amountController,
//               "Amount (PKR)",
//               Icons.currency_rupee,
//               TextInputType.number,
//             ),
//             const SizedBox(height: 15),
//             _buildTextField(
//               _accountController,
//               "Account Number / Mobile",
//               Icons.account_balance_wallet,
//               TextInputType.text,
//             ),
//             const SizedBox(height: 15),
//             DropdownButtonFormField<String>(
//               value: _selectedMethod,
//               decoration: const InputDecoration(
//                 labelText: "Select Method",
//                 border: OutlineInputBorder(),
//               ),
//               items:
//               ["JazzCash", "Easypaisa", "Bank Transfer"]
//                   .map(
//                     (method) => DropdownMenuItem(
//                   value: method,
//                   child: Row(
//                     children: [
//                       const Icon(Icons.payment, color: Colors.indigo),
//                       const SizedBox(width: 8),
//                       Text(method),
//                     ],
//                   ),
//                 ),
//               )
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedMethod = value!;
//                 });
//               },
//             ),
//             const SizedBox(height: 15),
//             Wrap(
//               spacing: 8,
//               children:
//               _savedAccounts
//                   .map(
//                     (acc) => ActionChip(
//                   label: Text(acc),
//                   avatar: const Icon(Icons.history, size: 18),
//                   onPressed: () {
//                     _accountController.text = acc;
//                   },
//                 ),
//               )
//                   .toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// 🔹 TextField
//   Widget _buildTextField(
//       TextEditingController controller,
//       String label,
//       IconData icon,
//       TextInputType type,
//       ) {
//     return TextField(
//       controller: controller,
//       keyboardType: type,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon, color: Colors.indigo),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//     );
//   }
//
//   /// 🔹 Gradient Button
//   Widget _buildGradientButton(
//       String text,
//       IconData icon,
//       Color color,
//       VoidCallback onPressed,
//       ) {
//     return ElevatedButton.icon(
//       onPressed: onPressed,
//       icon: Icon(icon, color: Colors.white),
//       label: Text(text),
//       style: ElevatedButton.styleFrom(
//         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
//         backgroundColor: color,
//         foregroundColor: Colors.white,
//         minimumSize: const Size(double.infinity, 55),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//         elevation: 4,
//       ),
//     );
//   }
//
//   /// 🔹 Transaction History
//   Widget _buildTransactionHistory() {
//     return Container(
//       height: 180,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 6,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child:
//       _transactions.isEmpty
//           ? const Center(
//         child: Text(
//           "No transactions yet",
//           style: TextStyle(color: Colors.grey),
//         ),
//       )
//           : ListView.builder(
//         itemCount: _transactions.length,
//         itemBuilder: (context, index) {
//           final tx = _transactions[index];
//           return ListTile(
//             leading: CircleAvatar(
//               backgroundColor:
//               tx["type"] == "Send" ? Colors.red : Colors.green,
//               child: Icon(
//                 tx["type"] == "Send"
//                     ? Icons.arrow_upward
//                     : Icons.arrow_downward,
//                 color: Colors.white,
//               ),
//             ),
//             title: Text(
//               "${tx["type"]} PKR ${tx["amount"]} via ${tx["method"]}",
//               style: const TextStyle(fontWeight: FontWeight.w600),
//             ),
//             subtitle: Text(
//               "To/From: ${tx["account"]}\nTxn ID: ${tx["id"]}",
//             ),
//             trailing: Text(
//               "${tx["time"].hour}:${tx["time"].minute.toString().padLeft(2, '0')}",
//               style: const TextStyle(fontSize: 12, color: Colors.grey),
//             ),
//             onTap: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text("Txn ID copied: ${tx["id"]}")),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }