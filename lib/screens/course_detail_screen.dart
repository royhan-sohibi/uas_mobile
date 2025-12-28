import 'package:flutter/material.dart';
import 'dart:convert';
import 'theory_screen.dart';

class CourseDetailScreen extends StatelessWidget {
  final String courseName;
  final Color courseColor;
  final double progress;
  final int completed;
  final int total;

  const CourseDetailScreen({
    super.key,
    required this.courseName,
    required this.courseColor,
    required this.progress,
    required this.completed,
    required this.total,
  });

  // Fake JSON data for course details
  Map<String, dynamic> _getCourseData() {
    const String jsonData = '''
    {
      "courses": {
        "Pemrograman Web": {
          "description": "Pelajari dasar-dasar pengembangan web modern termasuk HTML, CSS, JavaScript, dan framework populer.",
          "instructor": "Dr. Budi Santoso",
          "duration": "12 Minggu",
          "level": "Pemula - Menengah",
          "modules": [
            {
              "id": 1,
              "title": "Pengenalan HTML5",
              "duration": "2 jam",
              "completed": true,
              "topics": ["Tag HTML", "Struktur Dokumen", "Form & Input"]
            },
            {
              "id": 2,
              "title": "CSS3 & Styling",
              "duration": "3 jam",
              "completed": true,
              "topics": ["Selector", "Box Model", "Flexbox", "Grid"]
            },
            {
              "id": 3,
              "title": "JavaScript Fundamental",
              "duration": "4 jam",
              "completed": true,
              "topics": ["Variabel", "Function", "DOM Manipulation"]
            },
            {
              "id": 4,
              "title": "Responsive Design",
              "duration": "2 jam",
              "completed": false,
              "topics": ["Media Queries", "Mobile First", "Bootstrap"]
            },
            {
              "id": 5,
              "title": "Framework Modern",
              "duration": "5 jam",
              "completed": false,
              "topics": ["React Basics", "Vue.js", "Angular"]
            }
          ]
        },
        "Basis Data": {
          "description": "Memahami konsep database relasional, SQL, normalisasi, dan manajemen database.",
          "instructor": "Prof. Siti Aminah",
          "duration": "10 Minggu",
          "level": "Menengah",
          "modules": [
            {
              "id": 1,
              "title": "Pengenalan Database",
              "duration": "2 jam",
              "completed": true,
              "topics": ["Konsep DBMS", "Relational Model", "ER Diagram"]
            },
            {
              "id": 2,
              "title": "SQL Dasar",
              "duration": "3 jam",
              "completed": true,
              "topics": ["SELECT", "INSERT", "UPDATE", "DELETE"]
            },
            {
              "id": 3,
              "title": "Normalisasi",
              "duration": "2 jam",
              "completed": true,
              "topics": ["1NF", "2NF", "3NF", "BCNF"]
            },
            {
              "id": 4,
              "title": "Join & Subquery",
              "duration": "3 jam",
              "completed": false,
              "topics": ["INNER JOIN", "OUTER JOIN", "Nested Query"]
            },
            {
              "id": 5,
              "title": "Indexing & Optimization",
              "duration": "2 jam",
              "completed": false,
              "topics": ["Index Types", "Query Optimization", "Performance"]
            }
          ]
        },
        "Sistem Operasi": {
          "description": "Mempelajari konsep dasar sistem operasi, manajemen proses, memori, dan file system.",
          "instructor": "Dr. Ahmad Wijaya",
          "duration": "14 Minggu",
          "level": "Menengah - Lanjut",
          "modules": [
            {
              "id": 1,
              "title": "Pengenalan Sistem Operasi",
              "duration": "2 jam",
              "completed": true,
              "topics": ["Arsitektur OS", "Kernel", "System Calls"]
            },
            {
              "id": 2,
              "title": "Manajemen Proses",
              "duration": "4 jam",
              "completed": true,
              "topics": ["Process States", "Scheduling", "Threading"]
            },
            {
              "id": 3,
              "title": "Sinkronisasi Proses",
              "duration": "3 jam",
              "completed": true,
              "topics": ["Semaphore", "Mutex", "Deadlock"]
            },
            {
              "id": 4,
              "title": "Manajemen Memori",
              "duration": "3 jam",
              "completed": true,
              "topics": ["Paging", "Segmentation", "Virtual Memory"]
            },
            {
              "id": 5,
              "title": "File System",
              "duration": "2 jam",
              "completed": false,
              "topics": ["File Organization", "Directory", "Disk Management"]
            }
          ]
        },
        "Matematika Diskrit": {
          "description": "Pelajari konsep matematika diskrit yang fundamental dalam ilmu komputer.",
          "instructor": "Dr. Lisa Permata",
          "duration": "12 Minggu",
          "level": "Pemula",
          "modules": [
            {
              "id": 1,
              "title": "Logika Proposisi",
              "duration": "3 jam",
              "completed": true,
              "topics": ["Proposisi", "Tabel Kebenaran", "Inferensi"]
            },
            {
              "id": 2,
              "title": "Teori Himpunan",
              "duration": "2 jam",
              "completed": true,
              "topics": ["Operasi Himpunan", "Diagram Venn", "Kardinalitas"]
            },
            {
              "id": 3,
              "title": "Relasi dan Fungsi",
              "duration": "3 jam",
              "completed": false,
              "topics": ["Relasi Biner", "Fungsi", "Komposisi"]
            },
            {
              "id": 4,
              "title": "Graf",
              "duration": "4 jam",
              "completed": false,
              "topics": ["Jenis Graf", "Tree", "Shortest Path"]
            },
            {
              "id": 5,
              "title": "Kombinatorik",
              "duration": "2 jam",
              "completed": false,
              "topics": ["Permutasi", "Kombinasi", "Prinsip Counting"]
            }
          ]
        }
      }
    }
    ''';

    final Map<String, dynamic> data = json.decode(jsonData);
    return data['courses'][courseName] ?? {};
  }

