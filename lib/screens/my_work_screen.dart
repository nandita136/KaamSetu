import 'package:flutter/material.dart';

class MyWorkScreen extends StatefulWidget {
  const MyWorkScreen({super.key});

  @override
  State<MyWorkScreen> createState() => _MyWorkScreenState();
}

class _MyWorkScreenState extends State<MyWorkScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock Data for Active Jobs
  final List<Map<String, dynamic>> _activeJobs = [
    {
      'title': 'Saree Embroidery',
      'employer': 'Meera Handicrafts',
      'status': 'Work in Progress',
      'statusColor': Colors.orange,
      'deadline': 'Due in 2 days',
      'icon': '🪡',
      'action': 'Upload Proof',
    },
    {
      'title': 'Blouse Stitching',
      'employer': 'Sunita Boutique',
      'status': 'Submitted',
      'statusColor': Colors.blue,
      'deadline': 'Awaiting approval',
      'icon': '👗',
      'action': 'View Details',
    },
  ];

  // Mock Data for Completed/Paid Jobs
  final List<Map<String, dynamic>> _completedJobs = [
    {
      'title': 'Pickle Packing (50 Jars)',
      'employer': 'Gujarat Achar House',
      'status': 'Payment Pending',
      'statusColor': Colors.redAccent,
      'amount': '₹450',
      'icon': '🥫',
      'action': 'Remind Employer',
    },
    {
      'title': 'Candle Making (100 pcs)',
      'employer': 'Light & Joy Co.',
      'status': 'Completed & Paid',
      'statusColor': Colors.green,
      'amount': '₹800',
      'icon': '🕯️',
      'action': 'Download Receipt',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Summary Card
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF6B46C1),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6B46C1).withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryItem('Active Jobs', '${_activeJobs.length}', Icons.work_outline),
              Container(width: 1, height: 40, color: Colors.white.withOpacity(0.3)),
              _buildSummaryItem('Pending Pay', '₹450', Icons.account_balance_wallet),
              Container(width: 1, height: 40, color: Colors.white.withOpacity(0.3)),
              _buildSummaryItem('Completed', '${_completedJobs.length}', Icons.check_circle_outline),
            ],
          ),
        ),

        // Tab Bar
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: const Color(0xFF6B46C1),
              borderRadius: BorderRadius.circular(12),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black54,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            tabs: const [
              Tab(text: 'Active Jobs'),
              Tab(text: 'Completed'),
            ],
          ),
        ),

        // Tab Content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildJobList(_activeJobs),
              _buildJobList(_completedJobs),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }

  Widget _buildJobList(List<Map<String, dynamic>> jobs) {
    if (jobs.isEmpty) {
      return const Center(child: Text('No jobs here yet.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        return _buildJobCard(jobs[index]);
      },
    );
  }

  Widget _buildJobCard(Map<String, dynamic> job) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50, height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF6B46C1).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Text(job['icon'], style: const TextStyle(fontSize: 28))),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job['title'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(job['employer'], style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                  ],
                ),
              ),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: job['statusColor'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  job['status'],
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: job['statusColor']),
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.orange),
                  const SizedBox(width: 6),
                  Text(job['deadline'] ?? job['amount'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Action: ${job['action']}')),
                  );
                },
                icon: Icon(
                  job['action'] == 'Upload Proof' ? Icons.camera_alt : Icons.arrow_forward,
                  size: 16,
                ),
                label: Text(job['action'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B46C1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}