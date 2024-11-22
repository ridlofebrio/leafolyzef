import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Frequently Asked Questions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Find answers to common questions about our tomato leaf disease detection app below. If you don’t find what you’re looking for, feel free to contact us!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildFaqTile(
                    question: 'What is the purpose of this application?',
                    answer:
                        'This application is designed to assist farmers and agricultural enthusiasts in detecting diseases on tomato leaves using advanced AI technology. By uploading an image of a tomato leaf, you can quickly identify potential diseases and receive actionable recommendations.',
                  ),
                  _buildFaqTile(
                    question:
                        'How does the tomato leaf disease detection work?',
                    answer:
                        'The application uses a trained deep learning model to analyze the image of the tomato leaf. It identifies patterns and symptoms associated with common diseases like blight, septoria, or mosaic virus and provides a detailed diagnosis.',
                  ),
                  _buildFaqTile(
                    question: 'What types of diseases can be detected?',
                    answer:
                        'Currently, the application can detect diseases such as early blight, late blight, septoria leaf spot, and tomato mosaic virus. We are continuously working to expand the range of detectable diseases.',
                  ),
                  _buildFaqTile(
                    question: 'How accurate is the detection?',
                    answer:
                        'The detection accuracy depends on the quality of the uploaded image and the disease severity. Our model has been trained on a large dataset and provides highly accurate results in most cases. However, for confirmation, it is always advised to consult with an agricultural expert.',
                  ),
                  _buildFaqTile(
                    question:
                        'What should I do if the application cannot detect a disease?',
                    answer:
                        'If the application cannot identify a disease, it may be due to an unclear image or an undetected disease type. Try capturing a clear image of the affected area or consult with an agricultural expert for further analysis.',
                  ),
                  _buildFaqTile(
                    question: 'Is my data safe?',
                    answer:
                        'Yes, your data is securely stored and used only for improving your experience and enhancing the application’s accuracy. Please refer to our Privacy Policy for more details.',
                  ),
                  _buildFaqTile(
                    question: 'Can I use this app offline?',
                    answer:
                        'No, an internet connection is required to upload images and process disease detection as the application communicates with our cloud-based AI system.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqTile({required String question, required String answer}) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            answer,
            style: const TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 0, 0, 0),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
