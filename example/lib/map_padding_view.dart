import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kakao_maps_sdk/flutter_kakao_maps_sdk.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MapPaddingView extends StatefulWidget {
  const MapPaddingView({super.key});

  @override
  State<StatefulWidget> createState() => _MapPaddingViewState();
}

class _MapPaddingViewState extends State<MapPaddingView> {
  late final KakaoMapController kakaoMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("지도 패딩"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.list),
        onPressed: () {
          showCupertinoModalPopup(
            context: context,
            builder: (context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () async {
                    final padding = await kakaoMapController.getPadding();

                    Fluttertoast.showToast(
                      msg: "Padding: $padding",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );

                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("GetPadding"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.setPadding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 2, right: MediaQuery.of(context).size.width / 2),
                    );
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("SetPadding"),
                ),
              ],
            ),
          );
        },
      ),
      body: KakaoMapView(
        options: const KakaoMapOptions(
          padding: EdgeInsets.zero,
        ),
        onMapReady: (controller) => kakaoMapController = controller,
      ),
    );
  }
}
