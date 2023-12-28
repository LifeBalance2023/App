import 'package:flutter/cupertino.dart';
import 'package:frontend/repository/di/repository_providers.dart';
import 'package:frontend/scheduler/notification_scheduler_provider.dart';
import 'package:frontend/services/di/services_providers.dart';
import 'package:provider/provider.dart';

import 'api/di/api_providers.dart';

MultiProvider createProviders(Widget child) => MultiProvider(providers: [
      ...createApiProviders(),
      ...createRepositoryProviders(),
      ...createNotificationSchedulerProviders(),
      ...createServicesProviders(),
    ], child: child);
