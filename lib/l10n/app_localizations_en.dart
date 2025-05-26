// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Testyfy';

  @override
  String get aboutPageButton => 'About';

  @override
  String get searchBarHintHome => 'Search';

  @override
  String get recommendationsAppbarLabel => 'Recommendations';

  @override
  String get searchAppbarLabel => 'Search';

  @override
  String get libraryAppbarLabel => 'Your Library';

  @override
  String get loginButtonSpotify => 'Connect with Spotify';

  @override
  String get authFail => 'Auth failed';

  @override
  String get authDeny => 'Auth denied';

  @override
  String get spotifyDevelopmentMode => 'Auth failed: The Spotify API requires users to be added to a development mode API allow list';

  @override
  String get signOff => 'Sign Off';

  @override
  String get genericError => 'Error';

  @override
  String get genericNoData => 'There are no items';

  @override
  String get searchResultArtist => 'Artist';

  @override
  String get searchResultAlbum => 'Album';

  @override
  String get searchResultTrack => 'Track';

  @override
  String get filterByHint => 'Filter by';
}
