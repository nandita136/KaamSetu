import 'package:flutter/material.dart';
import 'login_screen.dart';

class EmployerProfileScreen extends StatelessWidget {
  const EmployerProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
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
              children: [
                Container(
                  width: 90, height: 90,
                  decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 4)),
                  child: const Center(child: Text('🏪', style: TextStyle(fontSize: 45))),
                ),
                const SizedBox(height: 16),
                const Text('Sunita Boutique', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.verified, color: Colors.white, size: 16),
                          SizedBox(width: 6),
                          Text('KYC Verified', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildStatCard('12', 'Active Jobs', Icons.business_center),
                const SizedBox(width: 12),
                _buildStatCard('45', 'Workers Hired', Icons.people),
                const SizedBox(width: 12),
                _buildStatCard('4.9', 'Rating', Icons.star),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Settings Menu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Text('Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
          ),
          const SizedBox(height: 12),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))]),
            child: Column(
              children: [
                _buildMenuItem(Icons.business, 'Edit Business Details', 'Sunita Boutique', () {}),
                const Divider(height: 1, indent: 60),
                _buildMenuItem(Icons.payment, 'Payment Methods', 'UPI: 9876543210@upi', () {}),
                const Divider(height: 1, indent: 60),
                _buildMenuItem(Icons.help_outline, 'Help & Support', 'Contact Admin', () {}),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Logout
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text('Logout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red, width: 1.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))]),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF6B46C1), size: 24),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF6B46C1), size: 24),
      title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}