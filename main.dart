import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const SisasApp());
}

class SisasApp extends StatelessWidget {
  const SisasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'সিন্দাবাদ সাহিত্য সংসদ',
      theme: ThemeData(
        primaryColor: const Color(0xFF1B5E20), // Deep Green
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B5E20),
          primary: const Color(0xFF1B5E20),
          secondary: const Color(0xFFD32F2F), // Red Vibe
        ),
        useMaterial3: true,
      ),
      home: const MainBrowserScreen(),
    );
  }
}

class MainBrowserScreen extends StatefulWidget {
  const MainBrowserScreen({super.key});

  @override
  State<MainBrowserScreen> createState() => _MainBrowserScreenState();
}

class _MainBrowserScreenState extends State<MainBrowserScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  final String homeUrl = 'https://sisasbd.blogspot.com';
  final String quizUrl = 'https://sisasbd.blogspot.com/p/36julyquiz.html';

  final List<Map<String, dynamic>> menuItems = const [
    {
      'title': 'পরিচালনা পর্ষদ',
      'url': 'https://sisasbd.blogspot.com/p/blog-page_15.html',
      'icon': Icons.groups_rounded
    },
    {
      'title': 'লেখকবৃন্দ',
      'url': 'https://sisasbd.blogspot.com/p/blog-page_294.html',
      'icon': Icons.history_edu_rounded
    },
    {
      'title': 'নোটিশ/চিঠি',
      'url': 'https://sisasbd.blogspot.com/p/blog-page.html',
      'icon': Icons.campaign_rounded
    },
    {
      'title': 'কার্যক্রমসমূহ',
      'url': 'https://sisasbd.blogspot.com/p/blog-page_75.html',
      'icon': Icons.event_note_rounded
    },
    {
      'title': 'সিলেবাস',
      'url': 'https://sisasbd.blogspot.com/p/blog-page_72.html',
      'icon': Icons.menu_book_rounded
    },
    {
      'title': 'আমাদের সম্পর্কে',
      'url': 'https://sisasbd.blogspot.com/p/blog-page_10.html',
      'icon': Icons.info_rounded
    },
    {
      'title': 'আমাদের সাথে যোগাযোগ',
      'url': 'https://sisasbd.blogspot.com/p/blog-page_151.html',
      'icon': Icons.contact_support_rounded
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(homeUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'সিন্দাবাদ সাহিত্য সংসদ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1B5E20), // Deep Green
        elevation: 4,
        actions: [
          // Red Vibe Quiz Button
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD32F2F), // Crimson Red
                foregroundColor: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              onPressed: () {
                _controller.loadRequest(Uri.parse(quizUrl));
              },
              icon: const Icon(Icons.quiz_rounded, size: 18, color: Colors.yellowAccent),
              label: const Text(
                'কুইজ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () => _controller.reload(),
          ),
        ],
      ),
      // Side Drawer with Gradient Header (Green to Red Touch)
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1B5E20), Color(0xFFB71C1C)], // Green to Dark Red
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              accountName: const Text(
                'সিন্দাবাদ সাহিত্য সংসদ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              accountEmail: const Text('স্বাগতম আমাদের অফিসিয়াল অ্যাপে'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.auto_stories, color: Colors.red.shade800, size: 36),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_rounded, color: Color(0xFF1B5E20)),
              title: const Text('হোম', style: TextStyle(fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(context);
                _controller.loadRequest(Uri.parse(homeUrl));
              },
            ),
            ListTile(
              leading: const Icon(Icons.quiz_rounded, color: Color(0xFFD32F2F)),
              title: const Text('কুইজ প্রতিযোগিতা', style: TextStyle(fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(context);
                _controller.loadRequest(Uri.parse(quizUrl));
              },
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return ListTile(
                    leading: Icon(item['icon'], color: const Color(0xFF1B5E20)),
                    title: Text(item['title']),
                    onTap: () {
                      Navigator.pop(context);
                      _controller.loadRequest(Uri.parse(item['url']));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD32F2F)),
              ),
            ),
        ],
      ),
      // Navigation Bottom Bar
      bottomNavigationBar: Container(
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1B5E20)),
              onPressed: () async {
                if (await _controller.canGoBack()) {
                  await _controller.goBack();
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.home_rounded, color: Color(0xFFD32F2F), size: 28),
              onPressed: () {
                _controller.loadRequest(Uri.parse(homeUrl));
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF1B5E20)),
              onPressed: () async {
                if (await _controller.canGoForward()) {
                  await _controller.goForward();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
