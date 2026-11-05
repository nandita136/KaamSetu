import 'package:flutter/material.dart';
import 'home_screen.dart'; // We will create this next

class SkillSelectionScreen extends StatefulWidget {
  const SkillSelectionScreen({super.key});

  @override
  State<SkillSelectionScreen> createState() => _SkillSelectionScreenState();
}

class _SkillSelectionScreenState extends State<SkillSelectionScreen> {
  final Set<String> _selectedSkills = {};

  // Skill Data Model
  final List<Map<String, String>> _skills = [
    {'id': 'stitching', 'name': 'Stitching / Tailoring', 'icon': '🧵'},
    {'id': 'embroidery', 'name': 'Embroidery', 'icon': '🪡'},
    {'id': 'food', 'name': 'Homemade Food', 'icon': '🍱'},
    {'id': 'pickle', 'name': 'Pickle / Papad Making', 'icon': '🥫'},
    {'id': 'candle', 'name': 'Candle Making', 'icon': '🕯️'},
    {'id': 'packaging', 'name': 'Packaging Work', 'icon': '📦'},
    {'id': 'handicraft', 'name': 'Handicrafts', 'icon': '🧶'},
    {'id': 'agri', 'name': 'Agriculture Home Work', 'icon': '🌾'},
    {'id': 'data', 'name': 'Data Entry / Online', 'icon': '💻'},
    {'id': 'alteration', 'name': 'Clothes Alteration', 'icon': '👗'},
  ];

  void _toggleSkill(String id) {
    setState(() {
      if (_selectedSkills.contains(id)) {
        _selectedSkills.remove(id);
      } else {
        _selectedSkills.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
        title: const Text(
          'Select Your Skills', 
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: [
          // Voice Input Feature (Visual representation)
          IconButton(
            icon: const Icon(Icons.mic, color: Color(0xFF6B46C1)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('🎤 Voice input feature will open here!')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: const LinearProgressIndicator(
              value: 0.66, // Step 2 of 3
              backgroundColor: Color(0xFFE9D5FF),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6B46C1)),
              minHeight: 8,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'What work can you do from home?\n(Tap to select multiple)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),

          // Skills Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemCount: _skills.length,
                itemBuilder: (context, index) {
                  final skill = _skills[index];
                  final isSelected = _selectedSkills.contains(skill['id']);
                  return _SkillCard(
                    icon: skill['icon']!,
                    name: skill['name']!,
                    isSelected: isSelected,
                    onTap: () => _toggleSkill(skill['id']!),
                  );
                },
              ),
            ),
          ),

          // Bottom Continue Button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05), 
                  blurRadius: 10, 
                  offset: const Offset(0, -5)
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _selectedSkills.isEmpty
                    ? null // Disabled if no skill selected
                    : () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B46C1),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                  disabledForegroundColor: Colors.grey.shade500,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
                child: Text(
                  _selectedSkills.isEmpty 
                      ? 'Select at least 1 skill' 
                      : 'Continue with ${_selectedSkills.length} skill${_selectedSkills.length > 1 ? 's' : ''} →',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  final String icon, name;
  final bool isSelected;
  final VoidCallback onTap;

  const _SkillCard({
    required this.icon, 
    required this.name,
    required this.isSelected, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6B46C1).withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF6B46C1) : Colors.grey.shade200,
            width: isSelected ? 3 : 1,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: const Color(0xFF6B46C1).withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))]
              : [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5, offset: const Offset(0, 2))],
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(icon, style: const TextStyle(fontSize: 40)),
                const SizedBox(height: 12),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? const Color(0xFF6B46C1) : Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            if (isSelected)
              Positioned(
                top: 0, right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFF6B46C1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}