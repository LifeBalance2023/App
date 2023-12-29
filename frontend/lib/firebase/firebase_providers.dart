import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'firebase_authenticator.dart';

List<SingleChildWidget> createFirebaseProviders() => [
      Provider<FirebaseAuthenticator>(
        create: (_) => FirebaseAuthenticator(),
      ),
    ];