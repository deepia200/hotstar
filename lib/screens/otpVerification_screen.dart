// lib/screens/otp_verification_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/api_methods.dart';
import 'forgot_password.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String userId;

  const OtpVerificationScreen({super.key, required this.userId});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  int _resendSeconds = 30;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    _resendSeconds = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds > 0) {
        setState(() => _resendSeconds--);
      } else {
        _timer.cancel();
      }
    });
  }

  void _resendOtp() async {
    setState(() => _isLoading = true);
    final response = await ApiMethods.sendOtp(widget.userId);
    setState(() => _isLoading = false);

    if (response['status'] == 'success') {
      final otp = response['otp'] ?? '****'; // Fallback in case 'otp' is missing

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('OTP resent successfully. New OTP: $otp'),
          duration: const Duration(seconds: 5),
        ),
      );

      _startResendTimer();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'].toString())),
      );
    }
  }


  void _verifyOtp() async {
    final otp = _otpController.text.trim();
    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter OTP')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final response = await ApiMethods.verifyOtp(widget.userId, otp);

    setState(() => _isLoading = false);

    if (response['status'] == 'success') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('id', widget.userId);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP Verified')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'].toString())),
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Verify OTP",
          style:
          GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Enter the OTP sent to your registered ID',
              style: GoogleFonts.roboto(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              style: GoogleFonts.roboto(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter OTP',
                hintStyle: GoogleFonts.roboto(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[850],
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _resendSeconds > 0
                    ? Text(
                  'Resend in $_resendSeconds sec',
                  style: GoogleFonts.roboto(color: Colors.grey),
                )
                    : TextButton(
                  onPressed: _resendOtp,
                  child: Text(
                    "Resend OTP",
                    style: GoogleFonts.roboto(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.pink],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: ElevatedButton(
                onPressed: _isLoading ? null : _verifyOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                  "Verify & Continue",
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
