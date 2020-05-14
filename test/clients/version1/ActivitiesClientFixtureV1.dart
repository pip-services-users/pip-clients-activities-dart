import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import 'package:pip_clients_activities_dart/pip_clients_activities_dart.dart';

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

class ActivitiesClientFixtureV1 {
  IActivitiesClientV1 _client;

  ActivitiesClientFixtureV1(IActivitiesClientV1 client) {
    expect(client, isNotNull);
    _client = client;
  }

  void testBatchPartyActivities() async {
    PartyActivityV1 activity1;

    // Log an activity batch
    var activities = await _client.batchPartyActivities(null, [ACTIVITY, ACTIVITY, ACTIVITY]);

    // Get all activities
    var page = await _client.getPartyActivities(null, FilterParams.fromTuples(['party_id', '1']), PagingParams());
    expect(page, isNotNull);
    expect(page.data.length, 3);
    activity1 = page.data[0];
    expect(activity1, isNotNull);
    expect(ACTIVITY.type, activity1.type);
    expect(ACTIVITY.party.id, activity1.party.id);
    expect(ACTIVITY.ref_item.name, activity1.ref_item.name);
    expect(activity1.time, isNotNull);
  }  
}
