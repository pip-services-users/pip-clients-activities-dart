import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';

import './PartyActivityV1.dart';
import './IActivitiesClientV1.dart';

class ActivitiesDirectClientV1 extends DirectClient<dynamic>
    implements IActivitiesClientV1 {
  ActivitiesDirectClientV1() : super() {
    dependencyResolver.put(
        'controller', Descriptor('pip-services-activities', 'controller', '*', '*', '1.0'));
  }

  @override
  Future<DataPage<PartyActivityV1>> getPartyActivities(String correlationId, FilterParams filter, PagingParams paging) async {
    var timing = instrument(correlationId, 'activities.get_party_activities');
    var page = await controller.getPartyActivities(correlationId, filter, paging);
    timing.endTiming();
    return page;
  }

  @override
  Future<PartyActivityV1> logPartyActivity(String correlationId, PartyActivityV1 activity) async {
    var timing = instrument(correlationId, 'activities.log_party_activity');
    var result = await controller.logPartyActivity(correlationId, activity);
    timing.endTiming();
    return result;
  }

  @override
  Future<List<PartyActivityV1>> batchPartyActivities(String correlationId, List<PartyActivityV1> activities) async {
    var timing = instrument(correlationId, 'activities.batch_party_activities');
    var result = await controller.batchPartyActivities(correlationId, activities);
    timing.endTiming();
    return result;
  }

  @override
  Future deletePartyActivities(String correlationId, dynamic filter) async {
    var timing = instrument(correlationId, 'activities.delete_party_activities');
    var result = await controller.deletePartyActivities(correlationId, filter);
    timing.endTiming();
    return result;
  }
}
