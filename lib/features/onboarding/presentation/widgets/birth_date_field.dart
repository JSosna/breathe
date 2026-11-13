import 'dart:async';

import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/extensions/context_extensions.dart';
import 'package:medcare_breathing/core/theme/app_theme.dart';
import 'package:medcare_breathing/core/theme/radius.dart';
import 'package:medcare_breathing/features/user/domain/entities/birth_date_rules.dart';

class BirthDateField extends StatelessWidget {
  const new({
    required this.label,
    required this.value,
    required this.today,
    required this.onChanged,
    super.key,
  });

  static const _initialAge = 30;

  final String label;
  final DateTime? value;
  final DateTime today;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final value = this.value;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final radius = BorderRadius.circular(Radius.r12);

    return Material(
      color: context.palette.surface,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: () => unawaited(_pick(context)),
        child: Padding(
          padding: AppTheme.inputPadding,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value == null
                      ? label
                      : DateFormat.yMMMMd(locale).format(value),
                  style: context.textTheme.titleMedium?.copyWith(
                    color: value == null
                        ? context.palette.inkMuted
                        : context.palette.ink,
                    fontWeight: value == null ? FontWeight.w400 : null,
                  ),
                ),
              ),
              Icon(Icons.cake_outlined, color: context.palette.inkMuted),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pick(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate:
          value ?? DateTime(today.year - _initialAge, today.month, today.day),
      firstDate: BirthDateRules.earliest(today),
      lastDate: today,
      initialDatePickerMode: DatePickerMode.year,
      helpText: label,
    );

    if (picked != null) onChanged(picked);
  }
}
