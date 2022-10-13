import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:keyboard/main.dart' as app;
void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("sign in testing", () {
    testWidgets("SignIn testing", (tester) async{
        app.MyApp();
        expect(find.text('Acceder con google'), findsOneWidget);
    });
  });
}