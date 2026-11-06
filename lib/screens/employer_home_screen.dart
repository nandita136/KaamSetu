import 'package:flutter/material.dart';
import 'post_job_screen.dart'; 
import 'review_work_screen.dart';
import 'employer_applicants_screen.dart';
import 'employer_profile_screen.dart';


class EmployerHomeScreen extends StatefulWidget {
  const EmployerHomeScreen({Key? key}) : super(key: key);

  @override
  State<EmployerHomeScreen> createState() => _EmployerHomeScreenState();
}

class _EmployerHomeScreenState extends State<EmployerHomeScreen> {
  int _selectedIndex = 0;

  // Mock Data for Employer's Jobs
  final List<Map<String, dynamic>> _myJobs = [
    {
      'title': 'Saree Embroidery (10 pcs)',
      'worker': 'Meera Ben',
      'deadline': 'Nov 10, 2026',
      'pay': '₹6,000',
      'status': 'Work in Progress',
      'statusColor': Colors.orange,
      'icon': '🪡',
    },
    {
      'title': 'Blouse Stitching (5 pcs)',
      'worker': 'Savita Ben',
      'deadline': 'Nov 08, 2026',
      'pay': '₹1,500',
      'status': 'Submitted (Review)',
      'statusColor': Colors.blue,
      'icon': '👗',
    },
    {
      'title': 'Pickle Packing (50 Jars)',
      'worker': 'Kamla Ben',
      'deadline': 'Nov 05, 2026',
      'pay': '₹450',
      'status': 'Completed',
      'statusColor': Colors.green,
      'icon': '🥫',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      
      // Floating Action Button for Quick Job Posting
      floatingActionButton: _selectedIndex == 0 
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PostJobScreen()),
                );
              },
              backgroundColor: const Color(0xFF6B46C1),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Post New Job', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ) 
          : null,
          
      // The Main Body Content
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                _buildDashboardBody(),
                EmployerApplicantsScreen(), 
                EmployerProfileScreen(),    
              ],
            ),
          ),
        ],
      ),
      
      // ✅ THIS IS THE LINE THAT BRINGS BACK THE BOTTOM NAVIGATION!
      bottomNavigationBar: _buildBottomNav(), 
    );
  }

  // ==========================================
  // DASHBOARD BODY CONTENT
  // ==========================================
  Widget _buildDashboardBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header Section
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome back! 👋',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Sunita Boutique',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.notifications, color: Colors.white, size: 24),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 2. Stats Cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildStatCard('3', 'Active Jobs', Icons.business_center, Colors.orange),
                const SizedBox(width: 12),
                _buildStatCard('₹450', 'Pending Pay', Icons.payment, Colors.redAccent),
                const SizedBox(width: 12),
                _buildStatCard('12', 'Completed', Icons.check_circle, Colors.green),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // 3. My Jobs Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Job Postings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All', style: TextStyle(color: Color(0xFF6B46C1))),
                ),
              ],
            ),
          ),

          // Job List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _myJobs.length,
              itemBuilder: (context, index) {
                return _buildJobCard(_myJobs[index]);
              },
            ),
          ),
          const SizedBox(height: 100), // Space for FAB
        ],
      ),
    );
  }

  // ==========================================
  // REUSABLE WIDGETS
  // ==========================================
  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCard(Map<String, dynamic> job) {
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
                width: 45, height: 45,
                decoration: BoxDecoration(color: const Color(0xFF6B46C1).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text(job['icon'], style: const TextStyle(fontSize: 24))),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job['title'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 4),
                    Text('Assigned to: ${job['worker']}', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: job['statusColor'].withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                child: Text(job['status'], style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: job['statusColor'])),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(job['deadline'], style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                ],
              ),
              Text(job['pay'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF6B46C1))),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
               onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewWorkScreen(jobData: job), 
                    ),
                  );
                },
              style: ElevatedButton.styleFrom(
                backgroundColor: job['status'] == 'Completed' ? Colors.green : const Color(0xFF6B46C1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: Text(
                job['status'] == 'Completed' ? 'View Receipt' : (job['status'] == 'Submitted (Review)' ? 'Review Work' : 'Track Progress'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))]),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF6B46C1),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: 'Applicants'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildPlaceholderPage(int index) {
    final titles = ['Applicants', 'Profile'];
    final icons = [Icons.people, Icons.person];
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icons[index - 1], size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 20),
          Text('${titles[index - 1]} Screen', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey.shade600)),
          const SizedBox(height: 10),
          Text('Coming in the next step!', style: TextStyle(fontSize: 16, color: Colors.grey.shade500)),
        ],
      ),
    );
  }
}