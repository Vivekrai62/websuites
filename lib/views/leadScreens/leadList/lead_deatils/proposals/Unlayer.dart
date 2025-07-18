import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:websuites/utils/appColors/app_colors.dart';
import 'package:websuites/utils/components/buttons/common_button.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class UnLayer extends StatefulWidget {
  const UnLayer({super.key});

  @override
  State<UnLayer> createState() => _UnLayerState();
}

class _UnLayerState extends State<UnLayer> {
  late final WebViewController _controller;
  Future<String>? _loadHtmlFuture;
  bool _isLoading = true;
  String _currentDesignHtml = '';

  final String _unlayerHtmlTemplate = '''
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Unlayer Editor</title>
      <style>
        html, body { margin: 0; padding: 0; height: 100%; }
        #unlayer-editor { height: 100%; }
      </style>
    </head>
    <body>
      <div id="unlayer-editor"></div>
      <script src="https://editor.unlayer.com/embed.js"></script>
      <script>
        unlayer.init({
          id: 'unlayer-editor',
          projectId: 273382,
          displayMode: 'email',
          user: {
            id: '{{USER_ID}}',
            apiKey: '{{API_KEY}}'
          }
        });

        window.addEventListener('message', function(event) {
          if (event.data && event.data.type === 'getDesignHtml') {
            unlayer.exportHtml(function(data) {
              window.FlutterWebView.postMessage(JSON.stringify({
                type: 'onDesignExported',
                html: data.html
              }));
            });
          }
        });

        window.addEventListener('unlayer-ready', function() {
          window.FlutterWebView.postMessage(JSON.stringify({
            type: 'onUnlayerReady',
            message: 'Unlayer editor is ready'
          }));
        });

        unlayer.addEventListener('design:updated', function() {
          unlayer.exportHtml(function(data) {
            window.FlutterWebView.postMessage(JSON.stringify({
              type: 'onDesignUpdated',
              html: data.html
            }));
          });
        });

        unlayer.addEventListener('error', function(error) {
          window.FlutterWebView.postMessage(JSON.stringify({
            type: 'onUnlayerError',
            error: JSON.stringify(error)
          }));
        });
      </script>
    </body>
    </html>
  ''';

  @override
  void initState() {
    super.initState();

    // Create platform-specific controller
    final PlatformWebViewControllerCreationParams params =
    WebViewPlatform.instance is WebKitWebViewPlatform
        ? WebKitWebViewControllerCreationParams(
      allowsInlineMediaPlayback: true,
      mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
    )
        : WebViewPlatform.instance is AndroidWebViewPlatform
        ? AndroidWebViewControllerCreationParams()
        : const PlatformWebViewControllerCreationParams();

    _controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..addJavaScriptChannel(
        'FlutterWebView',
        onMessageReceived: (JavaScriptMessage message) {
          _handleJsMessage(message.message);
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
          onWebResourceError: (error) {
            setState(() => _isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error loading editor: ${error.description}')),
            );
          },
        ),
      );

    _loadHtmlFuture = _loadHtmlContent();
  }

  void _handleJsMessage(String message) {
    try {
      final Map<String, dynamic> data = jsonDecode(message);
      final String type = data['type'];

      switch (type) {
        case 'onUnlayerReady':
          setState(() => _isLoading = false);
          break;
        case 'onDesignUpdated':
        case 'onDesignExported':
          setState(() {
            _currentDesignHtml = data['html'];
          });
          break;
        case 'onUnlayerError':
          final error = data['error'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Editor error: $error')),
          );
          break;
      }
    } catch (e) {
      debugPrint('Failed to handle JS message: $e');
    }
  }

  Future<String> _loadHtmlContent() async {
    const fallbackUserId = 'test_user_1';
    const fallbackApiKey = 'dJh5kiqfcZaEGrKoa5IoBotZtErBB1aEF3JDp7LLjys83IwZREFtMb1TgYk43WuK';
    String userId = fallbackUserId;
    String apiKey = fallbackApiKey;

    try {
      await dotenv.load(fileName: 'assets/.env');
      userId = dotenv.env['UNLAYER_USER_ID'] ?? fallbackUserId;
      apiKey = dotenv.env['UNLAYER_API_KEY'] ?? fallbackApiKey;
    } catch (_) {
      try {
        final content = await rootBundle.loadString('assets/.env');
        for (var line in content.split('\n')) {
          final parts = line.split('=');
          if (parts.length == 2) {
            if (parts[0].trim() == 'UNLAYER_USER_ID') userId = parts[1].trim();
            if (parts[0].trim() == 'UNLAYER_API_KEY') apiKey = parts[1].trim();
          }
        }
      } catch (_) {}
    }

    final html = _unlayerHtmlTemplate
        .replaceAll('{{USER_ID}}', userId)
        .replaceAll('{{API_KEY}}', apiKey);

    await _controller.loadHtmlString(html);
    return html;
  }

  Future<void> _getDesignHtml() async {
    await _controller.runJavaScript(
        "window.postMessage({type: 'getDesignHtml'}, '*');");
  }

  void _saveDesign() async {
    await _getDesignHtml();
    if (_currentDesignHtml.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Design saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu),

            const Text("Update Proposal Details"),

            CommonButton(
                color: AllColors.darkGreen,
                borderRadius: 30,
                height: 30,
                title: 'Save', onPress: (){

            })
          ],
        ),

      ),
      body: FutureBuilder<String>(
        future: _loadHtmlFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting || _isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading editor: ${snapshot.error}'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: WebViewWidget(controller: _controller),
            );

          }
        },
      ),

    );
  }
}

