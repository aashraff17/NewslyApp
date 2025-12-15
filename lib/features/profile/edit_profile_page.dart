import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_auth_provider.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AppAuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// PROFILE IMAGE (for later)
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: const Icon(Icons.person, size: 50),
            ),

            const SizedBox(height: 24),

            /// ✅ THIS IS WHERE YOUR CODE GOES
            TextFormField(
              initialValue: auth.displayName,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              onChanged: auth.updateName,
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () async {
                await auth.saveProfile();
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
