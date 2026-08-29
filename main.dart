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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
          primary: const Color(0xFF1E88E5),
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

  // আপনার প্রদানকৃত সঠিক লিংকসমূহ
  final String homeUrl = 'https://sisasbd.blogspot.com';
  final String quizUrl = 'https://sisasbd.blogspot.com/p/36julyquiz.html';

  final List<Map<String, String>> menuItems = const [
    {'title': 'পরিচালনা পর্ষদ', 'url': 'https://sisasbd.blogspot.com/p/blog-page_15.html'},
    {'title': 'লেখকবৃন্দ', 'url': 'https://sisasbd.blogspot.com/p/blog-page_294.html'},
    {'title': 'নোটিশ/চিঠি', 'url': 'https://sisasbd.blogspot.com/p/blog-page.html'},
    {'title': 'কার্যক্রমসমূহ', 'url': 'https://sisasbd.blogspot.com/p/blog-page_75.html'},
    {'title': 'সিলেবাস', 'url': 'https://sisasbd.blogspot.com/p/blog-page_72.html'},
    {'title': 'আমাদের সম্পর্কে', 'url': 'https://sisasbd.blogspot.com/p/blog-page_10.html'},
    {'title': 'আমাদের সাথে যোগাযোগ', 'url': 'https://sisasbd.blogspot.com/p/blog-page_151.html'},
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
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 2,
        actions: [
          // কুইজ প্রতিযোগিতা বাটন (হোমের পাশে)
          TextButton.icon(
            onPressed: () {
              _controller.loadRequest(Uri.parse(quizUrl));
            },
            icon: const Icon(Icons.quiz, color: Colors.yellowAccent, size: 20),
            label: const Text(
              'কুইজ',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () => _controller.reload(),
          ),
        ],
      ),
      // ড্রয়ার মেনু
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'সিন্দাবাদ সাহিত্য সংসদ',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'মেনু থেকে পেজ নির্বাচন করুন',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.blue),
              title: const Text('হোম'),
              onTap: () {
                Navigator.pop(context);
                _controller.loadRequest(Uri.parse(homeUrl));
              },
            ),
            ListTile(
              leading: const Icon(Icons.quiz, color: Colors.orange),
              title: const Text('কুইজ প্রতিযোগিতা'),
              onTap: () {
                Navigator.pop(context);
                _controller.loadRequest(Uri.parse(quizUrl));
              },
            ),
            const Divider(),
            ...menuItems.map((item) {
              return ListTile(
                leading: const Icon(Icons.article_outlined, color: Colors.indigo),
                title: Text(item['title']!),
                onTap: () {
                  Navigator.pop(context);
                  _controller.loadRequest(Uri.parse(item['url']!));
                },
              );
            }),
          ],
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      // নেভিগেশন বটম বার
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () async {
                if (await _controller.canGoBack()) {
                  await _controller.goBack();
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.home_outlined),
              onPressed: () {
                _controller.loadRequest(Uri.parse(homeUrl));
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
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
