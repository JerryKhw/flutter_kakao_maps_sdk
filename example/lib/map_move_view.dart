import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kakao_maps_sdk/flutter_kakao_maps_sdk.dart';

class MapMoveView extends StatefulWidget {
  const MapMoveView({super.key});

  @override
  State<StatefulWidget> createState() => _MapMoveViewState();
}

class _MapMoveViewState extends State<MapMoveView> {
  late final KakaoMapController kakaoMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("지도 이동"),
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
                    await kakaoMapController.moveCamera(
                      target: const KakaoMapPoint(
                          longitude: 126.972591728, latitude: 37.552987017),
                    );
                    // await kakaoMapController.animateCamera(
                    //   target: const KakaoMapPoint(longitude: 126.972591728, latitude: 37.552987017),
                    // );
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("서울역 이동"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.moveCamera(
                      target: const KakaoMapPoint(
                          longitude: 129.041418419, latitude: 35.115078556),
                    );
                    // await kakaoMapController.animateCamera(
                    //   target: const KakaoMapPoint(longitude: 129.041418419, latitude: 35.115078556),
                    // );
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("부산역 이동"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.moveCameraTransform(
                      point:
                          const KakaoMapPoint(longitude: 0, latitude: 0.000898),
                    );
                    // await kakaoMapController.animateCameraTransform(
                    //   point: const KakaoMapPoint(longitude: 0, latitude: 0.000898),
                    // );
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("상단 이동"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.moveCameraTransform(
                      point: const KakaoMapPoint(
                          longitude: 0, latitude: -0.000898),
                    );
                    // await kakaoMapController.animateCameraTransform(
                    //   point: const KakaoMapPoint(longitude: 0, latitude: -0.000898),
                    // );
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("하단 이동"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.moveCameraTransform(
                      point: const KakaoMapPoint(
                          longitude: -0.000898, latitude: 0),
                    );
                    // await kakaoMapController.animateCameraTransform(
                    //   point: const KakaoMapPoint(longitude: -0.000898, latitude: 0),
                    // );
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("왼쪽 이동"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    await kakaoMapController.moveCameraTransform(
                      point:
                          const KakaoMapPoint(longitude: 0.000898, latitude: 0),
                    );
                    // await kakaoMapController.animateCameraTransform(
                    //   point: const KakaoMapPoint(longitude: 0.000898, latitude: 0),
                    // );
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text("오른쪽 이동"),
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
