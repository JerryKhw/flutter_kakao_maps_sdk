import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kakao_maps_sdk/flutter_kakao_maps_sdk.dart';

class MapEnabledView extends StatefulWidget {
  const MapEnabledView({super.key});

  @override
  State<StatefulWidget> createState() => _MapEnabledViewState();
}

class _MapEnabledViewState extends State<MapEnabledView> {
  late final KakaoMapController kakaoMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("지도 활성화"),
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
                    await kakaoMapController.setEnabled(enabled: true);
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("ENABLED"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.setEnabled(enabled: false);
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("DISABLED"),
                ),
              ],
            ),
          );
        },
      ),
      body: KakaoMapView(
        options: const KakaoMapOptions(
          enabled: false,
        ),
        onMapReady: (controller) => kakaoMapController = controller,
      ),
    );
  }
}
