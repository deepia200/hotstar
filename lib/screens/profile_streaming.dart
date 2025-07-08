// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../bottamnavbar/side_Drawer.dart';
// import '../profile/AboutUs.dart';
// import '../profile/change_mobileNo.dart';
// import '../provider/auth_provider.dart';
// import 'HelpSupport_Screen.dart';
// import 'Wallet_sacreen.dart';
// import 'auth_Screen.dart';
// import 'changePassword.dart';
// import 'contectsupport_screen.dart';
// import 'edit_profile.dart';
// import 'forgot_password.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   Future<bool> isMemberUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     final memberType = prefs.getString('memberType') ?? '';
//     return memberType == '0';
//   }
//
//
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   XFile? _image;
//   final ImagePicker _picker = ImagePicker();
//
//   @override
//   void initState() {
//     super.initState();
//     // Fetch user data when screen loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final authProvider = Provider.of<AuthProvider>(context, listen: false);
//       if (	authProvider.id != null) {
//         // Assuming username is in format "RLID00014" where 14 is the ID
//         final userId = 	authProvider.id?.replaceAll('RLID', '') ?? '';
//         authProvider.fetchUserDetailsById(userId);
//       }
//     });
//   }
//
//   Future<void> _pickImage() async {
//     final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         _image = pickedImage;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<AuthProvider>(context);
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         drawer: HotstarDrawer(),
//         appBar: AppBar(
//             backgroundColor: Colors.black,
//           title: // Important to apply gradient to image
//           Image.asset(
//             'assets/images/logo.png', // Make sure this is added in pubspec.yaml
//             height: 50,
//             fit: BoxFit.contain,
//           ),
//             // title: ShaderMask(
//             //   shaderCallback: (bounds) => LinearGradient(
//             //     colors: [Colors.blue, Colors.pink],
//             //     tileMode: TileMode.mirror,
//             //   ).createShader(bounds),
//             //   child: Text(
//             //     'ReelLife',
//             //     style: GoogleFonts.roboto(
//             //       fontSize: 28,
//             //       fontWeight: FontWeight.bold,
//             //       color: Colors.white,
//             //     ),
//             //   ),
//             // ),
//             centerTitle: true,
//           actions: [
//             FutureBuilder<bool>(
//               future: widget.isMemberUser(), // Changed to widget.isMemberUser()
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) return SizedBox.shrink();
//
//                 final isMember = snapshot.data ?? false;
//                 final authProvider = Provider.of<AuthProvider>(context, listen: false);
//
//                 if (authProvider.isAuthenticated && isMember) {
//                   return IconButton(
//                     icon: const Icon(Icons.account_balance_wallet, color: Colors.white),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const WalletScreen()),
//                       );
//                     },
//                   );
//                 } else {
//                   return SizedBox.shrink();
//                 }
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.share),
//               onPressed: () {
//                 Share.share('Check out my KYC ID on the app!');
//               },
//             ),
//           ],
//         ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 24.0),
//             child: Column(
//               children: [
//             //     GestureDetector(
//             //       onTap: _pickImage,
//             //       // child: CircleAvatar(
//             //       //   radius: 40,
//             //       //   backgroundColor: Colors.blueGrey[800], // Background color for the icon
//             //       //   child: Icon(
//             //       //     Icons.person,
//             //       //     size: 40,
//             //       //     color: Colors.white,
//             //       //   ),
//             //       // )
//             //
//             //  child:  CircleAvatar(
//             //     radius: 40,
//             //     backgroundImage: _image == null
//             //         ? const NetworkImage('https://via.placeholder.com/150') // Default image
//             //         : FileImage(File(_image!.path)) as ImageProvider,
//             //   ),
//             // ),
//
//                 GestureDetector(
//                   onTap: _pickImage,
//                   child: Stack(
//                     alignment: Alignment.bottomRight,
//                     children: [
//                       CircleAvatar(
//                         radius: 50,
//                         backgroundImage: _image == null
//                             ? const NetworkImage('https://via.placeholder.com/150') // Default image
//                             : FileImage(File(_image!.path)) as ImageProvider,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.white38,
//                         ),
//                         padding: const EdgeInsets.all(5),
//                         child: const Icon(
//                           Icons.edit,
//                           color: Colors.white,
//                           size: 30,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 12),
//                 Text(
//                   user.fname ?? 'Loading...',
//                   style: GoogleFonts.roboto(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'ID: ${user.id ?? 'Loading...'}',
//                   style:  GoogleFonts.roboto(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   user.email ?? 'Loading...',
//                   style:  GoogleFonts.roboto(
//                     color: Colors.white70,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Divider(color: Colors.white24),
//           Expanded(
//             child: ListView(
//               children: [
//                 _buildProfileOption(
//                   icon: Icons.lock,
//                   title: 'Change Password',
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
//                   ),
//                 ),
//                 _buildProfileOption(
//                   icon: Icons.phone_android,
//                   title: 'Update Mobile Number',
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => UpdateMobileNumberScreen()),
//                   ),
//                 ),
//                 _buildProfileOption(
//                   icon: Icons.info_outline,
//                   title: 'About Us',
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => const AboutUsScreen()),
//                   ),
//                 ),
//                 _buildProfileOption(
//                   icon: Icons.phone,
//                   title: 'Contact Us',
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => const ContactSupportScreen()),
//                   ),
//                 ),
//                 _buildProfileOption(
//                   icon: Icons.support_agent,
//                   title: 'Support',
//                   onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => HelpSupportScreen())),
//                 ),
//                 _buildProfileOption(
//                   icon: Icons.logout,
//                   title: 'Sign Out',
//                   onTap: () {
//                     user.logout();
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (_) => AuthScreen()),
//                           (route) => false,
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//     );
//   }
//
//   Widget _buildProfileOption({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.white),
//       title: Text(title, style: const TextStyle(color: Colors.white)),
//       trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
//       onTap: onTap,
//     );
//   }
// }
//
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotstar/service/api_methods.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bottamnavbar/side_Drawer.dart';
import '../profile/AboutUs.dart';
import '../profile/change_mobileNo.dart';
import '../provider/auth_provider.dart';
import '../service/api_service.dart';
import 'HelpSupport_Screen.dart';
import 'Wallet_sacreen.dart';
import 'auth_Screen.dart';
import 'changePassword.dart';
import 'contectsupport_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  Future<bool> isMemberUser() async {
    final prefs = await SharedPreferences.getInstance();
    final memberType = prefs.getString('memberType') ?? '';
    return memberType == '0';
  }

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.id != null) {
        authProvider.fetchUserDetailsById(authProvider.id!);
      }
    });
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Take Photo"),
            onTap: () => _pickImage(ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text("Choose from Gallery"),
            onTap: () => _pickImage(ImageSource.gallery),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      final file = File(pickedImage.path);
      setState(() => _imageFile = file);

      final id = Provider.of<AuthProvider>(context, listen: false).id;
      if (id != null) {
        final success = await ApiMethods.uploadProfileImage(id: id, imageFile: file);
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile image updated!")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to update image")));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        drawer:  HotstarDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title:   ShaderMask(
            shaderCallback:
                (bounds) => LinearGradient(
              colors: [Colors.blue, Colors.pink],
              tileMode: TileMode.mirror,
            ).createShader(bounds),
            child: Text(
              'ReelLife',
              style: GoogleFonts.roboto(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            FutureBuilder<bool>(
              future: widget.isMemberUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) return const SizedBox.shrink();
                final isMember = snapshot.data ?? false;
                if (user.isAuthenticated && isMember) {
                  return IconButton(
                    icon: const Icon(Icons.account_balance_wallet, color: Colors.white),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const WalletScreen()),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () => Share.share('Check out my KYC ID on the app!'),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _showImagePickerOptions,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[800],
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : (user.profileImage != null && user.profileImage!.isNotEmpty
                              ? NetworkImage(ApiMethods.getImageUrl(user.profileImage))
                              : null) as ImageProvider?,
                          child: (_imageFile == null &&
                              (user.profileImage == null || user.profileImage!.isEmpty))
                              ? const Icon(Icons.person, size: 50, color: Colors.white70)
                              : null,
                        ),

                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white38,
                          ),
                          padding: const EdgeInsets.all(5),
                          child: const Icon(Icons.edit, color: Colors.white, size: 30),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(user.fname ?? 'Loading...', style: GoogleFonts.roboto(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('ID: ${user.id ?? 'Loading...'}', style: GoogleFonts.roboto(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(user.email ?? 'Loading...', style: GoogleFonts.roboto(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const Divider(color: Colors.white24),
            Expanded(
              child: ListView(
                children: [
                  _buildProfileOption(Icons.lock, 'Change Password', () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChangePasswordScreen()))),
                  _buildProfileOption(Icons.phone_android, 'Update Mobile Number', () => Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateMobileNumberScreen()))),
                  _buildProfileOption(Icons.info_outline, 'About Us', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutUsScreen()))),
                  _buildProfileOption(Icons.phone, 'Contact Us', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactSupportScreen()))),
                  _buildProfileOption(Icons.support_agent, 'Support', () => Navigator.push(context, MaterialPageRoute(builder: (_) => HelpSupportScreen()))),
                  _buildProfileOption(Icons.logout, 'Sign Out', () {
                    user.logout();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const AuthScreen()), (route) => false);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
      onTap: onTap,
    );
  }
}
