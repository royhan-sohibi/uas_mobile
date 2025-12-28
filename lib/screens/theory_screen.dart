import 'package:flutter/material.dart';
import 'dart:convert';
import 'quiz_screen.dart';

class TheoryScreen extends StatefulWidget {
  final String courseName;
  final String moduleTitle;
  final int moduleId;
  final Color courseColor;

  const TheoryScreen({
    super.key,
    required this.courseName,
    required this.moduleTitle,
    required this.moduleId,
    required this.courseColor,
  });

  @override
  State<TheoryScreen> createState() => _TheoryScreenState();
}

class _TheoryScreenState extends State<TheoryScreen> {
  int _currentPage = 0;
  bool _showChapterNav = false;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Fake JSON data for theory pages
  List<Map<String, dynamic>> _getTheoryPages() {
    const String jsonData = '''
    {
      "modules": {
        "1": {
          "pages": [
            {
              "title": "Pengenalan HTML5",
              "content": "HTML5 adalah versi terbaru dari HTML (HyperText Markup Language), bahasa standar untuk membuat halaman web. HTML5 memperkenalkan banyak fitur baru yang membuat pengembangan web lebih mudah dan lebih kuat.\\n\\nHTML5 dirancang untuk menggantikan HTML 4, XHTML, dan HTML DOM Level 2. Tujuan utamanya adalah untuk meningkatkan bahasa dengan dukungan untuk multimedia terbaru sambil tetap mudah dibaca oleh manusia dan dipahami secara konsisten oleh komputer dan perangkat.",
              "image": "📄"
            },
            {
              "title": "Struktur Dokumen HTML5",
              "content": "Setiap dokumen HTML5 memiliki struktur dasar yang harus diikuti:\\n\\n<!DOCTYPE html>\\n<html>\\n  <head>\\n    <title>Judul Halaman</title>\\n  </head>\\n  <body>\\n    <h1>Heading Utama</h1>\\n    <p>Paragraf konten</p>\\n  </body>\\n</html>\\n\\nElemen-elemen penting:\\n• <!DOCTYPE html> - Deklarasi tipe dokumen\\n• <html> - Elemen root\\n• <head> - Metadata dan informasi\\n• <body> - Konten yang terlihat",
              "image": "🏗️"
            },
            {
              "title": "Tag HTML Semantic",
              "content": "HTML5 memperkenalkan tag semantic yang memberikan makna pada struktur halaman:\\n\\n• <header> - Bagian kepala halaman\\n• <nav> - Navigasi\\n• <main> - Konten utama\\n• <article> - Artikel mandiri\\n• <section> - Bagian tematik\\n• <aside> - Konten sampingan\\n• <footer> - Bagian bawah\\n\\nTag semantic membuat kode lebih mudah dibaca dan membantu SEO serta aksesibilitas.",
              "image": "🏷️"
            },
            {
              "title": "Form dan Input",
              "content": "HTML5 menyediakan berbagai tipe input baru untuk form:\\n\\n• <input type='email'> - Input email\\n• <input type='number'> - Input angka\\n• <input type='date'> - Pemilih tanggal\\n• <input type='color'> - Pemilih warna\\n• <input type='range'> - Slider\\n\\nAtribut baru:\\n• placeholder - Teks petunjuk\\n• required - Field wajib diisi\\n• pattern - Validasi dengan regex\\n• autofocus - Fokus otomatis",
              "image": "📝"
            },
            {
              "title": "Multimedia di HTML5",
              "content": "HTML5 mendukung multimedia tanpa plugin:\\n\\nVideo:\\n<video controls>\\n  <source src='video.mp4' type='video/mp4'>\\n</video>\\n\\nAudio:\\n<audio controls>\\n  <source src='audio.mp3' type='audio/mp3'>\\n</audio>\\n\\nCanvas untuk grafis:\\n<canvas id='myCanvas'></canvas>\\n\\nFitur ini menghilangkan kebutuhan Flash Player.",
              "image": "🎬"
            }
          ]
        },
        "2": {
          "pages": [
            {
              "title": "Pengenalan CSS3",
              "content": "CSS3 (Cascading Style Sheets Level 3) adalah bahasa stylesheet yang digunakan untuk mendesain tampilan halaman web. CSS3 adalah versi terbaru dari CSS yang menambahkan banyak fitur baru.\\n\\nCSS3 dibagi menjadi modul-modul terpisah, memungkinkan browser untuk mengimplementasikan fitur secara bertahap. Ini membuat pengembangan lebih fleksibel dan terstruktur.",
              "image": "🎨"
            },
            {
              "title": "Selector CSS",
              "content": "CSS menggunakan selector untuk menargetkan elemen HTML:\\n\\n• Element Selector: p { color: blue; }\\n• Class Selector: .header { font-size: 20px; }\\n• ID Selector: #logo { width: 100px; }\\n• Attribute Selector: [type='text'] { border: 1px solid; }\\n\\nCombinator:\\n• div p - Descendant\\n• div > p - Child\\n• div + p - Adjacent sibling\\n• div ~ p - General sibling",
              "image": "🎯"
            },
            {
              "title": "Box Model",
              "content": "Box Model adalah konsep fundamental dalam CSS yang mendefinisikan bagaimana elemen ditampilkan:\\n\\n📦 Content - Konten aktual\\n📏 Padding - Ruang dalam border\\n🔲 Border - Garis tepi\\n↔️ Margin - Ruang luar border\\n\\nbox-sizing: border-box;\\nMembuat perhitungan ukuran lebih mudah dengan memasukkan padding dan border dalam width/height.",
              "image": "📦"
            },
            {
              "title": "Flexbox Layout",
              "content": "Flexbox adalah sistem layout satu dimensi yang powerful:\\n\\nContainer Properties:\\n• display: flex;\\n• flex-direction: row | column\\n• justify-content: center | space-between\\n• align-items: center | stretch\\n\\nItem Properties:\\n• flex-grow: 1;\\n• flex-shrink: 1;\\n• flex-basis: auto;\\n• flex: 1 1 auto; (shorthand)\\n\\nFlexbox sempurna untuk membuat layout responsif.",
              "image": "📐"
            },
            {
              "title": "CSS Grid",
              "content": "CSS Grid adalah sistem layout dua dimensi:\\n\\n.container {\\n  display: grid;\\n  grid-template-columns: 1fr 2fr 1fr;\\n  grid-template-rows: auto;\\n  gap: 20px;\\n}\\n\\nProperties penting:\\n• grid-column: 1 / 3;\\n• grid-row: 1 / 2;\\n• grid-template-areas\\n• grid-auto-flow\\n\\nGrid ideal untuk layout halaman kompleks.",
              "image": "⚡"
            }
          ]
        }
      }
    }
    ''';

    final Map<String, dynamic> data = json.decode(jsonData);
    final moduleData = data['modules'][widget.moduleId.toString()];
    if (moduleData != null && moduleData['pages'] != null) {
      return List<Map<String, dynamic>>.from(moduleData['pages']);
    }
    return [];
  }

