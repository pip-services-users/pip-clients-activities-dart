import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_clients_activities_dart/pip_clients_activities_dart.dart';

Future<void> main(List<String> argument) async {
    try {
    var correlationId = '123';
    var config = ConfigParams.fromTuples([
                    'connection.type', 'http',
                    'connection.host', 'localhost',
                    'connection.port', 8080]
                );
    var client = ActivitiesHttpClientV1();
    client.configure(config);
    final ACTIVITY = PartyActivityV1(
        id: null,
        type: 'test',
        time: DateTime.now(),
        party: ReferenceV1(
            id: '1',
            type: 'party',
            name: 'Test User'
        ),
        ref_item: ReferenceV1(
            id: '2',
            type: 'party',
            name: 'Admin User'
        ),
        ref_parents: [],
        ref_party: null,
        details: null
    );  
    await client.open(correlationId);
    // Add batch from 3 activities
    await client.batchPartyActivities(correlationId, [ACTIVITY, ACTIVITY, ACTIVITY]);
    var page = await client.getPartyActivities(null, null, null);
    if (page.data.length == 3) {
      print('Get apps length: ' + page.data.length.toString() + '! Everything works well!');
    }
    else {
      print('Get apps length: ' + page.data.length.toString() + ' is not equal! Something was wrong!');
    }
    // Delete all activities
    await client.deletePartyActivities(correlationId, FilterParams.fromTuples(['party_id', '1']));
    page = await client.getPartyActivities(null, null, null);
    print('Get apps length after delete: ' + page.data.length.toString());
    await client.close(correlationId);
  } catch (ex) {
    print(ex);
  }
}
