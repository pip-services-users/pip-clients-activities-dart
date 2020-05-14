import 'dart:async';
import 'dart:convert';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';
import './PartyActivityV1.dart';
import './IActivitiesClientV1.dart';

class ActivitiesHttpClientV1 extends CommandableHttpClient
    implements IActivitiesClientV1 {
  ActivitiesHttpClientV1([config]) : super('v1/activities') {
    if (config != null) {
      configure(ConfigParams.fromValue(config));
    }
  }

  @override
  Future<DataPage<PartyActivityV1>> getPartyActivities(String correlationId, FilterParams filter, PagingParams paging) async {
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

  @override
  Future<PartyActivityV1> logPartyActivity(String correlationId, PartyActivityV1 activity) async {
    var result =
        await callCommand('log_party_activity', correlationId, {'activity': activity});
    if (result == null) return null;
    var item = PartyActivityV1();
    item.fromJson(json.decode(result));
    return item;
  }

  @override
  Future<List<PartyActivityV1>> batchPartyActivities(String correlationId, List<PartyActivityV1> activities) async {
    var result =
        await callCommand('batch_party_activities', correlationId, {'activities': activities});
    if (result == null) return null;
    var items = List<PartyActivityV1>.from(json.decode(result).map((itemsJson) => PartyActivityV1.fromJsonActivity(itemsJson)));
    return items;
  }

  @override
  Future deletePartyActivities(String correlationId, dynamic filter) async {
    var result = await callCommand(
        'delete_party_activities', correlationId, {'filter': filter});
    if (result == null) return null;
    var delete = json.decode(result);
    return delete;
  }  
}
