import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kakao_maps_sdk/flutter_kakao_maps_sdk.dart';

class MapTypeView extends StatefulWidget {
  const MapTypeView({super.key});

  @override
  State<StatefulWidget> createState() => _MapTypeViewState();
}

class _MapTypeViewState extends State<MapTypeView> {
  late final KakaoMapController kakaoMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("지도 종류"),
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
                    await kakaoMapController.setViewInfo(viewInfoName: KakaoMapViewInfo.map);
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("MAP"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.setViewInfo(viewInfoName: KakaoMapViewInfo.skyview);
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("SKYVIEW"),
                ),
              ],
            ),
          );
        },
      ),
      body: KakaoMapView(
        options: const KakaoMapOptions(
          viewInfoName: KakaoMapViewInfo.map,
        ),
        onMapReady: (controller) => kakaoMapController = controller,
      ),
    );
  }
}
