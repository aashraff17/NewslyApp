import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/app_auth_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> _pickProfileImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // NOTE: This is a placeholder. In a real app, you would upload
      // the image to a service like Firebase Storage and get the URL.
      final url =
          'https://api.dicebear.com/7.x/initials/png?seed=${DateTime.now().millisecondsSinceEpoch}';

      try {
        await FirebaseAuth.instance.currentUser?.updatePhotoURL(url);
        if (mounted) {
          setState(() {});
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating profile picture: ${e.toString()}')),
          );
        }
      }
    }
  }

  Future<void> _confirmDeleteAccount(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Account', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text(
          'This action is permanent and cannot be undone.\n\n'
              'Are you sure you want to delete your Newsly account?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      _deleteAccount(context);
    }
  }

  Future<void> _deleteAccount(BuildContext context) async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
      if (mounted) {
        context.go('/login');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login' && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in again before deleting your account.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    const primaryColor = Color(0xFF5FA8A3);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. IDENTITY HEADER
          // 1. IDENTITY HEADER
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickProfileImage,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[200], // The color you were seeing
                          // ✅ FIXED LOGIC BELOW
                          backgroundImage: (user?.photoURL != null && user!.photoURL!.isNotEmpty)
                              ? NetworkImage(user.photoURL!) as ImageProvider
                              : const AssetImage('assets/images/profile_avatar.png'),

                          // If the image fails to load, this child shows an icon
                          onBackgroundImageError: (exception, stackTrace) {
                            debugPrint('Error loading profile image: $exception');
                          },
                          child: (user?.photoURL == null || user!.photoURL!.isEmpty)
                              ? const Icon(Icons.person, size: 50, color: Colors.grey)
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black26)],
                          ),
                          child: const Icon(Icons.camera_alt_rounded, size: 16, color: Color(0xFF5FA8A3)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  user?.displayName ?? 'Newsly User',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white),
                ),
                Text(
                  user?.email ?? '',
                  style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.8)),
                ),
              ],
            ),
          ),

          // 2. SETTINGS SHEET
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  children: [
                    _buildSectionHeader('General Settings'),
                    _buildProfileTile(Icons.person_outline_rounded, 'Edit Profile', () => context.push('/edit-profile')),
                    _buildProfileTile(Icons.language_rounded, 'Language', () => context.push('/language')),
                    _buildProfileTile(Icons.lock_outline_rounded, 'Change Password', () => context.push('/change-password')),

                    const Padding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8), child: Divider()),

                    _buildSectionHeader('Account'),
                    _buildProfileTile(Icons.description_outlined, 'Terms & Conditions', () => context.push('/terms')),
                    _buildProfileTile(
                      Icons.logout_rounded,
                      'Sign Out',
                          () async {
                        await context.read<AppAuthProvider>().signOut();
                        if (mounted) context.go('/login');
                      },
                      color: primaryColor,
                    ),
                    _buildProfileTile(
                      Icons.delete_outline_rounded,
                      'Delete Account',
                          () => _confirmDeleteAccount(context),
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.2, color: Colors.grey),
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String title, VoidCallback onTap, {Color? color}) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (color ?? const Color(0xFF5FA8A3)).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color ?? const Color(0xFF5FA8A3), size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, color: color ?? Colors.black87),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
    );
  }
}