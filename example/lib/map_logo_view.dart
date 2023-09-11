import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kakao_maps_sdk/flutter_kakao_maps_sdk.dart';

class MapLogoView extends StatefulWidget {
  const MapLogoView({super.key});

  @override
  State<StatefulWidget> createState() => _MapLogoViewState();
}

class _MapLogoViewState extends State<MapLogoView> {
  late final KakaoMapController kakaoMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("지도 로고"),
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
                    await kakaoMapController.setLogoPosition(logoPosition: const KakaoMapPosition(alignment: KakaoMapAlignment.topLeft, x: 0, y: 0));
                    await kakaoMapController.refresh();
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("TopLeft"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.setLogoPosition(
                        logoPosition: const KakaoMapPosition(alignment: KakaoMapAlignment.topCenter, x: 0, y: 0));
                    await kakaoMapController.refresh();
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("TopCenter"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.setLogoPosition(logoPosition: const KakaoMapPosition(alignment: KakaoMapAlignment.topRight, x: 0, y: 0));
                    await kakaoMapController.refresh();
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("TopRight"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.setLogoPosition(
                        logoPosition: const KakaoMapPosition(alignment: KakaoMapAlignment.centerLeft, x: 0, y: 0));
                    await kakaoMapController.refresh();
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("CenterLeft"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.setLogoPosition(logoPosition: const KakaoMapPosition(alignment: KakaoMapAlignment.center, x: 0, y: 0));
                    await kakaoMapController.refresh();
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("Center"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.setLogoPosition(
                        logoPosition: const KakaoMapPosition(alignment: KakaoMapAlignment.centerRight, x: 0, y: 0));
                    await kakaoMapController.refresh();
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("CenterRight"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.setLogoPosition(
                        logoPosition: const KakaoMapPosition(alignment: KakaoMapAlignment.bottomLeft, x: 0, y: 0));
                    await kakaoMapController.refresh();
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("BottomLeft"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.setLogoPosition(
                        logoPosition: const KakaoMapPosition(alignment: KakaoMapAlignment.bottomCenter, x: 0, y: 0));
                    await kakaoMapController.refresh();
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("BottomCenter"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.setLogoPosition(
                        logoPosition: const KakaoMapPosition(alignment: KakaoMapAlignment.bottomRight, x: 0, y: 0));
                    await kakaoMapController.refresh();
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("BottomRight"),
                ),
              ],
            ),
          );
        },
      ),
      body: KakaoMapView(
        options: const KakaoMapOptions(
          logoPosition: KakaoMapPosition(
            alignment: KakaoMapAlignment.bottomRight,
            x: 0,
            y: 0,
          ),
        ),
        onMapReady: (controller) => kakaoMapController = controller,
      ),
    );
  }
}
