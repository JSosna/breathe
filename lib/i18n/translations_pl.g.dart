///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsPl = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.pl,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <pl>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	dynamic operator[](String key) => _meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// pl: 'Oddech'
	String get appTitle => 'Oddech';

	/// pl: 'Cześć, jestem Oddech'
	String get onboardingTitle1 => 'Cześć, jestem Oddech';

	/// pl: 'Jak masz na imię? Wpisz imię i nazwisko, a ja będę zerkać, co piszesz.'
	String get onboardingBody1 => 'Jak masz na imię? Wpisz imię i nazwisko, a ja będę zerkać, co piszesz.';

	/// pl: 'Miło Cię poznać, {name: String}!'
	String onboardingGreeting({required String name}) => 'Miło Cię poznać, ${name}!';

	/// pl: 'Kiedy masz urodziny?'
	String get onboardingTitle2 => 'Kiedy masz urodziny?';

	/// pl: 'Z daty urodzenia policzę Twój wiek. Po kliknięciu „Dalej” zapiszę profil.'
	String get onboardingBody2 => 'Z daty urodzenia policzę Twój wiek. Po kliknięciu „Dalej” zapiszę profil.';

	/// pl: 'Wybierz cel'
	String get onboardingTitle3 => 'Wybierz cel';

	/// pl: 'Cel zmienia kolor bańki i treść podsumowania. Możesz go zmienić w każdej chwili.'
	String get onboardingBody3 => 'Cel zmienia kolor bańki i treść podsumowania. Możesz go zmienić w każdej chwili.';

	/// pl: 'Dalej'
	String get onboardingNext => 'Dalej';

	/// pl: 'Zaczynamy'
	String get onboardingStart => 'Zaczynamy';

	/// pl: 'Twoja sesja'
	String get setupTitle => 'Twoja sesja';

	/// pl: 'Oddychaj w rytmie bańki. Zmiany widać od razu.'
	String get setupSubtitle => 'Oddychaj w rytmie bańki. Zmiany widać od razu.';

	/// pl: 'Tempo'
	String get paceLabel => 'Tempo';

	/// pl: '(one) {{count: int} oddech na minutę} (few) {{count: int} oddechy na minutę} (many) {{count: int} oddechów na minutę} (other) {{count: int} oddechu na minutę}'
	String paceValue({required int count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pl'))(count,
		one: '${count} oddech na minutę',
		few: '${count} oddechy na minutę',
		many: '${count} oddechów na minutę',
		other: '${count} oddechu na minutę',
	);

	/// pl: 'Wdech {inhale: String} s · wydech {exhale: String} s'
	String rhythmValue({required String inhale, required String exhale}) => 'Wdech ${inhale} s · wydech ${exhale} s';

	/// pl: 'Czas'
	String get durationLabel => 'Czas';

	/// pl: '(one) {{minutes: int} minuta} (few) {{minutes: int} minuty} (many) {{minutes: int} minut} (other) {{minutes: int} minuty}'
	String durationValue({required int minutes}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pl'))(minutes,
		one: '${minutes} minuta',
		few: '${minutes} minuty',
		many: '${minutes} minut',
		other: '${minutes} minuty',
	);

	/// pl: 'Cel'
	String get goalLabel => 'Cel';

	/// pl: 'Relaks'
	String get goalRelax => 'Relaks';

	/// pl: 'Skupienie'
	String get goalFocus => 'Skupienie';

	/// pl: 'Sen'
	String get goalSleep => 'Sen';

	/// pl: 'Wdech'
	String get inhale => 'Wdech';

	/// pl: 'Wydech'
	String get exhale => 'Wydech';

	/// pl: 'Podsumowanie'
	String get showSummary => 'Podsumowanie';

	/// pl: 'Podsumowanie'
	String get summaryTitle => 'Podsumowanie';

	/// pl: 'Wczytuję profil...'
	String get summaryLoading => 'Wczytuję profil...';

	/// pl: 'Nie udało się połączyć z serwerem.'
	String get summaryErrorNetwork => 'Nie udało się połączyć z serwerem.';

	/// pl: 'Serwer zwrócił nieprawidłowe dane.'
	String get summaryErrorParsing => 'Serwer zwrócił nieprawidłowe dane.';

	/// pl: 'Spróbuj ponownie'
	String get summaryRetry => 'Spróbuj ponownie';

	/// pl: '{name: String}, oto Twój plan'
	String summaryGreeting({required String name}) => '${name}, oto Twój plan';

	/// pl: '(one) {{age: int} rok} (few) {{age: int} lata} (many) {{age: int} lat} (other) {{age: int} roku}'
	String summaryAge({required int age}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pl'))(age,
		one: '${age} rok',
		few: '${age} lata',
		many: '${age} lat',
		other: '${age} roku',
	);

	/// pl: 'Wiek'
	String get summaryAgeLabel => 'Wiek';

	/// pl: 'Oddechów w sesji'
	String get summaryBreathsLabel => 'Oddechów w sesji';

	/// pl: 'Minuty'
	String get summaryDurationLabel => 'Minuty';

	/// pl: 'Na minutę'
	String get summaryPaceLabel => 'Na minutę';

	/// pl: 'Wolne tempo. Dobre na wyciszenie po ciężkim dniu.'
	String get summaryMessageDeepCalm => 'Wolne tempo. Dobre na wyciszenie po ciężkim dniu.';

	/// pl: 'Dobra krótka przerwa. Jeśli chcesz się bardziej wyciszyć, zwolnij trochę tempo.'
	String get summaryMessageRelax => 'Dobra krótka przerwa. Jeśli chcesz się bardziej wyciszyć, zwolnij trochę tempo.';

	/// pl: 'Równe tempo pomoże Ci się skupić przed pracą.'
	String get summaryMessageFocus => 'Równe tempo pomoże Ci się skupić przed pracą.';

	/// pl: 'Dłuższy wydech pomoże Ci się wyciszyć przed snem.'
	String get summaryMessageSleep => 'Dłuższy wydech pomoże Ci się wyciszyć przed snem.';

	/// pl: 'Zmień ustawienia'
	String get summaryEdit => 'Zmień ustawienia';

	/// pl: 'Animacja niedostępna'
	String get riveUnavailable => 'Animacja niedostępna';

	/// pl: 'Imię'
	String get onboardingFirstNameLabel => 'Imię';

	/// pl: 'Nazwisko'
	String get onboardingLastNameLabel => 'Nazwisko';

	/// pl: 'Data urodzenia'
	String get onboardingBirthDateLabel => 'Data urodzenia';

	/// pl: 'Masz {age: String}. Po kliknięciu „Dalej” zapiszę profil.'
	String onboardingAgeLine({required String age}) => 'Masz ${age}. Po kliknięciu „Dalej” zapiszę profil.';

	/// pl: 'Zapisuję...'
	String get onboardingSending => 'Zapisuję...';

	/// pl: 'Nie udało się zapisać profilu. Spróbuj jeszcze raz.'
	String get onboardingSendError => 'Nie udało się zapisać profilu. Spróbuj jeszcze raz.';

	/// pl: 'Wstecz'
	String get onboardingBack => 'Wstecz';

	/// pl: 'Nie znaleziono Twojego profilu.'
	String get summaryErrorNotFound => 'Nie znaleziono Twojego profilu.';

	/// pl: 'Oddech, Twój towarzysz oddychania'
	String get mascotLabel => 'Oddech, Twój towarzysz oddychania';
}

