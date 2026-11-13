import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/theme/spacings.dart';
import 'package:medcare_breathing/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:medcare_breathing/features/onboarding/presentation/models/onboarding_slide.dart';
import 'package:medcare_breathing/features/onboarding/presentation/widgets/onboarding_back_button.dart';
import 'package:medcare_breathing/features/onboarding/presentation/widgets/onboarding_birth_date_input.dart';
import 'package:medcare_breathing/features/onboarding/presentation/widgets/onboarding_name_inputs.dart';
import 'package:medcare_breathing/features/onboarding/presentation/widgets/onboarding_primary_button.dart';
import 'package:medcare_breathing/features/onboarding/presentation/widgets/onboarding_slides_pager.dart';
import 'package:medcare_breathing/i18n/translations.g.dart';
import 'package:medcare_breathing/shared/mascot/mascot_slot.dart';
import 'package:medcare_breathing/shared/widgets/gaze_source.dart';
import 'package:medcare_breathing/shared/widgets/page_dots.dart';

class OnboardingView extends StatefulWidget {
  const new({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  static const _mascotFlex = 5;
  static const _textFlex = 3;
  static const _textFlexWithKeyboard = 2;
  static const _pageTransition = Duration(milliseconds: 450);

  final _pages = PageController();
  final _firstNameCaret = ValueNotifier<Offset?>(null);
  final _lastNameCaret = ValueNotifier<Offset?>(null);
  int _bounces = 0;

  @override
  void dispose() {
    _pages.dispose();
    _firstNameCaret.dispose();
    _lastNameCaret.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OnboardingCubit>().state;
    final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;
    final slide = OnboardingSlide.of(context, state);

    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (previous, current) =>
          previous.page != current.page ||
          (current.failure != null && previous.failure != current.failure),
      listener: _onStateChanged,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              Spacings.sp24,
              Spacings.sp8,
              Spacings.sp24,
              Spacings.sp24,
            ),
            child: Column(
              children: [
                const OnboardingBackButton(),
                Expanded(
                  flex: _mascotFlex,
                  child: MascotSlot(
                    mood: slide.mood,
                    tint: slide.tint,
                    focus: GazeSource(_firstNameCaret, _lastNameCaret),
                    bounces: _bounces,
                  ),
                ),
                Expanded(
                  flex: keyboardOpen ? _textFlexWithKeyboard : _textFlex,
                  child: OnboardingSlidesPager(
                    controller: _pages,
                    showBody: !keyboardOpen,
                  ),
                ),
                Visibility(
                  visible: state.page == OnboardingState.namePage,
                  maintainState: true,
                  child: OnboardingNameInputs(
                    firstNameCaret: _firstNameCaret,
                    lastNameCaret: _lastNameCaret,
                    onSubmitted: _bounce,
                  ),
                ),
                Visibility(
                  visible: state.page == OnboardingState.birthDatePage,
                  child: OnboardingBirthDateInput(onPicked: _bounce),
                ),
                PageDots(count: OnboardingState.pageCount, active: state.page),
                const SizedBox(height: Spacings.sp24),
                const OnboardingPrimaryButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _bounce() => setState(() => _bounces++);

  void _onStateChanged(BuildContext context, OnboardingState state) {
    if (_pages.hasClients && _pages.page?.round() != state.page) {
      _pages.animateToPage(
        state.page,
        duration: _pageTransition,
        curve: Curves.easeOutCubic,
      );
    }
    if (state.failure != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(context.t.onboardingSendError)));
    }
  }
}
