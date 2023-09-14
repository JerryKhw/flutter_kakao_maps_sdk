import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kakao_maps_sdk/flutter_kakao_maps_sdk.dart';

class MapPoiView extends StatefulWidget {
  const MapPoiView({super.key});

  @override
  State<StatefulWidget> createState() => _MapPoiViewState();
}

class _MapPoiViewState extends State<MapPoiView> {
  late final KakaoMapController kakaoMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("지도 포이"),
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
                    await kakaoMapController.setPoiOptions(
                        poiOptions: const PoiOptions());
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("ENABLED"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.setPoiOptions(
                        poiOptions: const PoiOptions(enabled: false));
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("DISABLED"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.setPoiOptions(
                        poiOptions:
                            const PoiOptions(scale: KakaoMapPoiScale.small));
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("SMALL"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.setPoiOptions(
                        poiOptions:
                            const PoiOptions(scale: KakaoMapPoiScale.regular));
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("REGULAR"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.setPoiOptions(
                        poiOptions:
                            const PoiOptions(scale: KakaoMapPoiScale.large));
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("LARGE"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.setPoiOptions(
                        poiOptions:
                            const PoiOptions(scale: KakaoMapPoiScale.xLarge));
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("XLARGE"),
                ),
              ],
            ),
          );
        },
      ),
      body: KakaoMapView(
        options: const KakaoMapOptions(
          poiOptions: PoiOptions(
            clickable: true,
            enabled: true,
            scale: KakaoMapPoiScale.regular,
          ),
        ),
        onMapReady: (controller) => kakaoMapController = controller,
      ),
    );
  }
}
