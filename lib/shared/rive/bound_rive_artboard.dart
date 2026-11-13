import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcare_breathing/shared/rive/rive_file_cache.dart';
import 'package:rive/rive.dart' as rive;

class BoundRiveArtboard extends StatefulWidget {
  const new({
    required this.artboard,
    required this.onBound,
    required this.onUnbound,
    required this.placeholder,
    super.key,
  });

  final String artboard;
  final ValueChanged<rive.ViewModelInstance> onBound;
  final VoidCallback onUnbound;

  final Widget placeholder;

  @override
  State<BoundRiveArtboard> createState() => _BoundRiveArtboardState();
}

class _BoundRiveArtboardState extends State<BoundRiveArtboard> {
  rive.RiveWidgetController? _controller;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  @override
  void dispose() {
    widget.onUnbound();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    if (controller == null) return widget.placeholder;
    return rive.RiveWidget(controller: controller);
  }

  Future<void> _load() async {
    final file = await context.read<RiveFileCache>().file;
    if (!mounted || file == null) return;
    final controller = _bind(file);
    if (controller == null) return;
    setState(() => _controller = controller);
  }

  rive.RiveWidgetController? _bind(rive.File file) {
    rive.RiveWidgetController? controller;
    try {
      controller = rive.RiveWidgetController(
        file,
        artboardSelector: rive.ArtboardSelector.byName(widget.artboard),
      );
      widget.onBound(controller.dataBind(rive.DataBind.auto()));
      return controller;
    } on Object catch (error) {
      controller?.dispose();
      debugPrint('Rive artboard "${widget.artboard}" unavailable: $error');
      return null;
    }
  }
}
