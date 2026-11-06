import 'package:flutter/material.dart';

class ReviewWorkScreen extends StatefulWidget {
  // Mock data passed from the dashboard
  final Map<String, dynamic> jobData;

  const ReviewWorkScreen({Key? key, required this.jobData}) : super(key: key);

  @override
  State<ReviewWorkScreen> createState() => _ReviewWorkScreenState();
}

class _ReviewWorkScreenState extends State<ReviewWorkScreen> {
  bool _isApproved = false;
  bool _isPaid = false;

  @override
  Widget build(BuildContext context) {
    final String title = widget.jobData['title'] ?? 'Job Title';
    final String worker = widget.jobData['worker'] ?? 'Worker Name';
    final String pay = widget.jobData['pay'] ?? '₹0';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
        title: const Text(
          'Review Submission',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Job & Worker Info Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50, height: 50,
                        decoration: BoxDecoration(color: const Color(0xFF6B46C1).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                        child: Center(child: Text(widget.jobData['icon'] ?? '📦', style: const TextStyle(fontSize: 24))),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                            const SizedBox(height: 4),
                            Text('Submitted by: $worker', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Amount to Pay', style: TextStyle(fontSize: 14, color: Colors.grey)),
                      Text(pay, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF6B46C1))),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 2. Work Proof (Mock Images)
            const Text('Work Proof (Uploaded by Worker)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3, // Mock 3 photos
                itemBuilder: (context, index) {
                  return Container(
                    width: 120,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, color: Colors.grey.shade500, size: 32),
                        const SizedBox(height: 8),
                        Text('Photo ${index + 1}', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // 3. Quality Check Section
            const Text('Quality Check', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isApproved ? const Color(0xFF10B981).withOpacity(0.1) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _isApproved ? const Color(0xFF10B981) : Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Icon(_isApproved ? Icons.check_circle : Icons.help_outline, color: _isApproved ? const Color(0xFF10B981) : Colors.orange, size: 28),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      _isApproved ? 'Work approved successfully!' : 'Is the work completed satisfactorily?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        color: _isApproved ? const Color(0xFF10B981) : Colors.black87
                      ),
                    ),
                  ),
                  if (!_isApproved)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isApproved = true;
                        });
                      },
                      child: const Text('Approve', style: TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.bold)),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 4. Action Buttons
            if (!_isApproved)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showReworkDialog(context);
                  },
                  icon: const Icon(Icons.refresh, color: Colors.orange),
                  label: const Text('Request Rework', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.orange, width: 1.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                ),
              ),
            
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _isApproved ? () => _showPaymentDialog(context, pay) : null,
                icon: const Icon(Icons.payment, color: Colors.white),
                label: Text(
                  _isPaid ? 'Payment Completed' : 'Mark as Paid & Complete', 
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isPaid ? Colors.green : const Color(0xFF6B46C1),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Dialog for Rework
  void _showReworkDialog(BuildContext context) {
    final TextEditingController _remarkController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Request Rework', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Tell the worker what needs to be fixed:'),
            const SizedBox(height: 16),
            TextField(
              controller: _remarkController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'e.g., Stitching is loose on the left sleeve...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
                const SnackBar(content: Text('Rework request sent to worker!'), backgroundColor: Colors.orange),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Send Request'),
          ),
        ],
      ),
    );
  }

  // Dialog for Payment
  void _showPaymentDialog(BuildContext context, String amount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Confirm Payment', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text('Are you sure you want to release $amount to ${widget.jobData['worker']} via UPI?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _isPaid = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment Successful! Job Completed.'), backgroundColor: Color(0xFF10B981)),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981)),
            child: const Text('Confirm & Pay'),
          ),
        ],
      ),
    );
  }
}