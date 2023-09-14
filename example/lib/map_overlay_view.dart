import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kakao_maps_sdk/flutter_kakao_maps_sdk.dart';

class MapOverlayView extends StatefulWidget {
  const MapOverlayView({super.key});

  @override
  State<StatefulWidget> createState() => _MapOverlayViewState();
}

class _MapOverlayViewState extends State<MapOverlayView> {
  late final KakaoMapController kakaoMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("지도 오버레이"),
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
                    await kakaoMapController.showOverlay(
                        overlay: KakaoMapOverlay.hybrid);
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("SHOW HYBRID"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.hideOverlay(
                        overlay: KakaoMapOverlay.hybrid);
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("HIDE HYBRID"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.showOverlay(
                        overlay: KakaoMapOverlay.roadviewLine);
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("SHOW ROADVIEWLINE"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.hideOverlay(
                        overlay: KakaoMapOverlay.roadviewLine);
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("HIDE ROADVIEWLINE"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.showOverlay(
                        overlay: KakaoMapOverlay.hillshading);
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("SHOW HILLSHADING"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.hideOverlay(
                        overlay: KakaoMapOverlay.hillshading);
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("HIDE HILLSHADING"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.showOverlay(
                        overlay: KakaoMapOverlay.bicycleRoad);
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("SHOW BICYCLEROAD"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.hideOverlay(
                        overlay: KakaoMapOverlay.bicycleRoad);
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("HIDE BICYCLEROAD"),
                ),
              ],
            ),
          );
        },
      ),
      body: KakaoMapView(
        options: const KakaoMapOptions(
          overlay: null,
        ),
        onMapReady: (controller) => kakaoMapController = controller,
      ),
    );
  }
}
