import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'notification_scheduler.dart';

List<SingleChildWidget> createNotificationSchedulerProviders() => [
      Provider<NotificationScheduler>(
        create: (_) => NotificationScheduler(),
      ),
    ];
