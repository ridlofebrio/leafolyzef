import 'package:flutter/material.dart';
import 'package:leafolyze/utils/constants.dart';
import 'about_data.dart'; // Import file baru

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'About',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Main Content
              Expanded(
                child: ListView(
                  children: aboutSections.map((section) {
                    return Column(
                      children: [
                        _buildExpandableSection(
                          title: section.title,
                          content: section.content,
                        ),
                        const Divider(),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required String content,
  }) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: AppFontWeight.semiBold,
          color: Colors.black,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
