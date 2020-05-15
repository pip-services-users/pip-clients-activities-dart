import 'dart:async';
import 'package:test/test.dart';
import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services_activities/pip_services_activities.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_clients_activities/pip_clients_activities.dart';
import './ActivitiesClientFixtureV1.dart';

void main() {
  group('ActivitiesDirectClientV1', () {
    ActivitiesDirectClientV1 client;
    ActivitiesClientFixtureV1 fixture;
    ActivitiesMemoryPersistence persistence;
    ActivitiesController controller;

    setUp(() async {
      var logger = ConsoleLogger();
      persistence = ActivitiesMemoryPersistence();
      controller = ActivitiesController();
      var references = References.fromTuples([
        Descriptor('pip-services', 'logger', 'console', 'default', '1.0'),
        logger,
        Descriptor('pip-services-activities', 'persistence', 'memory',
            'default', '1.0'),
        persistence,
        Descriptor('pip-services-activities', 'controller', 'default',
            'default', '1.0'),
        controller
      ]);
      controller.setReferences(references);

      client = ActivitiesDirectClientV1();
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
