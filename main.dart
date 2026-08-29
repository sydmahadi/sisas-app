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
          seedColor: const Color(0xFF1E88E5), // সুন্দর নীল থিম
          primary: const Color(0xFF1E88E5),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

// ------------------- হোম স্ক্রিন (ড্যাশবোর্ড UI) -------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // মেনুর ডাটা লিস্ট (এখানে ওয়েবসাইটের লিংকগুলো বসাবেন)
  final List<Map<String, dynamic>> menuItems = const [
    {
      'title': 'হোম পেজ',
      'icon': Icons.home_rounded,
      'color': Colors.blue,
      'url': 'https://sisasbd.blogspot.com/',
    },
    {
      'title': 'আমাদের সম্পর্কে',
      'icon': Icons.info_outline_rounded,
      'color': Colors.purple,
      'url': 'https://sisasbd.blogspot.com/p/about-us.html', // আপনার সঠিক লিংক দিন
    },
    {
      'title': 'কার্যক্রম / সেবা',
      'icon': Icons.design_services_rounded,
      'color': Colors.orange,
      'url': 'https://sisasbd.blogspot.com/p/services.html', // আপনার সঠিক লিংক দিন
    },
    {
      'title': 'সাহিত্য ও ব্লগ',
      'icon': Icons.article_rounded,
      'color': Colors.green,
      'url': 'https://sisasbd.blogspot.com/p/blog.html', // আপনার সঠিক লিংক দিন
    },
    {
      'title': 'যোগাযোগ',
      'icon': Icons.contact_support_rounded,
      'color': Colors.red,
      'url': 'https://sisasbd.blogspot.com/p/contact.html', // আপনার সঠিক লিংক দিন
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9), // ব্যাকগ্রাউন্ড কালার
      appBar: AppBar(
        title: const Text(
          'সিন্দাবাদ সাহিত্য সংসদ',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 4,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ওয়েলকাম ব্যানার
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade700, Colors.blue.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'সিন্দাবাদ সাহিত্য সংসদ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'আমাদের ওয়েবসাইট এবং সকল সাহিত্যিক কার্যক্রম অ্যাপেই ব্রাউজ করুন।',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'প্রধান মেনু',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            // মেনু কার্ড গ্রিড
            Expanded(
              child: GridView.builder(
                itemCount: menuItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // প্রতি লাইনে ২টি করে বাটন
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        // WebView স্ক্রিনে নিয়ে যাবে
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewScreen(
                              title: item['title'],
                              url: item['url'],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor:
                                  (item['color'] as Color).withOpacity(0.15),
                              child: Icon(
                                item['icon'],
                                size: 30,
                                color: item['color'],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              item['title'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- ওয়েবসাইট দেখানোর জন্য WebView স্ক্রিন -------------------
class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  const WebViewScreen({super.key, required this.title, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

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
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _controller.reload(),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(), // লোডিং ইন্ডিকেটর
            ),
        ],
      ),
    );
  }
}
