///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsEn extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsEn _root = this; // ignore: unused_field

	@override 
	TranslationsEn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEn(meta: meta ?? this.$meta);

	// Translations
	@override String get appTitle => 'Oddech';
	@override String get onboardingTitle1 => 'Hi, I\'m Oddech';
	@override String get onboardingBody1 => 'What\'s your name? Type your first and last name and I\'ll watch you type.';
	@override String onboardingGreeting({required String name}) => 'Nice to meet you, ${name}!';
	@override String get onboardingTitle2 => 'When is your birthday?';
	@override String get onboardingBody2 => 'I need your date of birth to work out your age. Tap Next to save your profile.';
	@override String get onboardingTitle3 => 'Pick a goal';
	@override String get onboardingBody3 => 'The goal sets the bubble color and the summary text. You can change it anytime.';
	@override String get onboardingNext => 'Next';
	@override String get onboardingStart => 'Let\'s start';
	@override String get setupTitle => 'Your session';
	@override String get setupSubtitle => 'Breathe with the bubble. Changes apply right away.';
	@override String get paceLabel => 'Pace';
	@override String paceValue({required int count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: '${count} breath per minute',
		other: '${count} breaths per minute',
	);
	@override String rhythmValue({required String inhale, required String exhale}) => 'Inhale ${inhale} s · exhale ${exhale} s';
	@override String get durationLabel => 'Duration';
	@override String durationValue({required int minutes}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(minutes,
		one: '${minutes} minute',
		other: '${minutes} minutes',
	);
	@override String get goalLabel => 'Goal';
	@override String get goalRelax => 'Relax';
	@override String get goalFocus => 'Focus';
	@override String get goalSleep => 'Sleep';
	@override String get inhale => 'Inhale';
	@override String get exhale => 'Exhale';
	@override String get showSummary => 'Summary';
	@override String get summaryTitle => 'Summary';
	@override String get summaryLoading => 'Loading your profile...';
	@override String get summaryErrorNetwork => 'Couldn\'t reach the server.';
	@override String get summaryErrorParsing => 'The server sent invalid data.';
	@override String get summaryRetry => 'Try again';
	@override String summaryGreeting({required String name}) => '${name}, your session plan';
	@override String summaryAge({required int age}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(age,
		one: '${age} year',
		other: '${age} years',
	);
	@override String get summaryAgeLabel => 'Age';
	@override String get summaryBreathsLabel => 'Breaths in session';
	@override String get summaryDurationLabel => 'Minutes';
	@override String get summaryPaceLabel => 'Per minute';
	@override String get summaryMessageDeepCalm => 'A slow pace. Good for winding down after a long day.';
	@override String get summaryMessageRelax => 'A good short break. For deeper calm, try a slightly slower pace.';
	@override String get summaryMessageFocus => 'A steady pace will help you focus before work.';
	@override String get summaryMessageSleep => 'A longer exhale will help you settle down before sleep.';
	@override String get summaryEdit => 'Change settings';
	@override String get riveUnavailable => 'Animation unavailable';
	@override String get onboardingFirstNameLabel => 'First name';
	@override String get onboardingLastNameLabel => 'Last name';
	@override String get onboardingBirthDateLabel => 'Date of birth';
	@override String onboardingAgeLine({required String age}) => 'You\'re ${age} old. Tap Next to save your profile.';
	@override String get onboardingSending => 'Saving...';
	@override String get onboardingSendError => 'Couldn\'t save your profile. Please try again.';
	@override String get onboardingBack => 'Back';
	@override String get summaryErrorNotFound => 'Your profile wasn\'t found.';
	@override String get mascotLabel => 'Oddech, your breathing buddy';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEn {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appTitle' => 'Oddech',
			'onboardingTitle1' => 'Hi, I\'m Oddech',
			'onboardingBody1' => 'What\'s your name? Type your first and last name and I\'ll watch you type.',
			'onboardingGreeting' => ({required String name}) => 'Nice to meet you, ${name}!',
			'onboardingTitle2' => 'When is your birthday?',
			'onboardingBody2' => 'I need your date of birth to work out your age. Tap Next to save your profile.',
			'onboardingTitle3' => 'Pick a goal',
			'onboardingBody3' => 'The goal sets the bubble color and the summary text. You can change it anytime.',
			'onboardingNext' => 'Next',
			'onboardingStart' => 'Let\'s start',
			'setupTitle' => 'Your session',
			'setupSubtitle' => 'Breathe with the bubble. Changes apply right away.',
			'paceLabel' => 'Pace',
			'paceValue' => ({required int count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: '${count} breath per minute', other: '${count} breaths per minute', ), 
			'rhythmValue' => ({required String inhale, required String exhale}) => 'Inhale ${inhale} s · exhale ${exhale} s',
			'durationLabel' => 'Duration',
			'durationValue' => ({required int minutes}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(minutes, one: '${minutes} minute', other: '${minutes} minutes', ), 
			'goalLabel' => 'Goal',
			'goalRelax' => 'Relax',
			'goalFocus' => 'Focus',
			'goalSleep' => 'Sleep',
			'inhale' => 'Inhale',
			'exhale' => 'Exhale',
			'showSummary' => 'Summary',
			'summaryTitle' => 'Summary',
			'summaryLoading' => 'Loading your profile...',
			'summaryErrorNetwork' => 'Couldn\'t reach the server.',
			'summaryErrorParsing' => 'The server sent invalid data.',
			'summaryRetry' => 'Try again',
			'summaryGreeting' => ({required String name}) => '${name}, your session plan',
			'summaryAge' => ({required int age}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(age, one: '${age} year', other: '${age} years', ), 
			'summaryAgeLabel' => 'Age',
			'summaryBreathsLabel' => 'Breaths in session',
			'summaryDurationLabel' => 'Minutes',
			'summaryPaceLabel' => 'Per minute',
			'summaryMessageDeepCalm' => 'A slow pace. Good for winding down after a long day.',
			'summaryMessageRelax' => 'A good short break. For deeper calm, try a slightly slower pace.',
			'summaryMessageFocus' => 'A steady pace will help you focus before work.',
			'summaryMessageSleep' => 'A longer exhale will help you settle down before sleep.',
			'summaryEdit' => 'Change settings',
			'riveUnavailable' => 'Animation unavailable',
			'onboardingFirstNameLabel' => 'First name',
			'onboardingLastNameLabel' => 'Last name',
			'onboardingBirthDateLabel' => 'Date of birth',
			'onboardingAgeLine' => ({required String age}) => 'You\'re ${age} old. Tap Next to save your profile.',
			'onboardingSending' => 'Saving...',
			'onboardingSendError' => 'Couldn\'t save your profile. Please try again.',
			'onboardingBack' => 'Back',
			'summaryErrorNotFound' => 'Your profile wasn\'t found.',
			'mascotLabel' => 'Oddech, your breathing buddy',
			_ => null,
		};
	}
}
