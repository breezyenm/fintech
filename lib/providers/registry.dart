import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:qwid/providers/API/card.dart';
import 'package:qwid/providers/data/card.dart';

import 'API/account.dart';
import 'API/auth.dart';
import 'API/beneficiary.dart';
import 'API/profile.dart';
import 'API/settings.dart';
import 'API/vtn.dart';
import 'API/wallet.dart';
import 'brain/account_provider.dart';
import 'brain/auth_provider.dart';
import 'brain/card_provider.dart';
import 'brain/home_provider.dart';
import 'brain/notification_provider.dart';
import 'brain/onboarding.dart';
import 'brain/settings_provider.dart';
import 'brain/summary_provider.dart';
import 'brain/wallet_provider.dart';
import 'data/auth.dart';
import 'data/beneficiary.dart';
import 'data/settings.dart';
import 'data/vtn.dart';
import 'data/wallet.dart';
import 'functions/auth_functions.dart';

final providers = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => AccountProvider()),
  ChangeNotifierProvider(create: (_) => AccountAPI()),
  ChangeNotifierProvider(create: (_) => AuthAPI()),
  ChangeNotifierProvider(create: (_) => AuthData()),
  ChangeNotifierProvider(create: (_) => AuthFunctions()),
  ChangeNotifierProvider(create: (_) => AuthProvider()),
  ChangeNotifierProvider(create: (_) => BeneficiaryAPI()),
  ChangeNotifierProvider(create: (_) => BeneficiaryData()),
  ChangeNotifierProvider(create: (_) => CardAPI()),
  ChangeNotifierProvider(create: (_) => CardData()),
  ChangeNotifierProvider(create: (_) => CardProvider()),
  ChangeNotifierProvider(create: (_) => HomeProvider()),
  ChangeNotifierProvider(create: (_) => NotificationProvider()),
  ChangeNotifierProvider(create: (_) => OnBoarding()),
  ChangeNotifierProvider(create: (_) => ProfileAPI()),
  ChangeNotifierProvider(create: (_) => SettingsAPI()),
  ChangeNotifierProvider(create: (_) => SettingsData()),
  ChangeNotifierProvider(create: (_) => SettingsProvider()),
  ChangeNotifierProvider(create: (_) => SummaryProvider()),
  ChangeNotifierProvider(create: (_) => VTNAPI()),
  ChangeNotifierProvider(create: (_) => VTNData()),
  ChangeNotifierProvider(create: (_) => WalletAPI()),
  ChangeNotifierProvider(create: (_) => WalletData()),
  ChangeNotifierProvider(create: (_) => WalletProvider()),
  // ChangeNotifierProvider(create: (_) => RequestsProvider()),
];
