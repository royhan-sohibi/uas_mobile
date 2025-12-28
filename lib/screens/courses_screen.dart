import 'package:flutter/material.dart';
import 'course_detail_screen.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kursus Saya'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Semua Kursus',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildCoursesList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCoursesList(BuildContext context) {
    final courses = [
      {
        'name': 'Pemrograman Web',
        'progress': 0.75,
        'completed': 15,
        'total': 20,
        'color': Colors.blue,
      },
      {
        'name': 'Basis Data',
        'progress': 0.60,
        'completed': 12,
        'total': 20,
        'color': Colors.green,
      },
      {
        'name': 'Matematika Diskrit',
        'progress': 0.40,
        'completed': 8,
        'total': 20,
        'color': Colors.purple,
      },
      {
        'name': 'Sistem Operasi',
        'progress': 0.85,
        'completed': 17,
        'total': 20,
        'color': Colors.orange,
      },
      {
        'name': 'Algoritma dan Struktur Data',
        'progress': 0.55,
        'completed': 11,
        'total': 20,
        'color': Colors.red,
      },
      {
        'name': 'Jaringan Komputer',
        'progress': 0.30,
        'completed': 6,
        'total': 20,
        'color': Colors.teal,
      },
      {
        'name': 'Rekayasa Perangkat Lunak',
        'progress': 0.65,
        'completed': 13,
        'total': 20,
        'color': Colors.indigo,
      },
    ];

    return Column(
      children: courses.map((course) => _buildCourseCard(
        context,
        name: course['name'] as String,
        progress: course['progress'] as double,
        completed: course['completed'] as int,
        total: course['total'] as int,
        color: course['color'] as Color,
      )).toList(),
    );
  }

  Widget _buildCourseCard(
    BuildContext context, {
    required String name,
    required double progress,
    required int completed,
    required int total,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDetailScreen(
                courseName: name,
                courseColor: color,
                progress: progress,
                completed: completed,
                total: total,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.book,
                      color: color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$completed dari $total materi selesai',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
