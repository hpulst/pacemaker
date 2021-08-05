// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:pacemaker_changenotifier/main.dart' as app;

// void main() {
//   final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
//       as IntegrationTestWidgetsFlutterBinding;
//   testWidgets('verify text', (WidgetTester tester) async {
//     await app.main();
//     await binding.traceAction(() async {
//       // Trigger a frame.
//       await tester.pumpAndSettle();

//       expect(find.text('Marathon'), findsOneWidget);

//       await tester.tap(find.byIcon(Icons.more_vert));
//       await tester.pump();
//     });
//   });
// }

// /* 
// flutter drive \
//   --driver=test_driver/integration_test.dart \
//   --target=integration_test/pacemaker_test.dart
// */
