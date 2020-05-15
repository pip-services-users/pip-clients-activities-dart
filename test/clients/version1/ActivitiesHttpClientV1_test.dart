import 'dart:async';

import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_clients_activities/pip_clients_activities.dart';
import './ActivitiesClientFixtureV1.dart';

var httpConfig = ConfigParams.fromTuples([
  'connection.protocol',
  'http',
  'connection.host',
  'localhost',
  'connection.port',
  8080
]);

void main() {
  group('ActivitiesHttpClientV1', () {
    ActivitiesHttpClientV1 client;
    ActivitiesClientFixtureV1 fixture;

    setUp(() async {
      client = ActivitiesHttpClientV1();
      client.configure(httpConfig);
      var references = References.fromTuples([
        Descriptor(
            'pip-services-activities', 'client', 'http', 'default', '1.0'),
        client
      ]);
      client.setReferences(references);
      fixture = ActivitiesClientFixtureV1(client);
      await client.open(null);
    });

    tearDown(() async {
      await client.close(null);
      await Future.delayed(Duration(milliseconds: 2000));
    });

    test('Batch Party Activities', () async {
      await fixture.testBatchPartyActivities();
    });
  });
}
