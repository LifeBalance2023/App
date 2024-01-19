import 'package:frontend/repository/user_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../authentication/authentication_api.dart';
import '../dio_wrapper.dart';
import '../statistics/statistics_api.dart';
import '../tasks/tasks_api.dart';

List<SingleChildWidget> createApiProviders(DioWrapper dioWrapper) => [
      Provider<DioWrapper>.value(value: dioWrapper),
      ProxyProvider<DioWrapper, AuthenticationApi>(
        update: (_, dioWrapper, __) => AuthenticationApi(dioWrapper),
      ),
      ProxyProvider2<DioWrapper, UserRepository, StatisticsApi>(
        update: (_, dioWrapper, userRepository, __) => StatisticsApi(dioWrapper, userRepository),
      ),
      ProxyProvider2<DioWrapper, UserRepository, TasksApi>(
        update: (_, dioWrapper, userRepository, __) => TasksApi(dioWrapper, userRepository),
      ),
    ];
