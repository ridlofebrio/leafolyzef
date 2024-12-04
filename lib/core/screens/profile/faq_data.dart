class FaqData {
  final String question;
  final String answer;

  const FaqData({required this.question, required this.answer});
}

const List<FaqData> faqList = [
  FaqData(
    question: 'What is the purpose of this application?',
    answer: 'This application is designed to assist farmers and agricultural enthusiasts in detecting diseases on tomato leaves using advanced AI technology. By uploading an image of a tomato leaf, you can quickly identify potential diseases and receive actionable recommendations.',
  ),
  FaqData(
    question: 'How does the tomato leaf disease detection work?',
    answer: 'The application uses a trained deep learning model to analyze the image of the tomato leaf. It identifies patterns and symptoms associated with common diseases like blight, septoria, or mosaic virus and provides a detailed diagnosis.',
  ),
  FaqData(
    question: 'What types of diseases can be detected?',
    answer: 'Currently, the application can detect diseases such as early blight, late blight, septoria leaf spot, and tomato mosaic virus. We are continuously working to expand the range of detectable diseases.',
  ),
  FaqData(
    question: 'How accurate is the detection?',
    answer: 'The detection accuracy depends on the quality of the uploaded image and the disease severity. Our model has been trained on a large dataset and provides highly accurate results in most cases. However, for confirmation, it is always advised to consult with an agricultural expert.',
  ),
  FaqData(
    question: 'What should I do if the application cannot detect a disease?',
    answer: 'If the application cannot identify a disease, it may be due to an unclear image or an undetected disease type. Try capturing a clear image of the affected area or consult with an agricultural expert for further analysis.',
  ),
  FaqData(
    question: 'Is my data safe?',
    answer: 'Yes, your data is securely stored and used only for improving your experience and enhancing the application’s accuracy. Please refer to our Privacy Policy for more details.',
  ),
  FaqData(
    question: 'Can I use this app offline?',
    answer: 'No, an internet connection is required to upload images and process disease detection as the application communicates with our cloud-based AI system.',
  ),
];
