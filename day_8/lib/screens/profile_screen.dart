import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildAccountOptions(context),
            const SizedBox(height: 24),
            _buildSecurityOptions(context),
            const SizedBox(height: 24),
            _buildGeneralOptions(context),
            const SizedBox(height: 24),
            _buildSignOutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.primaryColor,
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              'https://i.pravatar.cc/150?img=11',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Alex Johnson',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'alex.johnson@example.com',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondaryColor,
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: () {},
          child: const Text('Edit Profile'),
        ),
      ],
    );
  }

  Widget _buildAccountOptions(BuildContext context) {
    return _buildSection(
      context,
      'Account',
      [
        _buildOptionTile(
          icon: Icons.person_outline,
          title: 'Personal Information',
          onTap: () {},
        ),
        _buildOptionTile(
          icon: Icons.payment_outlined,
          title: 'Payment Methods',
          onTap: () {},
        ),
        _buildOptionTile(
          icon: Icons.verified_user_outlined,
          title: 'KYC Verification',
          subtitle: 'Verified',
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.successColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Verified',
              style: TextStyle(
                color: AppTheme.successColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSecurityOptions(BuildContext context) {
    return _buildSection(
      context,
      'Security',
      [
        _buildOptionTile(
          icon: Icons.lock_outline,
          title: 'Change Password',
          onTap: () {},
        ),
        _buildOptionTile(
          icon: Icons.security_outlined,
          title: 'Two-Factor Authentication',
          subtitle: 'Enabled',
          trailing: Switch(
            value: true,
            activeColor: AppTheme.primaryColor,
            onChanged: (value) {},
          ),
          onTap: () {},
        ),
        _buildOptionTile(
          icon: Icons.fingerprint,
          title: 'Biometric Authentication',
          trailing: Switch(
            value: true,
            activeColor: AppTheme.primaryColor,
            onChanged: (value) {},
          ),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildGeneralOptions(BuildContext context) {
    return _buildSection(
      context,
      'General',
      [
        _buildOptionTile(
          icon: Icons.language_outlined,
          title: 'Language',
          subtitle: 'English',
          onTap: () {},
        ),
        _buildOptionTile(
          icon: Icons.notifications_outlined,
          title: 'Notifications',
          onTap: () {},
        ),
        _buildOptionTile(
          icon: Icons.help_outline,
          title: 'Help & Support',
          onTap: () {},
        ),
        _buildOptionTile(
          icon: Icons.info_outline,
          title: 'About',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.cardColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppTheme.textPrimaryColor,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppTheme.textPrimaryColor,
          fontSize: 16,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(
                color: AppTheme.textSecondaryColor,
                fontSize: 12,
              ),
            )
          : null,
      trailing: trailing ??
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppTheme.textSecondaryColor,
          ),
      onTap: onTap,
    );
  }

  Widget _buildSignOutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.logout),
        label: const Text('Sign Out'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.errorColor.withOpacity(0.1),
          foregroundColor: AppTheme.errorColor,
        ),
      ),
    );
  }
}
