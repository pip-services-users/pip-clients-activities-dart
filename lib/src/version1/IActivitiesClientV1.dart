import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import './PartyActivityV1.dart';

abstract class IActivitiesClientV1 {
  Future<DataPage<PartyActivityV1>> getPartyActivities(
      String correlationId, FilterParams filter, PagingParams paging);

  Future<PartyActivityV1> logPartyActivity(String correlationId, PartyActivityV1 activity);

  Future<List<PartyActivityV1>> batchPartyActivities(String correlationId, List<PartyActivityV1> activities);

  Future deletePartyActivities(String correlationId, dynamic filter);
}