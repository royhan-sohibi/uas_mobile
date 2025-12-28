import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xFFB71C1C),
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Nama Pengguna',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'user@example.com',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Handle edit profile
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Settings Sections
              const Text(
                'Umum',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              _buildSettingOption(
                icon: Icons.language,
                title: 'Bahasa',
                subtitle: 'Indonesia',
                onTap: () {},
              ),
              _buildSettingOption(
                icon: Icons.notifications,
                title: 'Notifikasi',
                subtitle: 'Kelola notifikasi',
                onTap: () {},
              ),
              _buildSettingOption(
                icon: Icons.dark_mode,
                title: 'Tema',
                subtitle: 'Terang',
                onTap: () {},
              ),
              
              const SizedBox(height: 24),
              const Text(
                'Akun',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              _buildSettingOption(
                icon: Icons.person_outline,
                title: 'Informasi Pribadi',
                onTap: () {},
              ),
              _buildSettingOption(
                icon: Icons.lock_outline,
                title: 'Ubah Kata Sandi',
                onTap: () {},
              ),
              _buildSettingOption(
                icon: Icons.security,
                title: 'Privasi & Keamanan',
                onTap: () {},
              ),
              
              const SizedBox(height: 24),
              const Text(
                'Lainnya',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              _buildSettingOption(
                icon: Icons.help_outline,
                title: 'Bantuan & Dukungan',
                onTap: () {},
              ),
              _buildSettingOption(
                icon: Icons.info_outline,
                title: 'Tentang Aplikasi',
                onTap: () {},
              ),
              _buildSettingOption(
                icon: Icons.description,
                title: 'Syarat & Ketentuan',
                onTap: () {},
              ),
              
              const SizedBox(height: 24),
              _buildSettingOption(
                icon: Icons.logout,
                title: 'Keluar',
                onTap: () {
                  // Handle logout
                },
                isDestructive: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingOption({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? Colors.red : const Color(0xFFB71C1C),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? Colors.red : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: const TextStyle(fontSize: 12),
              )
            : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
