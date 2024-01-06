import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../settings_cache.dart';

List<SingleChildWidget> createCacheProviders() => [
      Provider<SettingsCache>(
        create: (_) => SettingsCache(),
      ),
    ];
