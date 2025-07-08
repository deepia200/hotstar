// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'dart:io';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
//
// import '../bottamnavbar/bottamNav_Bar.dart';
// import '../provider/auth_provider.dart';
//
// class KycScreen extends StatefulWidget {
//   const KycScreen({super.key});
//
//   @override
//   State<KycScreen> createState() => _KycScreenState();
// }
//
// class _KycScreenState extends State<KycScreen> {
//   final _formKey = GlobalKey<FormState>();
//
//
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _zipController = TextEditingController();
//   final TextEditingController _fullAddressController = TextEditingController();
//
//   String city = '';
//   String state = '';
//   String country = '';
//
//   File? _aadhaarImage;
//   File? _otherDocImage;
//
//   Future<void> _pickImage(String type) async {
//     final user = Provider.of<AuthProvider>(context, listen: false);
//     if (user.isKycVerified) return;
//
//     final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       final file = File(picked.path);
//       setState(() {
//         if (type == 'aadhaar') {
//           _aadhaarImage = file;
//           user.setAadhaarImage(picked.path);
//         } else {
//           _otherDocImage = file;
//           user.setOtherDocumentImage(picked.path);
//         }
//       });
//     }
//   }
//
//   Future<void> _fetchLocationFromZip(String zip) async {
//     if (zip.length != 6) return;
//
//     try {
//       final url = Uri.parse('https://api.postalpincode.in/pincode/$zip');
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data[0]['Status'] == 'Success' && data[0]['PostOffice'] != null) {
//           final postOffice = data[0]['PostOffice'][0];
//           setState(() {
//             city = postOffice['District'] ?? '';
//             state = postOffice['State'] ?? '';
//             country = postOffice['Country'] ?? 'India';
//           });
//         } else {
//           setState(() {
//             city = '';
//             state = '';
//             country = '';
//           });
//         }
//       }
//     } catch (e) {
//       setState(() {
//         city = '';
//         state = '';
//         country = '';
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     final user = Provider.of<AuthProvider>(context, listen: false);
//     _phoneController.text = user.phone ?? '';
//     _zipController.text = user.address?['zip'] ?? '';
//     _fullAddressController.text = user.fullAddress ?? '';
//   }
//
//   void _submit() {
//     if (_formKey.currentState!.validate()) {
//       final user = Provider.of<AuthProvider>(context, listen: false);
//       user.setPhone(_phoneController.text);
//       user.setAddress({
//         'zip': _zipController.text,
//         'city': city,
//         'state': state,
//         'country': country,
//       });
//       user.setFullAddress(_fullAddressController.text);
//       user.completeKyc();
//
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (_) => const BottomNavBarScreen()),
//             (route) => false,
//       );
//     }
//   }
//
//   Widget _buildField({
//     required String label,
//     required TextEditingController controller,
//     required String? Function(String?) validator,
//     required bool isEditable,
//     TextInputType keyboardType = TextInputType.text,
//     List<TextInputFormatter>? inputFormatters,
//     Function(String)? onChanged,
//     int? maxLength,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         style: TextStyle(
//           color: isEditable ? Colors.white : Colors.grey[400],
//         ),
//         readOnly: !isEditable,
//         controller: controller,
//         keyboardType: keyboardType,
//         validator: isEditable ? validator : (_) => null,
//         inputFormatters: inputFormatters,
//         onChanged: onChanged,
//         maxLength: maxLength,
//         decoration: InputDecoration(
//           hintText: label,
//           hintStyle: TextStyle(
//             color: isEditable ? Colors.grey : Colors.grey[600],
//           ),
//           filled: true,
//           fillColor: Colors.grey[850],
//           counterText: '',
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none,
//           ),
//           contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildGradientLabel(String title, String value) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(12),
//       margin: const EdgeInsets.only(bottom: 10),
//       decoration: BoxDecoration(
//         color: Colors.black38,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: Colors.grey,
//           width: 1.5,
//         ),
//       ),
//       child: Text(
//         '$title: $value',
//         style: GoogleFonts.roboto(
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<AuthProvider>(context);
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.black,
//         title: Text(
//           'KYC Details',
//           style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Complete your KYC details',
//                     style: GoogleFonts.roboto(color: Colors.white, fontSize: 18)),
//                 const SizedBox(height: 16),
//                 Text('Name: ${user.name ?? 'N/A'}',
//                     style: GoogleFonts.roboto(color: Colors.white, fontSize: 16)),
//                 Text('Email: ${user.email ?? 'N/A'}',
//                     style: GoogleFonts.roboto(color: Colors.white, fontSize: 16)),
//                 // Text('DOB: ${user. ?? 'N/A'}',
//                 //     style: GoogleFonts.roboto(color: Colors.white, fontSize: 16)),
//                 const SizedBox(height: 20),
//
//                 _buildField(
//                   label: 'Phone Number',
//                   controller: _phoneController,
//                   isEditable: user.phone == null || user.phone!.isEmpty,
//                   validator: (value) =>
//                   value == null || value.isEmpty ? 'Enter phone number' : null,
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [LengthLimitingTextInputFormatter(10)],
//                 ),
//
//                 _buildField(
//                   label: 'Full Address',
//                   controller: _fullAddressController,
//                   isEditable: true,
//                   validator: (v) => v!.isEmpty ? 'Enter full address' : null,
//                 ),
//
//                 _buildField(
//                   label: 'Zip Code',
//                   controller: _zipController,
//                   isEditable: true,
//                   validator: (v) => v!.isEmpty ? 'Enter zip code' : null,
//                   keyboardType: TextInputType.number,
//                   maxLength: 6,
//                   onChanged: (value) {
//                     if (value.length == 6) {
//                       _fetchLocationFromZip(value);
//                     }
//                   },
//                 ),
//
//                 if (city.isNotEmpty) _buildGradientLabel('City', city),
//                 if (state.isNotEmpty) _buildGradientLabel('State', state),
//                 if (country.isNotEmpty) _buildGradientLabel('Country', country),
//
//                 const SizedBox(height: 20),
//                 Text('Upload Aadhaar Card (mandatory)',
//                     style: GoogleFonts.roboto(color: Colors.white, fontSize: 16)),
//                 if (!user.isKycVerified)
//                   ElevatedButton(
//                     onPressed: () => _pickImage('aadhaar'),
//                     child: const Text('Upload Aadhaar'),
//                   ),
//                 if (_aadhaarImage != null)
//                   Image.file(_aadhaarImage!, height: 100),
//
//                 const SizedBox(height: 20),
//                 Text('Upload PAN Card or Driving License (optional)',
//                     style: GoogleFonts.roboto(color: Colors.white, fontSize: 16)),
//                 if (!user.isKycVerified)
//                   ElevatedButton(
//                     onPressed: () => _pickImage('other'),
//                     child: const Text('Upload PAN / DL'),
//                   ),
//                 if (_otherDocImage != null)
//                   Image.file(_otherDocImage!, height: 100),
//
//                 const SizedBox(height: 30),
//                 Center(
//                   child: Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [Colors.blueAccent, Colors.pinkAccent],
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: ElevatedButton(
//                       onPressed: _submit,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.transparent,
//                         foregroundColor: Colors.white,
//                         shadowColor: Colors.transparent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: Text('Submit KYC',
//                           style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bottamnavbar/bottamNav_Bar.dart';
import '../provider/auth_provider.dart';
import 'DocumentUplode_screen.dart';

class KycScreen extends StatefulWidget {
  final String username;
  final String email;
  // final String birthdate;
  final String? phone;
  final Map<String, dynamic>? address;

  const KycScreen({
    Key? key,
    required this.username,
    required this.email,
    // required this.birthdate,
    required this.phone,
    this.address,
  }) : super(key: key);

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  final TextEditingController _phoneController = TextEditingController();
  // final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _fullAddressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _beneficiaryNameController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _aadhaarNumberController = TextEditingController();
  final TextEditingController _panNumberController = TextEditingController();
  final TextEditingController _adharNumberController = TextEditingController();


  String _city = '';
  String _state = '';
  String _country = '';
  late String  fname;
  late String email;
  late String  phone;
  late String  username;

  File? _aadhaarImage;
  File? _panCardImage;
  File? _otherDocImage;

  @override
  void initState() {
    super.initState();
    loadUserdata();

    _loadInitialData();
  }

  void loadUserdata() async {
    final prefs = await SharedPreferences.getInstance(); // Await is necessary
    final userEncodedData = prefs.getString('userdetails');
 print("kesav");
 print(userEncodedData);
    if (userEncodedData != null) {
      final Map<String, dynamic> userData = jsonDecode(userEncodedData);
      fname = userData['fname'];
      username = userData['username'];
      email = userData['email'];
      phone = userData['phone'];
      print("Username: ${userData['username']}");
      print("Email: ${userData['email']}");
      print("Phone: ${userData['phone']}");
      _initializeForm(
        fname, email, phone
      );
      // You can now use this data as needed
    } else {
      print("No user data found in SharedPreferences.");
    }
  }

  void _initializeForm( fname, email, phone) {
    print(fname);
    _nameController.text = fname;
    _emailController.text = email;
    // _dobController.text = birthdate;
    _phoneController.text = phone ;

    if (widget.address != null) {
      _zipController.text = widget.address!['pincode'] ?? '';
      _fullAddressController.text = widget.address!['address'] ?? '';
      _city = widget.address!['city'] ?? '';
      _state = widget.address!['state'] ?? '';
      _country = widget.address!['country'] ?? 'India';
    }
  }

  Future<void> _loadInitialData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _phoneController.text = _phoneController.text.isEmpty ? prefs.getString('phone') ?? '' : _phoneController.text;
      _zipController.text = _zipController.text.isEmpty ? prefs.getString('zip') ?? '' : _zipController.text;
      _fullAddressController.text = _fullAddressController.text.isEmpty ? prefs.getString('address') ?? '' : _fullAddressController.text;
      _city = _city.isEmpty ? prefs.getString('city') ?? '' : _city;
      _state = _state.isEmpty ? prefs.getString('state') ?? '' : _state;
      _country = _country.isEmpty ? prefs.getString('country') ?? '' : _country;
    });
  }

  Future<void> _pickImage(String type) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (type == 'aadhaar') {
          _aadhaarImage = File(pickedFile.path);
        } else if (type == 'other') {
          _otherDocImage = File(pickedFile.path);
        } else if (type == 'pan') {
          _panCardImage = File(pickedFile.path);
        }
      });
    }
  }


  Future<void> _fetchLocationFromZip(String zip) async {
    if (zip.length != 6) return;

    try {
      final response = await http.get(Uri.parse('https://api.postalpincode.in/pincode/$zip'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data[0]['Status'] == 'Success' && data[0]['PostOffice'] != null) {
          final postOffice = data[0]['PostOffice'][0];
          setState(() {
            _city = postOffice['District'] ?? '';
            _state = postOffice['State'] ?? '';
            _country = postOffice['Country'] ?? 'India';
          });
        }
      }
    } catch (e) {
      // Handle error silently
    }
  }
  Future<void> _submitKyc() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final prefs = await SharedPreferences.getInstance();

      // Save locally for auto-fill next time
      await prefs.setString('phone', _phoneController.text);
      await prefs.setString('zip', _zipController.text);
      await prefs.setString('address', _fullAddressController.text);
      await prefs.setString('city', _city);
      await prefs.setString('state', _state);
      await prefs.setString('country', _country);

      final success = await authProvider.submitKycDetails(
        username: username, // from your SharedPreferences
        phone: _phoneController.text,
        address: _fullAddressController.text,
        pincode: _zipController.text,
        city: _city,
        state: _state,
        country: _country,
        panNumber: _panNumberController.text,
        adharNumber: _adharNumberController.text,
        bankName: _bankNameController.text,
        ifscCode: _ifscController.text,
        accountNumber: _accountNumberController.text,
        beneficiaryName: _beneficiaryNameController.text,
      );

      if (success) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DocumentUploadScreen()),
        );
      } else {
        setState(() {
          _errorMessage = 'Failed to submit KYC. Please check all fields.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: ${e.toString()}';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }



  Widget _buildReadOnlyField(String label, String value) {
    return TextFormField(
      initialValue: value,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.roboto(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[850],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
      style: GoogleFonts.roboto(color: Colors.white),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    Function(String)? onChanged,
    int? maxLength,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.roboto(color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[850],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          counterText: '',
        ),
        style: GoogleFonts.roboto(color: Colors.white),
      ),
    );
  }

  Widget _buildLocationTile(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Text('$title: $value', style: GoogleFonts.roboto(color: Colors.white, fontSize: 16)),
    );
  }

  Widget _buildDocumentUpload(String label, bool isMandatory, File? image, VoidCallback onPressed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label ${isMandatory ? '(mandatory)' : '(optional)'}',
            style: GoogleFonts.roboto(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[900], foregroundColor: Colors.white),
          child: Text('Upload $label'),
        ),
        if (image != null) ...[
          const SizedBox(height: 8),
          Image.file(image, height: 100, width: 150, fit: BoxFit.cover),
        ],
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('KYC Details', style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(_errorMessage!, style: GoogleFonts.roboto(color: Colors.red)),
                  ),

                _buildReadOnlyField('Username', fname),
                const SizedBox(height: 12),
                _buildReadOnlyField('Email', email),
                // const SizedBox(height: 12),
                // _buildReadOnlyField('Date of Birth', birthdate),
                const SizedBox(height: 20),

                _buildEditableField(
                  label: 'Phone Number',
                  controller: _phoneController,
                  validator: (v) => v!.isEmpty ? 'Enter phone number' : null,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 10,
                ),
                _buildEditableField(
                  label: 'Full Address',
                  controller: _fullAddressController,
                  validator: (v) => v!.isEmpty ? 'Enter full address' : null,
                ),
                _buildEditableField(
                  label: 'Zip Code',
                  controller: _zipController,
                  validator: (v) => v!.isEmpty ? 'Enter zip code' : null,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 6,
                  onChanged: (v) => v.length == 6 ? _fetchLocationFromZip(v) : null,
                ),

                if (_city.isNotEmpty) _buildLocationTile('City', _city),
                if (_state.isNotEmpty) _buildLocationTile('State', _state),
                if (_country.isNotEmpty) _buildLocationTile('Country', _country),
                Text(
                  'Bank Details',
                  style: GoogleFonts.roboto(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                _buildEditableField(
                  label: 'Beneficiary Name',
                  controller: _beneficiaryNameController,
                  validator: (v) => v!.isEmpty ? 'Enter beneficiary name' : null,
                ),
                _buildEditableField(
                  label: 'Account Number',
                  controller: _accountNumberController,
                  validator: (v) => v!.isEmpty ? 'Enter account number' : null,
                  keyboardType: TextInputType.number,
                ),
                _buildEditableField(
                  label: 'IFSC Code',
                  controller: _ifscController,
                  validator: (v) => v!.isEmpty ? 'Enter IFSC code' : null,
                  keyboardType: TextInputType.text,
                ),
                _buildEditableField(
                  label: 'Bank Name',
                  controller: _bankNameController,
                  validator: (v) => v!.isEmpty ? 'Enter bank name' : null,
                ),

                Text(
                  'Document Details',
                  style: GoogleFonts.roboto(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                _buildEditableField(
                  label: 'Aadhaar Number',
                  controller: _aadhaarNumberController,
                  validator: (v) => v!.isEmpty ? 'Enter Aadhaar number' : null,
                  keyboardType: TextInputType.number,
                  maxLength: 12,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                _buildEditableField(
                  label: 'PAN Number',
                  controller: _panNumberController,
                  validator: (v) => v!.isEmpty ? 'Enter PAN number' : null,
                ),


                //
                // _buildDocumentUpload('Aadhaar Card', true, _aadhaarImage, () => _pickImage('aadhaar')),
                // _buildDocumentUpload('PAN Card', false, _panCardImage, () => _pickImage('pan')),
                // _buildDocumentUpload('BankPassbook', false, _otherDocImage, () => _pickImage('other')),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: _isLoading ? null : _submitKyc,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.blue, Colors.pink],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                          'Submit KYC',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
