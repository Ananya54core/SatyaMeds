import 'package:flutter/material.dart';
import 'package:satyameds/mainscreen/disease_detail.dart';

void main() {
  runApp(SymptomCheckerApp());
}

class SymptomCheckerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Symptom Checker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Roboto',
      ),
      home: SymptomQuizScreen(),
    );
  }
}

class SymptomQuizScreen extends StatefulWidget {
  @override
  _SymptomQuizScreenState createState() => _SymptomQuizScreenState();
}

class _SymptomQuizScreenState extends State<SymptomQuizScreen> {
  List<String?> selectedAnswers = List.filled(5, null);

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Do you have a fever?',
      'answers': [
        {'text': 'High fever (>102°F/39°C)', 'disease': 'Flu'},
        {'text': 'Mild fever', 'disease': 'Common Cold'},
        {'text': 'No fever', 'disease': 'No Fever'},
      ],
    },
    {
      'question': 'Are you experiencing headaches?',
      'answers': [
        {'text': 'Severe, one-sided headache', 'disease': 'Migraine'},
        {'text': 'Mild headache', 'disease': 'Tension Headache'},
        {'text': 'No headache', 'disease': 'No Headache'},
      ],
    },
    {
      'question': 'Do you have any respiratory symptoms?',
      'answers': [
        {'text': 'Severe cough and shortness of breath', 'disease': 'Bronchitis'},
        {'text': 'Mild cough and runny nose', 'disease': 'Common Cold'},
        {'text': 'No respiratory symptoms', 'disease': 'No Respiratory Issues'},
      ],
    },
    {
      'question': 'How is your energy level?',
      'answers': [
        {'text': 'Severe fatigue', 'disease': 'Flu'},
        {'text': 'Mild tiredness', 'disease': 'Common Cold'},
        {'text': 'Normal energy', 'disease': 'No Fatigue'},
      ],
    },
    {
      'question': 'Are you experiencing any digestive issues?',
      'answers': [
        {'text': 'Nausea and vomiting', 'disease': 'Gastroenteritis'},
        {'text': 'Mild stomach discomfort', 'disease': 'Indigestion'},
        {'text': 'No digestive issues', 'disease': 'No Digestive Issues'},
      ],
    },
  ];

  final Map<String, Map<String, dynamic>> diseaseCures = {
    'Flu': {
      'name': 'Influenza',
      'symptoms': ['High fever', 'Body aches', 'Severe fatigue', 'Dry cough'],
      'cure': [
        'Get plenty of rest',
        'Stay hydrated',
        'Use fever reducers',
        'Use a humidifier to ease breathing'
      ],
      'prevention': [
        'Annual flu vaccination',
        'Regular hand washing',
        'Avoid close contact with sick people'
      ],
      'when_to_see_doctor': [
        'Difficulty breathing',
        'Fever above 103°F (39.4°C)',
        'Symptoms lasting more than 10 days'
      ],
      'severity': 'Moderate to Severe',
      'recovery_time': '1-2 weeks'
    },
    'Migraine': {
      'name': 'Migraine Headache',
      'symptoms': ['One-sided headache', 'Nausea', 'Light sensitivity'],
      'cure': [
        'Rest in a dark room',
        'Apply cold compresses',
        'Take migraine medications'
      ],
      'prevention': [
        'Avoid triggers',
        'Regular sleep schedule',
        'Manage stress'
      ],
      'when_to_see_doctor': [
        'Severe headache with fever',
        'Sudden, severe headache',
        'Progressive worsening symptoms'
      ],
      'severity': 'Moderate to Severe',
      'recovery_time': '4-72 hours'
    },
    'Bronchitis': {
      'name': 'Acute Bronchitis',
      'symptoms': ['Cough', 'Chest discomfort', 'Fatigue'],
      'cure': [
        'Rest and sleep',
        'Stay hydrated',
        'Use cough suppressants'
      ],
      'prevention': [
        'Avoid smoking',
        'Practice good hand hygiene',
        'Wear a mask in dusty environments'
      ],
      'when_to_see_doctor': [
        'Cough lasting more than 3 weeks',
        'High fever',
        'Blood in mucus'
      ],
      'severity': 'Moderate',
      'recovery_time': '2-3 weeks'
    },
  };

  String determineDisease() {
    Map<String, int> diseaseCount = {};

    for (String? answer in selectedAnswers.where((a) => a != null)) {
      if (answer != null) {
        diseaseCount[answer] = (diseaseCount[answer] ?? 0) + 1;
      }
    }

    String? mostLikelyDisease;
    int maxCount = 0;

    diseaseCount.forEach((disease, count) {
      if (count > maxCount && diseaseCures.containsKey(disease)) {
        maxCount = count;
        mostLikelyDisease = disease;
      }
    });

    return mostLikelyDisease ?? 'Undetermined';
  }
  void navigateToResultScreen() {
    String disease = determineDisease();
    if (diseaseCures.containsKey(disease)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailedResultScreen(
            diseaseData: diseaseCures[disease]!,
            diseaseName: disease,
          ),
        ),
      );
    } else {
      // Debugging message if disease isn't found
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No valid diagnosis found.'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptom Checker', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: selectedAnswers.where((a) => a != null).length / questions.length,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final questionData = questions[index];
                  bool isAnswered = selectedAnswers[index] != null;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(questionData['question'], style: TextStyle(fontSize: 18)),
                          ...questionData['answers'].map<Widget>((answer) {
                            return RadioListTile<String>(
                              title: Text(answer['text']),
                              value: answer['disease'],
                              groupValue: selectedAnswers[index],
                              onChanged: (value) {
                                setState(() {
                                  selectedAnswers[index] = value;
                                });
                              },
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedAnswers.contains(null)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please answer all questions.'),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                } else {
                  navigateToResultScreen();
                }
              },
              child: Text('Get Diagnosis'),
            ),
          ],
        ),
      ),
    );
  }
}