  void _goToQuiz() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizScreen(
          courseName: widget.courseName,
          moduleTitle: widget.moduleTitle,
          moduleId: widget.moduleId,
          courseColor: widget.courseColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = _getTheoryPages();
    final totalPages = pages.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.moduleTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              setState(() {
                _showChapterNav = !_showChapterNav;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main Content
          Column(
            children: [
              // Progress Indicator
              Container(
                padding: const EdgeInsets.all(16),
                color: widget.courseColor.withOpacity(0.1),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Halaman ${_currentPage + 1} dari $totalPages',
                          style: TextStyle(
                            color: widget.courseColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${(((_currentPage + 1) / totalPages) * 100).toInt()}%',
                          style: TextStyle(
                            color: widget.courseColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: (_currentPage + 1) / totalPages,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(widget.courseColor),
                    ),
                  ],
                ),
              ),

              // Page Content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: totalPages,
                  itemBuilder: (context, index) {
                    final page = pages[index];
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icon/Image placeholder
                          Center(
                            child: Text(
                              page['image'] ?? '📚',
                              style: const TextStyle(fontSize: 80),
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          // Title
                          Text(
                            page['title'] ?? '',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Content
                          Text(
                            page['content'] ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
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
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _currentPage > 0
                            ? () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            : null,
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Sebelumnya'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    // Next or Quiz Button
                    Expanded(
                      child: _currentPage < totalPages - 1
                          ? ElevatedButton.icon(
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              icon: const Icon(Icons.arrow_forward),
                              label: const Text('Selanjutnya'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: widget.courseColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            )
                          : ElevatedButton.icon(
                              onPressed: _goToQuiz,
                              icon: const Icon(Icons.quiz),
                              label: const Text('Mulai Kuis'),
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

          // Floating Chapter Navigation
          if (_showChapterNav)
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: widget.courseColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Daftar Bab',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                _showChapterNav = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: totalPages,
                        itemBuilder: (context, index) {
                          final page = pages[index];
                          final isCurrentPage = index == _currentPage;
                          
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: isCurrentPage
                                  ? widget.courseColor
                                  : Colors.grey[300],
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: isCurrentPage ? Colors.white : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              page['title'] ?? '',
                              style: TextStyle(
                                fontWeight: isCurrentPage
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isCurrentPage
                                    ? widget.courseColor
                                    : Colors.black,
                              ),
                            ),
                            trailing: isCurrentPage
                                ? Icon(Icons.play_arrow, color: widget.courseColor)
                                : null,
                            onTap: () {
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                              setState(() {
                                _showChapterNav = false;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
