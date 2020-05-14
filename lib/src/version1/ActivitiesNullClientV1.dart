import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import './PartyActivityV1.dart';
import './IActivitiesClientV1.dart';

class ActivitiesNullClientV1 implements IActivitiesClientV1 {
  @override
  Future<DataPage<PartyActivityV1>> getPartyActivities(String correlationId, FilterParams filter, PagingParams paging) async {
    return DataPage<PartyActivityV1>([], 0);
  }

  @override
  Future<PartyActivityV1> logPartyActivity(String correlationId, PartyActivityV1 activity) async {
    return null;
  }

  @override
  Future<List<PartyActivityV1>> batchPartyActivities(String correlationId, List<PartyActivityV1> activities) async {
    return List<PartyActivityV1>(0);
  }

  @override
  Future deletePartyActivities(String correlationId, filter) async {
    return null;
  }
}
