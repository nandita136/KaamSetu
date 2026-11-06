import 'package:flutter/material.dart';

class PaymentsScreen extends StatelessWidget {
  PaymentsScreen({super.key});

  // Mock Transaction Data
  final List<Map<String, dynamic>> _transactions = [
    {
      'job': 'Candle Making (100 pcs)',
      'employer': 'Light & Joy Co.',
      'date': '02 Nov 2026',
      'amount': '₹800',
      'status': 'Completed',
      'statusColor': Colors.green,
      'icon': '🕯️',
    },
    {
      'job': 'Pickle Packing (50 Jars)',
      'employer': 'Gujarat Achar House',
      'date': '28 Oct 2026',
      'amount': '₹450',
      'status': 'Pending',
      'statusColor': Colors.orange,
      'icon': '🥫',
    },
    {
      'job': 'Blouse Stitching',
      'employer': 'Sunita Boutique',
      'date': '15 Oct 2026',
      'amount': '₹300',
      'status': 'Completed',
      'statusColor': Colors.green,
      'icon': '👗',
    },
    {
      'job': 'Saree Embroidery',
      'employer': 'Meera Handicrafts',
      'date': '01 Oct 2026',
      'amount': '₹600',
      'status': 'Disputed',
      'statusColor': Colors.redAccent,
      'icon': '🪡',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Total Earnings Card
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF10B981), Color(0xFF34D399)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF10B981).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Earnings',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 8),
                const Text(
                  '₹2,150',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _showWithdrawDialog(context);
                        },
                        icon: const Icon(Icons.account_balance_wallet, size: 18),
                        label: const Text('Withdraw'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF10B981),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('UPI Settings opened')),
                          );
                        },
                        icon: const Icon(Icons.payment, size: 18),
                        label: const Text('UPI ID'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 2. Transaction History Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All', style: TextStyle(color: Color(0xFF6B46C1))),
                ),
              ],
            ),
          ),

          // 3. Transaction List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                return _buildTransactionCard(_transactions[index]);
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> txn) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 50, height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF6B46C1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Text(txn['icon'], style: const TextStyle(fontSize: 26))),
          ),
          const SizedBox(width: 16),
          
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(txn['job'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 4),
                Text(txn['employer'], style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 12, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(txn['date'], style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: txn['statusColor'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        txn['status'],
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: txn['statusColor']),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Amount
          Text(
            txn['amount'],
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold, 
              color: txn['status'] == 'Completed' ? const Color(0xFF10B981) : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void _showWithdrawDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Withdraw Money', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Available Balance: ₹2,150'),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                prefixText: '₹ ',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.payment, color: Color(0xFF6B46C1)),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('UPI ID', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                      const Text('9876543210@upi', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Withdrawal request sent! (Mock)')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981)),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}