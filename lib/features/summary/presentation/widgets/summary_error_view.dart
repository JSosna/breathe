import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/error/failure.dart';
import 'package:medcare_breathing/core/theme/spacings.dart';
import 'package:medcare_breathing/features/summary/presentation/cubit/summary_cubit.dart';
import 'package:medcare_breathing/i18n/translations.g.dart';

class SummaryErrorView extends StatelessWidget {
  const new({required this.failure, super.key});

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(switch (failure) {
          ParsingFailure() => context.t.summaryErrorParsing,
          NotFoundFailure() => context.t.summaryErrorNotFound,
          NetworkFailure() || StorageFailure() => context.t.summaryErrorNetwork,
        }, textAlign: TextAlign.center),
        const SizedBox(height: Spacings.sp16),
        FilledButton(
          onPressed: context.read<SummaryCubit>().load,
          child: Text(context.t.summaryRetry),
        ),
      ],
    );
  }
}
