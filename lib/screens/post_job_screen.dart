import 'package:flutter/material.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({Key? key}) : super(key: key);

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();

  // State variables
  String _selectedSkill = 'Stitching / Tailoring';
  DateTime? _selectedDeadline;
  bool _willDeliverMaterial = true;

  final List<String> _skills = [
    'Stitching / Tailoring',
    'Embroidery',
    'Homemade Food',
    'Pickle / Papad Making',
    'Candle Making',
    'Packaging Work',
    'Handicrafts',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF6B46C1), // Purple theme
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDeadline) {
      setState(() {
        _selectedDeadline = picked;
      });
    }
  }

  void _submitJob() {
    if (_formKey.currentState!.validate() && _selectedDeadline != null) {
      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              SizedBox(width: 12),
              Text('Job Posted!'),
            ],
          ),
          content: const Text(
            'Your job has been posted successfully. Workers matching these skills will be notified shortly.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to Dashboard
              },
              child: const Text(
                'Go to Dashboard',
                style: TextStyle(color: Color(0xFF6B46C1), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    } else if (_selectedDeadline == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a deadline date')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
        title: const Text(
          'Post a New Job',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // 1. Job Title
            _buildSectionTitle('Job Title'),
            TextFormField(
              controller: _titleController,
              decoration: _inputDecoration('e.g., Blouse Stitching (50 pcs)', Icons.title),
              validator: (value) => value!.isEmpty ? 'Please enter a job title' : null,
            ),
            const SizedBox(height: 20),

            // 2. Description
            _buildSectionTitle('Description'),
            TextFormField(
              controller: _descController,
              maxLines: 3,
              decoration: _inputDecoration('Describe the work in detail...', Icons.description),
              validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
            ),
            const SizedBox(height: 20),

            // 3. Required Skill & Quantity (Row)
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Required Skill'),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedSkill,
                            isExpanded: true,
                            items: _skills.map((String skill) {
                              return DropdownMenuItem(value: skill, child: Text(skill));
                            }).toList(),
                            onChanged: (value) => setState(() => _selectedSkill = value!),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Quantity'),
                      TextFormField(
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration('e.g., 50', Icons.numbers),
                        validator: (value) => value!.isEmpty ? 'Req.' : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 4. Rate per Unit
            _buildSectionTitle('Rate per Unit (₹)'),
            TextFormField(
              controller: _rateController,
              keyboardType: TextInputType.number,
              decoration: _inputDecoration('e.g., 300', Icons.currency_rupee),
              validator: (value) => value!.isEmpty ? 'Please enter rate' : null,
            ),
            const SizedBox(height: 20),

            // 5. Deadline
            _buildSectionTitle('Deadline Date'),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _selectedDeadline != null ? const Color(0xFF6B46C1) : Colors.grey.shade300, width: _selectedDeadline != null ? 2 : 1),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Color(0xFF6B46C1)),
                    const SizedBox(width: 12),
                    Text(
                      _selectedDeadline != null 
                          ? '${_selectedDeadline!.day}/${_selectedDeadline!.month}/${_selectedDeadline!.year}' 
                          : 'Select Deadline Date',
                      style: TextStyle(
                        color: _selectedDeadline != null ? const Color(0xFF6B46C1) : Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 6. Material Delivery Switch
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('I will deliver materials to their home', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(_willDeliverMaterial ? 'Yes, I will drop off and pick up materials.' : 'No, workers must come to my shop.', style: TextStyle(color: Colors.grey.shade600)),
                value: _willDeliverMaterial,
                activeColor: const Color(0xFF6B46C1),
                onChanged: (bool value) {
                  setState(() {
                    _willDeliverMaterial = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 30),

            // 7. Submit Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _submitJob,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B46C1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
                child: const Text('Post Job Now', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper for section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
    );
  }

  // Helper for input decoration
  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color(0xFF6B46C1)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF6B46C1), width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }
}