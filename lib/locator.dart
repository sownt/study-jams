import 'package:android_studyjams/data/remote/default_data_source.dart';
import 'package:android_studyjams/data/repository/data_repository_impl.dart';
import 'package:android_studyjams/domain/repository/data_repository.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> initDependencies() async {
  locator.registerSingleton<DefaultDataSource>(
    DefaultDataSource()
  );

  locator.registerSingleton<DataRepository>(
    DataRepositoryImpl(
      locator<DefaultDataSource>(),
    )
  );

  locator.registerSingleton<FirebaseAnalytics>(
      FirebaseAnalytics.instance
  );
}