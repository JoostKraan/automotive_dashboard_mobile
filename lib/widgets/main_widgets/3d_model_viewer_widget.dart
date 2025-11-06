import 'package:flutter/material.dart';
import 'package:three_js/three_js.dart' as three;

class ModelViewerWidget extends StatefulWidget {
  const ModelViewerWidget({super.key});

  @override
  State<ModelViewerWidget> createState() => _ModelViewerWidgetState();
}

class _ModelViewerWidgetState extends State<ModelViewerWidget> {
  late three.ThreeJS threeJs;
  three.AnimationMixer? mixer;
  List<three.AnimationAction> actions = [];
  List<String> animationNames = [];
  three.Object3D? modelRoot;

  // Headlight controls
  bool headlightsOn = false;
  three.SpotLight? leftHeadlight;
  three.SpotLight? rightHeadlight;

  // Camera position
  double cameraX = 2.8;
  double cameraY = 2.2;
  double cameraZ = 6.5;

  @override
  void initState() {
    super.initState();

    threeJs = three.ThreeJS(
      onSetupComplete: () {
        setState(() {});
      },
      setup: setup,
    );
  }

  Future<void> setup() async {
    // Camera
    threeJs.camera = three.PerspectiveCamera(25, 300 / 225, 0.1, 2000);
    threeJs.camera.position.setValues(cameraX, cameraY, cameraZ);
    threeJs.camera.lookAt(three.Vector3(0, 0.7, 0.56));

    // Scene
    threeJs.scene = three.Scene();
    threeJs.scene.background = three.Color(
      23 / 255,
      23 / 255,
      22 / 255,
      255 / 255,
    );

    // Lights
    final ambientLight = three.AmbientLight(0xffffff, 0.6);
    threeJs.scene.add(ambientLight);

    final directionalLight = three.DirectionalLight(0xffffff, 2);
    directionalLight.position.setValues(5, 10, 7);
    threeJs.scene.add(directionalLight);

    // Load GLB model
    final loader = three.GLTFLoader(flipY: true).setPath('assets/models/');

    try {
      final gltfData = await loader.fromAsset('CleanedEscort.glb');
      if (gltfData == null) {
        debugPrint('Failed to load CleanedEscort.glb');
        return;
      }

      modelRoot = gltfData.scene;
      modelRoot!.position.setValues(0, 0, 0);
      threeJs.scene.add(modelRoot!);

      // Setup animations
      final animations = gltfData.animations;
      if (animations != null && animations.isNotEmpty) {
        mixer = three.AnimationMixer(modelRoot!);
        for (var clip in animations) {
          final action = mixer!.clipAction(clip)!;
          action.loop = three.LoopRepeat;
          actions.add(action);
          animationNames.add(
            clip.name.isNotEmpty
                ? clip.name
                : 'anim #${animationNames.length + 1}',
          );
        }
      }

      setState(() {});

      // Animation loop
      threeJs.addAnimationEvent((dt) {
        if (mixer != null) mixer!.update(dt);
      });
    } catch (e, stackTrace) {
      debugPrint('Error loading model: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }

  @override
  void dispose() {
    for (final a in actions) {
      try {
        a.stop();
      } catch (_) {}
    }
    mixer?.dispose();
    threeJs.dispose();
    three.loading.clear();
    super.dispose();
  }

  void playAnimation(int index) {
    if (index < 0 || index >= actions.length) return;
    final action = actions[index];
    action.setLoop(0, 0);
    action.clampWhenFinished = true;
    action.reset();
    action.fadeIn(0.2);
    action.play();
    setState(() {});
  }

  void stopAnimation(int index) {
    if (index < 0 || index >= actions.length) return;
    final action = actions[index];
    action.fadeOut(0.2);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [threeJs.build()]);
  }
}
