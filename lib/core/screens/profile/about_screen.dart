import 'package:flutter/material.dart';
import 'package:leafolyze/utils/constants.dart';

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
                  children: [
                    _buildExpandableSection(
                      title: 'About Your Account',
                      content: '''
Welcome to our agricultural application! Your account is your gateway to a world of agricultural insights and tools designed to help you manage your farming activities more efficiently. Here’s what you need to know about your account:

1. Account Creation: To access our services, you need to create an account by providing your basic information. This helps us personalize your experience and provide relevant recommendations.

2. Profile Management: You can update your profile information at any time. This includes your contact details, farm location, and preferences. Keeping your profile up-to-date ensures you receive the most accurate and useful information.

3. Data Security: We prioritize the security of your data. All your personal information is stored securely and is only used to enhance your experience with our application. Please refer to our Privacy Policy for more details.

4. Account Settings: Customize your account settings to suit your needs. You can manage notifications, language preferences, and other settings to make the application work best for you.

5. Support and Assistance: We’re here to help! Contact our support team for assistance with any account-related queries or issues.
                      ''',
                    ),
                    const Divider(),
                    _buildExpandableSection(
                      title: 'Terms of Use',
                      content: '''
Welcome to our agricultural application. By accessing or using our services, you agree to comply with and be bound by the following terms and conditions:

1. Acceptance of Terms: By using this application, you agree to these terms of use. If you do not agree, please do not use the application.

2. User Responsibilities: Users are responsible for maintaining the confidentiality of their account information and for all activities that occur under their account.

3. Prohibited Activities: Users are prohibited from using the application for any unlawful purpose or any activity that could harm the application or its users.

4. Intellectual Property: All content, including text, graphics, logos, and software, is the property of the application and protected by copyright laws.

5. Data Privacy: We are committed to protecting your privacy. Please refer to our Privacy Policy for information on how we collect, use, and protect your data.

6. Limitation of Liability: The application is provided "as is" without any warranties. We are not liable for any damages arising from the use of the application.

7. Changes to Terms: We reserve the right to modify these terms at any time. Continued use of the application constitutes acceptance of the revised terms.
                      ''',
                    ),
                  ],
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
