// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Testyfy';

  @override
  String get aboutPageButton => 'Ver licencias';

  @override
  String get searchBarHintHome => 'Buscar';

  @override
  String get recommendationsAppbarLabel => 'Recomendaciones';

  @override
  String get searchAppbarLabel => 'Buscar';

  @override
  String get libraryAppbarLabel => 'Tu biblioteca';

  @override
  String get loginButtonSpotify => 'Vincular a Spotify';

  @override
  String get authFail => 'Error al vincular cuenta Spotify';

  @override
  String get authDeny => 'Vinculación negada';

  @override
  String get spotifyDevelopmentMode => 'Error al vincular cuenta Spotify: La API de Spotify requiere registro previo para proyectos en Development Mode';

  @override
  String get signOff => 'Cerrar sesión';

  @override
  String get genericError => 'Error';

  @override
  String get genericNoData => 'No hay items';

  @override
  String get searchResultArtist => 'Artista';

  @override
  String get searchResultAlbum => 'Album';

  @override
  String get searchResultTrack => 'Canción';

  @override
  String get filterByHint => 'Filtros';
}
