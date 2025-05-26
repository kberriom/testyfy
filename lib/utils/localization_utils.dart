import 'package:flutter/material.dart';
import 'package:testyfy/l10n/app_localizations.dart' show AppLocalizations;

extension Localizations on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}