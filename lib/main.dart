import 'run.dart';

const _wonderappAuthRedirectUrl = 'wonderapp://authorization';

void main() async {
  run(getWixProviderOverridesFactory(authRedirectUrl: _wonderappAuthRedirectUrl));
}
