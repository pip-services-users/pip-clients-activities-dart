import 'dart:async';
import 'dart:convert';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';
import 'package:pip_services_activities/pip_services_activities.dart';
import './IActivitiesClientV1.dart';

class ActivitiesHttpClientV1 extends CommandableHttpClient
    implements IActivitiesClientV1 {
  ActivitiesHttpClientV1([config]) : super('v1/activities') {
    if (config != null) {
      configure(ConfigParams.fromValue(config));
    }
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
    var result = await callCommand(
      'get_party_activities',
      correlationId,
      {'filter': filter, 'paging': paging},
    );
    return DataPage<PartyActivityV1>.fromJson(json.decode(result), (item) {
      var activity = PartyActivityV1();
      activity.fromJson(item);
      return activity;
    });
  }

  /// Logs party activity.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [activity]              an activity to be logged.
  /// Return         (optional) Future that receives logged activity or error.
  @override
  Future<PartyActivityV1> logPartyActivity(
      String correlationId, PartyActivityV1 activity) async {
    var result = await callCommand(
        'log_party_activity', correlationId, {'activity': activity});
    if (result == null) return null;
    var item = PartyActivityV1();
    item.fromJson(json.decode(result));
    return item;
  }

  /// Logs batch of party activities.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [activities]              a list of activities to be logged.
  /// Return         (optional) Future that receives logged activities or error.
  @override
  Future<List<PartyActivityV1>> batchPartyActivities(
      String correlationId, List<PartyActivityV1> activities) async {
    var result = await callCommand(
        'batch_party_activities', correlationId, {'activities': activities});
    if (result == null) return null;
    var items = List<PartyActivityV1>.from(json
        .decode(result)
        .map((itemsJson) => PartyActivityV1.fromJson(itemsJson)));
    return items;
  }

  /// Deletes party activities that match to a given filter.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [filter]            (optional) a filter function to filter items.
  /// Return                Future that receives null for success.
  /// Throws error
  @override
  Future deletePartyActivities(String correlationId, dynamic filter) async {
    var result = await callCommand(
        'delete_party_activities', correlationId, {'filter': filter});
    if (result == null) return null;
    var delete = json.decode(result);
    return delete;
  }
}
