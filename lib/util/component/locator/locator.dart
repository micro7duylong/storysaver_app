

import 'package:com.qksoft.storysaverfacebook/util/component/app_database.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setupGetIt() async {
  locator.registerSingletonAsync<AppDatabase>(() => AppDatabase.instance());
  await locator.isReady<AppDatabase>();
}
