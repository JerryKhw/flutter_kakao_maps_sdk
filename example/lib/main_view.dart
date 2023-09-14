import 'package:flutter/material.dart';
import 'package:flutter_kakao_maps_sdk_example/map_building_scale_view.dart';
import 'package:flutter_kakao_maps_sdk_example/map_compass_view.dart';
import 'package:flutter_kakao_maps_sdk_example/map_enabled_view.dart';
import 'package:flutter_kakao_maps_sdk_example/map_logo_view.dart';
import 'package:flutter_kakao_maps_sdk_example/map_move_view.dart';
import 'package:flutter_kakao_maps_sdk_example/map_overlay_view.dart';
import 'package:flutter_kakao_maps_sdk_example/map_poi_view.dart';
import 'package:flutter_kakao_maps_sdk_example/map_scale_bar_view.dart';
import 'package:flutter_kakao_maps_sdk_example/map_type_view.dart';
import 'package:flutter_kakao_maps_sdk_example/map_padding_view.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카카오 지도 예제'),
      ),
      body: const Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MainItem(
                    "지도 종류",
                    targetView: MapTypeView(),
                  ),
                  MainItem(
                    "지도 오버레이",
                    targetView: MapOverlayView(),
                  ),
                  MainItem(
                    "지도 활성화",
                    targetView: MapEnabledView(),
                  ),
                  MainItem(
                    "지도 빌딩 스케일",
                    targetView: MapBuildingScaleView(),
                  ),
                  MainItem(
                    "지도 패딩",
                    targetView: MapPaddingView(),
                  ),
                  MainItem(
                    "지도 로고",
                    targetView: MapLogoView(),
                  ),
                  MainItem(
                    "지도 포이",
                    targetView: MapPoiView(),
                  ),
                  MainItem(
                    "지도 나침반",
                    targetView: MapCompassView(),
                  ),
                  MainItem(
                    "지도 축척",
                    targetView: MapScaleBarView(),
                  ),
                  MainItem(
                    "지도 이동",
                    targetView: MapMoveView(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainItem extends StatelessWidget {
  final String text;
  final Widget targetView;

  const MainItem(
    this.text, {
    super.key,
    required this.targetView,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => targetView));
        },
        child: Text(text),
      ),
    );
  }
}
