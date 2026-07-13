import 'package:cbl/cbl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vendas_app/src/app.dart';
import 'package:vendas_app/src/dependencies.dart';
import 'package:vendas_app/src/services/couchbase_service.dart';

class MockCouchbaseService extends Mock implements CouchbaseService {}
class MockAsyncDatabase extends Mock implements AsyncDatabase {}
class MockAsyncCollection extends Mock implements AsyncCollection {}
class MockQuery extends Mock implements AsyncQuery {}
class MockResultSet extends Mock implements ResultSet {}

void main() {
  setUpAll(() {
    registerFallbackValue('');
  });

  testWidgets('App initialization test', (WidgetTester tester) async {
    final mockCouchbaseService = MockCouchbaseService();
    final mockDb = MockAsyncDatabase();
    final mockCol = MockAsyncCollection();
    final mockQuery = MockQuery();
    final mockResultSet = MockResultSet();

    when(() => mockCouchbaseService.database).thenReturn(mockDb);
    when(() => mockDb.createCollection(any())).thenAnswer((_) async => mockCol);
    when(() => mockDb.createQuery(any())).thenAnswer((_) async => mockQuery);
    when(() => mockQuery.execute()).thenAnswer((_) async => mockResultSet);
    when(() => mockResultSet.allResults()).thenAnswer((_) async => []);

    AppDependencies.couchbaseService = mockCouchbaseService;

    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify that our initial text is shown.
    expect(find.text('Vendas App'), findsOneWidget);
  });
}
