import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recase/recase.dart';
import 'package:wonder/src/client/authentication.dart';
import 'package:wonder/src/client/token.dart';
import 'package:wonder/src/client/wix/wix_authentication.dart';
import 'package:wonder/src/widgets/platform/chip.dart';
import 'package:wonder_api/src/utils/utils.dart';

class AuthenticationButton extends StatefulWidget {
  final Authentication authentication;

  const AuthenticationButton({required this.authentication});

  @override
  State<AuthenticationButton> createState() => _AuthenticationButtonState();
}

class _AuthenticationButtonState extends State<AuthenticationButton> {
  Token? get token => widget.authentication.token;

  GrantType? get grantType => widget.authentication.token?.grantType;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: getIconData(grantType),
      backgroundColor: token != null
          ? (grantType == GrantType.member ? Colors.green.shade400 : Colors.blue.shade400)
          : Colors.grey,
      foregroundColor: Colors.white,
      children: [
        // Login
        SpeedDialChild(
          child: getIcon(GrantType.member),
          backgroundColor: getBackgroundColor(grantType: GrantType.member, shade: 300),
          label: 'Login',
          onTap: () async {
            await widget.authentication.login();
            setState(() {});
          },
        ),
        // Anonymous Login
        SpeedDialChild(
          child: getIcon(GrantType.anonymous),
          backgroundColor: getBackgroundColor(grantType: GrantType.anonymous, shade: 300),
          label: 'Login as Anonymous',
          onTap: () async {
            await (widget.authentication as WixAuthentication).loginAsAnonymous();
            setState(() {});
          },
        ),
        // Logout
        SpeedDialChild(
          child: getIcon(null),
          backgroundColor: getBackgroundColor(grantType: null, shade: 300),
          label: 'Logout',
          onTap: () async {
            await widget.authentication.logout();
            setState(() {});
          },
        ),
        // Show Access Token
        SpeedDialChild(
          child: Icon(Icons.password),
          label: 'Show Access Token',
          onTap: () {
            final token = widget.authentication.token;
            if (token == null) {
              showMessage(
                context,
                title: 'No access token',
                message: 'Please login to fetch an access token',
              );
              return;
            }

            showData(
              context: context,
              data: token.toJson(),
              title: '${token.grantType.name.sentenceCase} Token',
            );
          },
        ),
      ],
    );
  }

  Widget buildLabel() {
    final token = widget.authentication.token;
    String label;
    Color backgroundColor;

    if (token == null) {
      label = 'Logged Out';
      backgroundColor = Colors.grey.shade400;
    } else {
      var isValid = token.isValid;
      var isAnonymous = token.grantType == GrantType.anonymous;
      label = '''${isValid ? 'Valid' : 'Expired'} ${isAnonymous ? 'Anonymous' : 'Member'} Token''';
      backgroundColor = isValid ? Colors.green.shade300 : Colors.red.shade300;
    }

    return Chip(label: label, backgroundColor: backgroundColor);
  }

  Color getBackgroundColor({required GrantType? grantType, int shade = 400}) => grantType != null
      ? (grantType == GrantType.member ? Colors.green[shade]! : Colors.blue[shade]!)
      : Colors.grey[shade]!;

  Icon getIcon(GrantType? grantType) => Icon(getIconData(grantType), color: Colors.white);

  IconData getIconData(GrantType? grantType) {
    if (grantType == null) {
      return Icons.no_accounts_outlined;
    }

    return (grantType == GrantType.member ? Icons.account_circle : FontAwesomeIcons.userSecret);
  }
}
