import 'package:flutter/material.dart';
import 'faq_data.dart';

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
                children: faqList.map((faq) {
                  return _buildFaqTile(
                    question: faq.question,
                    answer: faq.answer,
                  );
                }).toList(),
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
