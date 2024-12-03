class AboutData {
  final String title;
  final String content;

  const AboutData({required this.title, required this.content});
}

const String aboutYourAccountContent = '''
Welcome to our agricultural application! Your account is your gateway to a world of agricultural insights and tools designed to help you manage your farming activities more efficiently. Here’s what you need to know about your account:

1. Account Creation: To access our services, you need to create an account by providing your basic information. This helps us personalize your experience and provide relevant recommendations.

2. Profile Management: You can update your profile information at any time. This includes your contact details, farm location, and preferences. Keeping your profile up-to-date ensures you receive the most accurate and useful information.

3. Data Security: We prioritize the security of your data. All your personal information is stored securely and is only used to enhance your experience with our application. Please refer to our Privacy Policy for more details.

4. Account Settings: Customize your account settings to suit your needs. You can manage notifications, language preferences, and other settings to make the application work best for you.

5. Support and Assistance: We’re here to help! Contact our support team for assistance with any account-related queries or issues.
''';

const String termsOfUseContent = '''
By accessing or using our services, you agree to comply with and be bound by the following terms and conditions:

1. Acceptance of Terms: By using this application, you agree to these terms of use. If you do not agree, please do not use the application.

2. User Responsibilities: Users are responsible for maintaining the confidentiality of their account information and for all activities that occur under their account.

3. Prohibited Activities: Users are prohibited from using the application for any unlawful purpose or any activity that could harm the application or its users.

4. Intellectual Property: All content, including text, graphics, logos, and software, is the property of the application and protected by copyright laws.

5. Data Privacy: We are committed to protecting your privacy. Please refer to our Privacy Policy for information on how we collect, use, and protect your data.

6. Limitation of Liability: The application is provided "as is" without any warranties. We are not liable for any damages arising from the use of the application.

7. Changes to Terms: We reserve the right to modify these terms at any time. Continued use of the application constitutes acceptance of the revised terms.
''';

const List<AboutData> aboutSections = [
  AboutData(
    title: 'About Your Account',
    content: aboutYourAccountContent,
  ),
  AboutData(
    title: 'Terms of Use',
    content: termsOfUseContent,
  ),
];
