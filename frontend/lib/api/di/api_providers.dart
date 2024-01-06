import 'package:dio/dio.dart';
import 'package:frontend/cache/settings_cache.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../authentication/authentication_api.dart';
import '../dio_wrapper.dart';
import '../statistics/statistics_api.dart';
import '../tasks/tasks_api.dart';

List<SingleChildWidget> createApiProviders() => [
      ProxyProvider<SettingsCache, DioWrapper>(
        update: (_, settingsCache, __) => DioWrapper(Dio(), settingsCache),
      ),
      ProxyProvider<DioWrapper, AuthenticationApi>(
        update: (_, dioWrapper, __) => AuthenticationApi(dioWrapper),
      ),
      ProxyProvider<DioWrapper, StatisticsApi>(
        update: (_, dioWrapper, __) => StatisticsApi(dioWrapper),
      ),
      ProxyProvider<DioWrapper, TasksApi>(
        update: (_, dioWrapper, __) => TasksApi(dioWrapper),
      ),
    ];
