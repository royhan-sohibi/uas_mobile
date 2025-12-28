import 'package:flutter/material.dart';
import 'dart:convert';

class QuizScreen extends StatefulWidget {
  final String courseName;
  final String moduleTitle;
  final int moduleId;
  final Color courseColor;

  const QuizScreen({
    super.key,
    required this.courseName,
    required this.moduleTitle,
    required this.moduleId,
    required this.courseColor,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestion = 0;
  Map<int, int> _selectedAnswers = {};
  bool _quizCompleted = false;
  int _score = 0;

  // Fake JSON data for quiz
  List<Map<String, dynamic>> _getQuizQuestions() {
    const String jsonData = '''
    {
      "quizzes": {
        "1": [
          {
            "question": "Apa kepanjangan dari HTML?",
            "options": [
              "Hyper Text Markup Language",
              "High Tech Modern Language",
              "Home Tool Markup Language",
              "Hyperlinks and Text Markup Language"
            ],
            "correctAnswer": 0
          },
          {
            "question": "Tag HTML mana yang digunakan untuk membuat heading terbesar?",
            "options": ["<h6>", "<head>", "<h1>", "<heading>"],
            "correctAnswer": 2
          },
          {
            "question": "Apa fungsi tag <nav> dalam HTML5?",
            "options": [
              "Untuk navigasi halaman",
              "Untuk membuat navbar",
              "Untuk menu navigasi",
              "Semua benar"
            ],
            "correctAnswer": 3
          },
          {
            "question": "Tipe input mana yang baru di HTML5?",
            "options": ["text", "email", "submit", "button"],
            "correctAnswer": 1
          },
          {
            "question": "Tag mana yang digunakan untuk menyisipkan video?",
            "options": ["<media>", "<video>", "<movie>", "<embed>"],
            "correctAnswer": 1
          }
        ],
        "2": [
          {
            "question": "Apa kepanjangan dari CSS?",
            "options": [
              "Creative Style Sheets",
              "Cascading Style Sheets",
              "Computer Style Sheets",
              "Colorful Style Sheets"
            ],
            "correctAnswer": 1
          },
          {
            "question": "Selector mana yang memiliki prioritas tertinggi?",
            "options": ["Element", "Class", "ID", "Inline style"],
            "correctAnswer": 3
          },
          {
            "question": "Property mana yang mengatur jarak dalam border?",
            "options": ["margin", "padding", "border-spacing", "gap"],
            "correctAnswer": 1
          },
          {
            "question": "Apa fungsi dari display: flex?",
            "options": [
              "Membuat elemen fleksibel",
              "Mengaktifkan Flexbox layout",
              "Membuat grid layout",
              "Membuat elemen responsif"
            ],
            "correctAnswer": 1
          },
          {
            "question": "Unit mana yang relatif terhadap ukuran font parent?",
            "options": ["px", "em", "pt", "cm"],
            "correctAnswer": 1
          }
        ]
      }
    }
    ''';

    final Map<String, dynamic> data = json.decode(jsonData);
    final quizData = data['quizzes'][widget.moduleId.toString()];
    if (quizData != null) {
      return List<Map<String, dynamic>>.from(quizData);
    }
    return [];
  }

  void _submitQuiz() {
    final questions = _getQuizQuestions();
    int correctCount = 0;

    for (int i = 0; i < questions.length; i++) {
      if (_selectedAnswers[i] == questions[i]['correctAnswer']) {
        correctCount++;
      }
    }

    setState(() {
      _score = correctCount;
      _quizCompleted = true;
    });
  }

  void _retryQuiz() {
    setState(() {
      _currentQuestion = 0;
      _selectedAnswers.clear();
      _quizCompleted = false;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final questions = _getQuizQuestions();
    final totalQuestions = questions.length;

    if (_quizCompleted) {
      return _buildResultScreen(totalQuestions);
    }

    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Kuis'),
        ),
        body: const Center(
          child: Text('Kuis tidak tersedia untuk modul ini.'),
        ),
      );
    }

    final question = questions[_currentQuestion];
    final options = List<String>.from(question['options']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Kuis: ${widget.moduleTitle}'),
        backgroundColor: widget.courseColor,
      ),
      body: Column(
        children: [
          // Progress
          Container(
            padding: const EdgeInsets.all(16),
            color: widget.courseColor.withOpacity(0.1),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pertanyaan ${_currentQuestion + 1} dari $totalQuestions',
                      style: TextStyle(
                        color: widget.courseColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_selectedAnswers.length}/$totalQuestions dijawab',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: (_currentQuestion + 1) / totalQuestions,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(widget.courseColor),
                ),
              ],
            ),
          ),

          // Question Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Question
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: widget.courseColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      question['question'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Options
                  ...options.asMap().entries.map((entry) {
                    final index = entry.key;
                    final option = entry.value;
                    final isSelected = _selectedAnswers[_currentQuestion] == index;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedAnswers[_currentQuestion] = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? widget.courseColor.withOpacity(0.1)
                                : Colors.white,
                            border: Border.all(
                              color: isSelected
                                  ? widget.courseColor
                                  : Colors.grey[300]!,
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? widget.courseColor
                                      : Colors.grey[300],
                                ),
                                child: Center(
                                  child: Text(
                                    String.fromCharCode(65 + index), // A, B, C, D
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.grey[600],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: widget.courseColor,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          // Navigation Buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Previous Button
                if (_currentQuestion > 0)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _currentQuestion--;
                        });
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Sebelumnya'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                if (_currentQuestion > 0) const SizedBox(width: 16),

                // Next or Submit Button
                Expanded(
                  child: _currentQuestion < totalQuestions - 1
                      ? ElevatedButton.icon(
                          onPressed: _selectedAnswers[_currentQuestion] != null
                              ? () {
                                  setState(() {
                                    _currentQuestion++;
                                  });
                                }
                              : null,
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Selanjutnya'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.courseColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        )
                      : ElevatedButton.icon(
                          onPressed: _selectedAnswers.length == totalQuestions
                              ? _submitQuiz
                              : null,
                          icon: const Icon(Icons.check),
                          label: const Text('Selesai'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultScreen(int totalQuestions) {
    final percentage = (_score / totalQuestions * 100).toInt();
    final isPassed = percentage >= 70;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Kuis'),
        backgroundColor: widget.courseColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Result Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (isPassed ? Colors.green : Colors.red).withOpacity(0.1),
                ),
                child: Center(
                  child: Icon(
                    isPassed ? Icons.check_circle : Icons.cancel,
                    size: 80,
                    color: isPassed ? Colors.green : Colors.red,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Result Title
              Text(
                isPassed ? 'Selamat!' : 'Tetap Semangat!',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Score
              Text(
                'Nilai Anda',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: isPassed ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$_score dari $totalQuestions jawaban benar',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),

              // Pass/Fail Message
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: (isPassed ? Colors.green : Colors.orange).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isPassed ? Colors.green : Colors.orange,
                  ),
                ),
                child: Text(
                  isPassed
                      ? 'Anda telah lulus kuis ini! Nilai minimum 70%'
                      : 'Anda belum mencapai nilai minimum (70%). Coba lagi!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: isPassed ? Colors.green[800] : Colors.orange[800],
                  ),
                ),
              ),
              const SizedBox(height: 48),

              // Action Buttons
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _retryQuiz,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba Lagi'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.courseColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Kembali ke Materi'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
