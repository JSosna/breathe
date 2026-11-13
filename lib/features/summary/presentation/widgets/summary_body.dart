import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/features/summary/presentation/cubit/summary_cubit.dart';
import 'package:medcare_breathing/features/summary/presentation/widgets/summary_content.dart';
import 'package:medcare_breathing/features/summary/presentation/widgets/summary_error_view.dart';
import 'package:medcare_breathing/features/summary/presentation/widgets/summary_loading_view.dart';

class SummaryBody extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SummaryCubit>().state;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      child: switch (state) {
        SummaryLoading() => const SummaryLoadingView(),
        SummaryError(:final failure) => SummaryErrorView(failure: failure),
        SummaryLoaded(:final summary) => SummaryContent(summary: summary),
      },
    );
  }
}
