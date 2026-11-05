import 'package:flutter/material.dart';
import 'my_work_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Mock Data for Skill Match (Recommended Jobs)
  final List<Map<String, dynamic>> _recommendedJobs = [
    {
      'title': 'Blouse Stitching',
      'employer': 'Sunita Boutique',
      'location': 'Rajkot (2 km away)',
      'pay': '₹300',
      'time': '2 days',
      'skill': 'Stitching',
      'icon': '👗',
      'material': true,
    },
    {
      'title': 'Saree Embroidery',
      'employer': 'Meera Handicrafts',
      'location': 'Material delivered to home',
      'pay': '₹600',
      'time': '5 days',
      'skill': 'Embroidery',
      'icon': '🪡',
      'material': true,
    },
  ];

  // Mock Data for All Jobs
  final List<Map<String, dynamic>> _allJobs = [
    {
      'title': 'Pickle Packing (50 Jars)',
      'employer': 'Gujarat Achar House',
      'location': 'Village Center',
      'pay': '₹450',
      'time': '3 days',
      'skill': 'Packaging',
      'icon': '🥫',
      'material': false,
    },
    {
      'title': 'Candle Making (100 pcs)',
      'employer': 'Light & Joy Co.',
      'location': 'Home based',
      'pay': '₹800',
      'time': '7 days',
      'skill': 'Candle Making',
      'icon': '🕯️',
      'material': true,
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
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                _buildHomeBody(),
                const MyWorkScreen(), // <-- THIS IS THE FIX!
                _buildPlaceholderPage(2),
                _buildPlaceholderPage(3),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ==========================================
  // HOME BODY CONTENT
  // ==========================================
  Widget _buildHomeBody() {
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
                      'Namaste, Ben! 👋',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.white70, size: 18),
                        Text(
                          'Village A, Rajkot',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.notifications, color: Colors.white, size: 24),
                    ),
                    Positioned(
                      right: 8, top: 8,
                      child: Container(
                        width: 10, height: 10,
                        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 2. Skill Match Section (The Unique Feature!)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '⭐ Recommended for You',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('See all', style: TextStyle(color: Color(0xFF6B46C1))),
                ),
              ],
            ),
          ),

          // Horizontal Scroll for Recommended Jobs
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _recommendedJobs.length,
              itemBuilder: (context, index) {
                return _buildJobCard(_recommendedJobs[index], isRecommended: true);
              },
            ),
          ),

          const SizedBox(height: 24),

          // 3. All Available Jobs Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'All Available Jobs',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list, color: Color(0xFF6B46C1)),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Vertical List for All Jobs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _allJobs.length,
              itemBuilder: (context, index) {
                return _buildJobCard(_allJobs[index], isRecommended: false);
              },
            ),
          ),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ==========================================
  // REUSABLE JOB CARD WIDGET
  // ==========================================
  Widget _buildJobCard(Map<String, dynamic> job, {required bool isRecommended}) {
    return Container(
      width: isRecommended ? 260 : double.infinity,
      margin: EdgeInsets.only(right: isRecommended ? 16 : 0, bottom: isRecommended ? 0 : 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isRecommended 
            ? Border.all(color: const Color(0xFF6B46C1), width: 2) 
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Icon + Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 45, height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xFF6B46C1).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Text(job['icon'], style: const TextStyle(fontSize: 24))),
              ),
              if (isRecommended)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6B46C1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Skill Match',
                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Title & Employer
          Text(
            job['title'],
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            job['employer'],
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 12),

          // Details Row (Location, Pay, Time)
          Row(
            children: [
              _buildDetailChip(Icons.location_on, job['location'], Colors.blue),
              const SizedBox(width: 8),
              _buildDetailChip(Icons.access_time, job['time'], Colors.orange),
            ],
          ),
          const SizedBox(height: 12),

          // Pay & Apply Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                job['pay'],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF10B981)),
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Applied for ${job['title']}!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B46C1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text('Apply', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailChip(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500)),
      ],
    );
  }

  // ==========================================
  // BOTTOM NAVIGATION BAR
  // ==========================================
  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5)),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF6B46C1),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.work_outline), label: 'My Work'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Payments'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  // ==========================================
  // PLACEHOLDER PAGES FOR OTHER TABS
  // ==========================================
  Widget _buildPlaceholderPage(int index) {
    final titles = ['Payments', 'Profile'];
    final icons = [Icons.account_balance_wallet, Icons.person];
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icons[index - 2], size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 20),
          Text(
            '${titles[index - 2]} Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 10),
          Text(
            'Coming in the next step!',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}