import 'package:flutter/cupertino.dart';
import 'package:frontend/cache/di/cache_provider.dart';
import 'package:frontend/firebase/firebase_providers.dart';
import 'package:frontend/repository/di/repository_providers.dart';
import 'package:frontend/scheduler/notification_scheduler_provider.dart';
import 'package:frontend/screens/auth/login/di/login_provider.dart';
import 'package:frontend/screens/auth/register/di/register_provider.dart';
import 'package:frontend/screens/main/di/main_screen_provider.dart';
import 'package:frontend/screens/settings/di/settings_provider.dart';
import 'package:frontend/screens/task_creator/di/task_creator_provider.dart';
import 'package:frontend/services/di/services_providers.dart';
import 'package:provider/provider.dart';
import 'api/di/api_providers.dart';

MultiProvider createProviders({required dioWrapper, required Widget child}) =>
    MultiProvider(providers: [
      ...createCacheProviders(),
      ...createRepositoryProviders(),
      ...createFirebaseProviders(),
      ...createApiProviders(dioWrapper),
      ...createNotificationSchedulerProviders(),
      ...createServicesProviders(),
      ...createLoginProviders(),
      ...createRegisterProviders(),
      ...createSettingsProviders(),
      ...createTaskCreatorProviders(),
      ...createMainScreenProviders(),
    ], child: child);
