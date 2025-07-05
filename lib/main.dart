import 'run.dart';

const _wonderappAuthRedirectUrl = 'wonderapp://authorization';

void main() async {
  run(loadWixProviderOverridesFactory(authRedirectUrl: _wonderappAuthRedirectUrl));
}
