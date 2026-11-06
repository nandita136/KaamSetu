import 'package:flutter/material.dart';
import 'skill_selection_screen.dart';
import 'employer_onboarding_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  
  bool _isOtpSent = false;
  bool _isLoading = false;

  // Mock OTP for demo purposes
  final String _mockOtp = "1234"; 

  void _sendOtp() {
    if (_phoneController.text.length == 10) {
      setState(() {
        _isLoading = true;
      });

      // Simulate network delay
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _isOtpSent = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('OTP sent to ${_phoneController.text}.\nDemo OTP is: 1234'),
              backgroundColor: const Color(0xFF6B46C1),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 10-digit mobile number')),
      );
    }
  }

    void _verifyOtp() {
    if (_otpController.text == _mockOtp) {
      // MOCK LOGIC: For demo, let's say phone number ending in '00' is an employer
      bool isEmployer = _phoneController.text.endsWith('00'); 

      if (isEmployer) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const EmployerOnboardingScreen()),
        );
      } else {
        // Default to worker
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SkillSelectionScreen()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid OTP. Please try 1234 for demo.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Back Button
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
                onPressed: () => Navigator.pop(context),
              ),
              
              const SizedBox(height: 40),

              // Header
              const Text(
                'Login to KaamSetu',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _isOtpSent 
                    ? 'Enter the 4-digit OTP sent to your mobile' 
                    : 'Enter your mobile number to continue',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),

              const SizedBox(height: 50),

              // Input Fields
              if (!_isOtpSent) ...[
                // Phone Number Input
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    hintText: '98765 43210',
                    prefixIcon: const Icon(Icons.phone_android, color: Color(0xFF6B46C1)),
                    prefixText: '+91 ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF6B46C1), width: 2),
                    ),
                  ),
                ),
              ] else ...[
                // OTP Input
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 10),
                  decoration: InputDecoration(
                    labelText: 'Enter OTP',
                    counterText: '', // Hides the character counter
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF6B46C1), width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: _sendOtp, // Resend logic
                    child: const Text(
                      'Resend OTP in 30s',
                      style: TextStyle(color: Color(0xFF6B46C1)),
                    ),
                  ),
                ),
              ],

              const Spacer(),

              // Action Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : (_isOtpSent ? _verifyOtp : _sendOtp),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B46C1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : Text(
                          _isOtpSent ? 'Verify & Continue' : 'Send OTP',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}