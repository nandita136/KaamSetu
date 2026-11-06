import 'package:flutter/material.dart';
class EmployerApplicantsScreen extends StatelessWidget {
   EmployerApplicantsScreen({Key? key}) : super(key: key);

  // Mock Data for Applicants
  final List<Map<String, dynamic>> _applicants = [
    {
      'name': 'Savita Ben',
      'job': 'Blouse Stitching',
      'rating': 4.8,
      'jobsDone': 12,
      'status': 'Pending',
      'icon': '👩',
    },
    {
      'name': 'Meera Ben',
      'job': 'Saree Embroidery',
      'rating': 4.9,
      'jobsDone': 25,
      'status': 'Accepted',
      'icon': '👩‍🦱',
    },
    {
      'name': 'Kamla Ben',
      'job': 'Pickle Packing',
      'rating': 4.5,
      'jobsDone': 8,
      'status': 'Pending',
      'icon': '👵',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6B46C1), Color(0xFF9F7AEA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Applicants',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Workers who applied to your jobs',
                style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.9)),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Applicants List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _applicants.length,
            itemBuilder: (context, index) {
              return _buildApplicantCard(_applicants[index], context);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildApplicantCard(Map<String, dynamic> applicant, BuildContext context) {
    bool isPending = applicant['status'] == 'Pending';
    bool isAccepted = applicant['status'] == 'Accepted';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
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
                child: Center(child: Text(applicant['icon'], style: const TextStyle(fontSize: 28))),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(applicant['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('Applied for: ${applicant['job']}', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  ],
                ),
              ),
              if (isAccepted)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                  child: const Text('Accepted', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.green)),
                ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Stats Row
          Row(
            children: [
              _buildMiniStat(Icons.star, '${applicant['rating']}', Colors.amber),
              const SizedBox(width: 16),
              _buildMiniStat(Icons.work, '${applicant['jobsDone']} jobs', Colors.blue),
            ],
          ),

          if (isPending) ...[
            const Divider(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Rejected ${applicant['name']}')));
                    },
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
                    child: const Text('Reject'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Accepted ${applicant['name']}!'), backgroundColor: const Color(0xFF10B981)));
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981)),
                    child: const Text('Accept'),
                  ),
                ),
              ],
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildMiniStat(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
      ],
    );
  }
}