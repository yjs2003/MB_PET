import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class LinkScreen extends StatefulWidget {
  final String link;

  const LinkScreen({required this.link, Key? key}) : super(key: key);

  @override
  _LinkScreenState createState() => _LinkScreenState();
}

class _LinkScreenState extends State<LinkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(widget.link)),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                    javaScriptCanOpenWindowsAutomatically: true,
                    javaScriptEnabled: true,
                    useOnDownloadStart: true,
                    useOnLoadResource: true,
                    useShouldOverrideUrlLoading: true,
                    mediaPlaybackRequiresUserGesture: true,
                    allowFileAccessFromFileURLs: true,
                    allowUniversalAccessFromFileURLs: true,
                    verticalScrollBarEnabled: true,
                    userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.122 Safari/537.36'
                ),
                android: AndroidInAppWebViewOptions(
                    useHybridComposition: true,
                    allowContentAccess: true,
                    builtInZoomControls: true,
                    thirdPartyCookiesEnabled: true,
                    allowFileAccess: true,
                    supportMultipleWindows: true
                ),
                ios: IOSInAppWebViewOptions(
                  allowsInlineMediaPlayback: true,
                  allowsBackForwardNavigationGestures: true,
                ),
              ),
              onCreateWindow: (controller, createWindowRequest) async{
                showDialog(
                  context: context, builder: (context) {
                  return AlertDialog(
                    content: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      child: InAppWebView(
                        // Setting the windowId property is important here!
                        windowId: createWindowRequest.windowId,
                        initialOptions: InAppWebViewGroupOptions(
                          android: AndroidInAppWebViewOptions(
                            builtInZoomControls: true,
                            thirdPartyCookiesEnabled: true,
                          ),
                          crossPlatform: InAppWebViewOptions(
                              cacheEnabled: true,
                              javaScriptEnabled: true,
                              userAgent: "Mozilla/5.0 (Linux; Android 9; LG-H870 Build/PKQ1.190522.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.106 Mobile Safari/537.36"
                          ),
                          ios: IOSInAppWebViewOptions(
                            allowsInlineMediaPlayback: true,
                            allowsBackForwardNavigationGestures: true,
                          ),
                        ),
                        onCloseWindow: (controller) async{
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),);
                },
                );
                return true;
              },
            )));
  }
}
