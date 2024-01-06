import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension L10nFromContext on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this)!;
}