  @override
  Widget build(BuildContext context) {
    final courseData = _getCourseData();
    final modules = courseData['modules'] as List? ?? [];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Course Header
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                courseName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [courseColor, courseColor.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Icon(
                      Icons.book,
                      size: 60,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Course Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Card
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Progres Kursus',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${(progress * 100).toInt()}%',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: courseColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 10,
                              backgroundColor: Colors.grey[200],
                              valueColor: AlwaysStoppedAnimation<Color>(courseColor),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '$completed dari $total materi selesai',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Course Information
                  if (courseData.isNotEmpty) ...[
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tentang Kursus',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              courseData['description'] ?? '',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 16),
                            _buildInfoRow(Icons.person, 'Instruktur', courseData['instructor'] ?? ''),
                            const SizedBox(height: 8),
                            _buildInfoRow(Icons.access_time, 'Durasi', courseData['duration'] ?? ''),
                            const SizedBox(height: 8),
                            _buildInfoRow(Icons.signal_cellular_alt, 'Level', courseData['level'] ?? ''),
                          ],
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),

                  // Modules/Topics
                  const Text(
                    'Modul Pembelajaran',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Module List
                  ...modules.map((module) {
                    final isCompleted = module['completed'] ?? false;
                    final topics = module['topics'] as List? ?? [];
                    final moduleId = module['id'] ?? 0;
                    
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 2,
                      child: InkWell(
                        onTap: () {
                          // Navigate to theory screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TheoryScreen(
                                courseName: courseName,
                                moduleTitle: module['title'] ?? '',
                                moduleId: moduleId,
                                courseColor: courseColor,
                              ),
                            ),
                          );
                        },
                        child: ExpansionTile(
                          leading: CircleAvatar(
                            backgroundColor: isCompleted ? Colors.green : Colors.grey[300],
                            child: Icon(
                              isCompleted ? Icons.check : Icons.lock_outline,
                              color: isCompleted ? Colors.white : Colors.grey,
                            ),
                          ),
                          title: Text(
                            module['title'] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                module['duration'] ?? '',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (!isCompleted)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'Mulai Belajar',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Topik:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ...topics.map((topic) => Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          size: 8,
                                          color: courseColor,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(topic.toString()),
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
