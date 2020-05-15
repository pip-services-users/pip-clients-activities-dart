import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';
import 'package:pip_services_activities/pip_services_activities.dart';

import './IActivitiesClientV1.dart';

class ActivitiesDirectClientV1 extends DirectClient<dynamic>
    implements IActivitiesClientV1 {
  ActivitiesDirectClientV1() : super() {
    dependencyResolver.put('controller',
        Descriptor('pip-services-activities', 'controller', '*', '*', '1.0'));
  }

  /// Gets a page of party activities retrieved by a given filter.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [filter]            (optional) a filter function to filter items
  /// - [paging]            (optional) paging parameters
  /// Return Future that receives a data page
  /// Throws error.
  @override
  Future<DataPage<PartyActivityV1>> getPartyActivities(
      String correlationId, FilterParams filter, PagingParams paging) async {
    var timing = instrument(correlationId, 'activities.get_party_activities');
    var page =
        await controller.getPartyActivities(correlationId, filter, paging);
    timing.endTiming();
    return page;
  }

  /// Logs party activity.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [activity]              an activity to be logged.
  /// Return         (optional) Future that receives logged activity or error.
  @override
  Future<PartyActivityV1> logPartyActivity(
      String correlationId, PartyActivityV1 activity) async {
    var timing = instrument(correlationId, 'activities.log_party_activity');
    var result = await controller.logPartyActivity(correlationId, activity);
    timing.endTiming();
    return result;
  }

  /// Logs batch of party activities.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [activities]              a list of activities to be logged.
  /// Return         (optional) Future that receives logged activities or error.
  @override
  Future<List<PartyActivityV1>> batchPartyActivities(
      String correlationId, List<PartyActivityV1> activities) async {
    var timing = instrument(correlationId, 'activities.batch_party_activities');
    var result =
        await controller.batchPartyActivities(correlationId, activities);
    timing.endTiming();
    return result;
  }

  /// Deletes party activities that match to a given filter.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [filter]            (optional) a filter function to filter items.
  /// Return                Future that receives null for success.
  /// Throws error
  @override
  Future deletePartyActivities(String correlationId, dynamic filter) async {
    var timing =
        instrument(correlationId, 'activities.delete_party_activities');
    var result = await controller.deletePartyActivities(correlationId, filter);
    timing.endTiming();
    return result;
  }
}
