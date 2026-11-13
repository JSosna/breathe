import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/extensions/context_extensions.dart';
import 'package:medcare_breathing/core/theme/app_theme.dart';
import 'package:medcare_breathing/features/user/domain/entities/person_name.dart';

class NameField extends StatefulWidget {
  const new({
    required this.label,
    required this.onChanged,
    required this.onCaretMoved,
    this.onSubmitted,
    this.textInputAction = TextInputAction.done,
    this.autofillHint,
    super.key,
  });

  final String label;
  final ValueChanged<String> onChanged;
  final ValueChanged<Offset?> onCaretMoved;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction textInputAction;
  final String? autofillHint;

  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final GlobalKey<State<StatefulWidget>> _fieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scheduleCaretUpdate);
    _focusNode.addListener(_scheduleCaretUpdate);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: _fieldKey,
      controller: _controller,
      focusNode: _focusNode,
      style: context.textTheme.titleMedium,
      maxLength: PersonName.maxLength,
      textCapitalization: TextCapitalization.words,
      textInputAction: widget.textInputAction,
      autofillHints: [?widget.autofillHint],
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      onTapOutside: (_) => _focusNode.unfocus(),
      decoration: InputDecoration(hintText: widget.label, counterText: ''),
    );
  }

  void _scheduleCaretUpdate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.onCaretMoved(_caretPosition());
    });
  }

  Offset? _caretPosition() {
    final box = _fieldKey.currentContext?.findRenderObject();
    if (!_focusNode.hasFocus || box is! RenderBox || !box.hasSize) return null;

    final selection = _controller.selection;
    final caretIndex = selection.isValid
        ? selection.extentOffset
        : _controller.text.length;
    final painter = TextPainter(
      text: TextSpan(
        text: _controller.text.substring(0, caretIndex),
        style: context.textTheme.titleMedium,
      ),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
    )..layout();
    const padding = AppTheme.inputPadding;
    final x = math.min(
      padding.left + painter.width,
      box.size.width - padding.right,
    );
    painter.dispose();
    return box.localToGlobal(Offset(x, box.size.height / 2));
  }
}
