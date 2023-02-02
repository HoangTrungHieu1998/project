import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import 'authentication.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildAvailability(context),
              const SizedBox(height: 24),
              buildAuthenticate(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAvailability(BuildContext context) => buildButton(
    text: 'Check Availability',
    icon: Icons.event_available,
    onClicked: () async {
      final isAvailable = await Authentication.hasBiometrics();
      final biometrics = await Authentication.getBiometrics();
      final isDeviceSupport = await Authentication.hasDeviceSupport();

      final hasFingerprint = biometrics.contains(BiometricType.fingerprint);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Availability'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildText('Biometrics', isAvailable),
              buildText('Fingerprint', hasFingerprint),
              buildText('Support FingerPrint', isDeviceSupport),
            ],
          ),
        ),
      );
    },
  );

  Widget buildText(String text, bool checked) => Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        checked
            ? const Icon(Icons.check, color: Colors.green, size: 24)
            : const Icon(Icons.close, color: Colors.red, size: 24),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(fontSize: 24)),
      ],
    ),
  );

  Widget buildAuthenticate(BuildContext context) => buildButton(
    text: 'Authenticate',
    icon: Icons.lock_open,
    onClicked: () async {
      final isAuthenticated = await Authentication.authenticate();
      final isDeviceSupport = await Authentication.hasDeviceSupport();


      // if(!isDeviceSupport){
      //   showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       title: const Text('Availability'),
      //       content: const Text("Your device has not support finger print"),
      //       actions: [
      //         TextButton(
      //             child: const Text("Back"),
      //             onPressed: () {
      //               Navigator.pop(context);
      //             })
      //       ],
      //     ),
      //   );
      // }

      if (isAuthenticated) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    },
  );

  Widget buildButton({
    @required String? text,
    @required IconData? icon,
    @required VoidCallback? onClicked,
  }) =>
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
        ),
        icon: Icon(icon, size: 26),
        label: Text(
          text!,
          style: const TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
      );
}
