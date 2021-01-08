import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';

void showAboutDialog({
  @required BuildContext context,
}) {
  assert(context != null);
  showDialog<void>(
    context: context,
    builder: (context) {
      return _AboutDialog();
    },
  );
}

Future<String> getVersionNumber() async {
  final packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

class _AboutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bodyTextStyle = DefaultTextStyle.of(context).style;
    const name = 'Pacemaker';
    const seeSourceFirst = 'Trainingspläne mit freundlicher Genehmigung von ';
    const laufSzene = 'Laufszene.de – Duisburg';
    const seeSourceSecond = ' zur Verfügung gestellt.';
    const seeSourceThird = 'Source code im ';
    const repoURL = 'GitHub repository.';
    const legalese = '© 2021 Hendrik Pulst';

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FutureBuilder(
              future: getVersionNumber(),
              builder: (context, snapshot) => Text(
                snapshot.hasData ? '$name ${snapshot.data}' : 'name',
              ),
            ),
            const SizedBox(height: 24),
            RichText(
              text: TextSpan(
                text: seeSourceFirst,
                style: bodyTextStyle,
                children: <TextSpan>[
                  TextSpan(
                    text: laufSzene,
                    style: bodyTextStyle.copyWith(
                      color: colorScheme.primary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        const url = 'https://laufszene.de';
                        if (await canLaunch(url)) {
                          await launch(
                            url,
                            forceSafariVC: false,
                          );
                        }
                      },
                  ),
                  const TextSpan(text: seeSourceSecond),
                ],
              ),
            ),
            const SizedBox(height: 24),
            RichText(
              text: TextSpan(
                text: seeSourceThird,
                style: bodyTextStyle,
                children: <TextSpan>[
                  TextSpan(
                    text: repoURL,
                    style: bodyTextStyle.copyWith(
                      color: colorScheme.primary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        const url =
                            'https://github.com/Naskapie/pacemaker/tree/master/pacemaker_changenotifier';
                        if (await canLaunch(url)) {
                          await launch(
                            url,
                            forceSafariVC: false,
                          );
                        }
                      },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            RichText(
              text: TextSpan(style: bodyTextStyle, text: legalese),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            MaterialLocalizations.of(context).viewLicensesButtonLabel,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (context) => Theme(
                data: Theme.of(context).copyWith(
                  textTheme: Typography.material2018(
                    platform: Theme.of(context).platform,
                  ).black,
                  scaffoldBackgroundColor: Colors.white,
                ),
                child: const LicensePage(
                  applicationName: name,
                  applicationLegalese: legalese,
                ),
              ),
            ));
          },
        ),
        TextButton(
          child: Text(MaterialLocalizations.of(context).closeButtonLabel),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
