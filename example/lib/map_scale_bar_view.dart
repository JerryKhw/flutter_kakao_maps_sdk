import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kakao_maps_sdk/flutter_kakao_maps_sdk.dart';

class MapScaleBarView extends StatefulWidget {
  const MapScaleBarView({super.key});

  @override
  State<StatefulWidget> createState() => _MapScaleBarViewState();
}

class _MapScaleBarViewState extends State<MapScaleBarView> {
  late final KakaoMapController kakaoMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("지도 축척"),
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
                    await kakaoMapController.setScaleBarOptions(
                      scaleBarOptions: const ScaleBarOptions(
                        enabled: true,
                        position: KakaoMapPosition(
                          alignment: KakaoMapAlignment.center,
                          x: 0,
                          y: 0,
                        ),
                      ),
                    );
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("ENABLED"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.setScaleBarOptions(
                      scaleBarOptions: const ScaleBarOptions(
                        enabled: false,
                        position: KakaoMapPosition(
                          alignment: KakaoMapAlignment.center,
                          x: 0,
                          y: 0,
                        ),
                      ),
                    );
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
          scaleBarOptions: ScaleBarOptions(
            enabled: false,
            position: KakaoMapPosition(
              alignment: KakaoMapAlignment.center,
              x: 0,
              y: 0,
            ),
            autoDisabled: true,
            fadeInOutOptions: FadeInOutOptions(
              fadeInTime: 300,
              fadeOutTime: 300,
              retentionTime: 3000,
            ),
          ),
        ),
        onMapReady: (controller) => kakaoMapController = controller,
      ),
    );
  }
}
