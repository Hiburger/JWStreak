import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/services/local_db_service.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void useTestDatabase() {
  late Directory tempDir;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('jwstreak_db_test');
    // The service resolves its file through getDatabasesPath(), which the
    // ffi factory reads from here — so pointing this at a temp directory is
    // what keeps each test's database isolated.
    await databaseFactory.setDatabasesPath(tempDir.path);
    await LocalDbService().resetForTesting();
  });

  tearDown(() async {
    await LocalDbService().resetForTesting();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });
}

/// The database file the service is currently using, for tests that need to
/// inspect it directly.
Future<String> testDatabasePath() async =>
    p.join(await databaseFactory.getDatabasesPath(), 'jwstreak.db');
