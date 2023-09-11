import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kakao_maps_sdk/flutter_kakao_maps_sdk.dart';

class MapBuildingScaleView extends StatefulWidget {
  const MapBuildingScaleView({super.key});

  @override
  State<StatefulWidget> createState() => _MapBuildingScaleViewState();
}

class _MapBuildingScaleViewState extends State<MapBuildingScaleView> {
  late final KakaoMapController kakaoMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("지도 빌딩 스케일"),
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
                    await kakaoMapController.setBuildingScale(buildingScale: 1);
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("1"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.setBuildingScale(buildingScale: 0);
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("0"),
                ),
              ],
            ),
          );
        },
      ),
      body: KakaoMapView(
        options: const KakaoMapOptions(
          buildingScale: 1,
        ),
        onMapReady: (controller) => kakaoMapController = controller,
      ),
    );
  }
}