/// The flat map containing all translations for locale <pl>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appTitle' => 'Oddech',
			'onboardingTitle1' => 'Cześć, jestem Oddech',
			'onboardingBody1' => 'Jak masz na imię? Wpisz imię i nazwisko, a ja będę zerkać, co piszesz.',
			'onboardingGreeting' => ({required String name}) => 'Miło Cię poznać, ${name}!',
			'onboardingTitle2' => 'Kiedy masz urodziny?',
			'onboardingBody2' => 'Z daty urodzenia policzę Twój wiek. Po kliknięciu „Dalej” zapiszę profil.',
			'onboardingTitle3' => 'Wybierz cel',
			'onboardingBody3' => 'Cel zmienia kolor bańki i treść podsumowania. Możesz go zmienić w każdej chwili.',
			'onboardingNext' => 'Dalej',
			'onboardingStart' => 'Zaczynamy',
			'setupTitle' => 'Twoja sesja',
			'setupSubtitle' => 'Oddychaj w rytmie bańki. Zmiany widać od razu.',
			'paceLabel' => 'Tempo',
			'paceValue' => ({required int count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pl'))(count, one: '${count} oddech na minutę', few: '${count} oddechy na minutę', many: '${count} oddechów na minutę', other: '${count} oddechu na minutę', ), 
			'rhythmValue' => ({required String inhale, required String exhale}) => 'Wdech ${inhale} s · wydech ${exhale} s',
			'durationLabel' => 'Czas',
			'durationValue' => ({required int minutes}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pl'))(minutes, one: '${minutes} minuta', few: '${minutes} minuty', many: '${minutes} minut', other: '${minutes} minuty', ), 
			'goalLabel' => 'Cel',
			'goalRelax' => 'Relaks',
			'goalFocus' => 'Skupienie',
			'goalSleep' => 'Sen',
			'inhale' => 'Wdech',
			'exhale' => 'Wydech',
			'showSummary' => 'Podsumowanie',
			'summaryTitle' => 'Podsumowanie',
			'summaryLoading' => 'Wczytuję profil...',
			'summaryErrorNetwork' => 'Nie udało się połączyć z serwerem.',
			'summaryErrorParsing' => 'Serwer zwrócił nieprawidłowe dane.',
			'summaryRetry' => 'Spróbuj ponownie',
			'summaryGreeting' => ({required String name}) => '${name}, oto Twój plan',
			'summaryAge' => ({required int age}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pl'))(age, one: '${age} rok', few: '${age} lata', many: '${age} lat', other: '${age} roku', ), 
			'summaryAgeLabel' => 'Wiek',
			'summaryBreathsLabel' => 'Oddechów w sesji',
			'summaryDurationLabel' => 'Minuty',
			'summaryPaceLabel' => 'Na minutę',
			'summaryMessageDeepCalm' => 'Wolne tempo. Dobre na wyciszenie po ciężkim dniu.',
			'summaryMessageRelax' => 'Dobra krótka przerwa. Jeśli chcesz się bardziej wyciszyć, zwolnij trochę tempo.',
			'summaryMessageFocus' => 'Równe tempo pomoże Ci się skupić przed pracą.',
			'summaryMessageSleep' => 'Dłuższy wydech pomoże Ci się wyciszyć przed snem.',
			'summaryEdit' => 'Zmień ustawienia',
			'riveUnavailable' => 'Animacja niedostępna',
			'onboardingFirstNameLabel' => 'Imię',
			'onboardingLastNameLabel' => 'Nazwisko',
			'onboardingBirthDateLabel' => 'Data urodzenia',
			'onboardingAgeLine' => ({required String age}) => 'Masz ${age}. Po kliknięciu „Dalej” zapiszę profil.',
			'onboardingSending' => 'Zapisuję...',
			'onboardingSendError' => 'Nie udało się zapisać profilu. Spróbuj jeszcze raz.',
			'onboardingBack' => 'Wstecz',
			'summaryErrorNotFound' => 'Nie znaleziono Twojego profilu.',
			'mascotLabel' => 'Oddech, Twój towarzysz oddychania',
			_ => null,
		};
	}
}
