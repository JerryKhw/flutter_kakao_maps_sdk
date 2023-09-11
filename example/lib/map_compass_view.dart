import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kakao_maps_sdk/flutter_kakao_maps_sdk.dart';

class MapCompassView extends StatefulWidget {
  const MapCompassView({super.key});

  @override
  State<StatefulWidget> createState() => _MapCompassViewState();
}

class _MapCompassViewState extends State<MapCompassView> {
  late final KakaoMapController kakaoMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("지도 나침반"),
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
                    await kakaoMapController.setCompassOptions(
                      compassOptions: const CompassOptions(
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
                    await kakaoMapController.setCompassOptions(
                      compassOptions: const CompassOptions(
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
          compassOptions: CompassOptions(
            enabled: false,
            position: KakaoMapPosition(
              alignment: KakaoMapAlignment.center,
              x: 0,
              y: 0,
            ),
          ),
        ),
        onMapReady: (controller) => kakaoMapController = controller,
      ),
    );
  }
}
