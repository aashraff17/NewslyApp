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
        // Rebuild the widget to show the new image
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
        title: const Text('Delete Account'),
        content: const Text(
          'This action is permanent and cannot be undone.\n\n'
          'Are you sure?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
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
      if (e.code == 'requires-recent-login') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please log in again before deleting your account.',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final authProvider = context.watch<AppAuthProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF5FA8A3),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickProfileImage,
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: user?.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : const AssetImage('assets/images/profile_avatar.png')
                          as ImageProvider,
                  child: const Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.edit, size: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                user?.displayName ?? 'Newsly User',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                user?.email ?? '',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextButton(
                onPressed: () => context.push('/edit-profile'),
                child: const Text('Edit Profile'),
              ),
              TextButton(
                onPressed: () async {
                  await context.read<AppAuthProvider>().signOut();
                  if (mounted) {
                    context.go('/login');
                  }
                },
                child: const Text('Sign Out'),
              ),
              const SizedBox(height: 24),
              Card(
                child: ListTile(
                  title: const Text('Language'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => context.push('/language'),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Change Password'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => context.push('/change-password'),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Terms & Conditions'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => context.push('/terms'),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Sign Out'),
                  trailing: const Icon(Icons.logout),
                  onTap: () async {
                    await context.read<AppAuthProvider>().signOut();
                    if (mounted) {
                      context.go('/login');
                    }
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text(
                    'Delete Account',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () => _confirmDeleteAccount(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
