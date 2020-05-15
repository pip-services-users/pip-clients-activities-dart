# <img src="https://github.com/pip-services/pip-services/raw/master/design/Logo.png" alt="Pip.Services Logo" style="max-width:30%"> <br> Activities Microservice Client SDK for Dart

This is a Dart client SDK for [pip-services-activities](https://github.com/pip-services-users/pip-services-activities-dart) microservice.

## Download

Right now the only way to get the microservice is to check it out directly from github repository
```bash
git clone git@github.com:pip-services-users/pip-clients-activities-dart.git
```

Pip.Service team is working to implement packaging and make stable releases available for your 
as zip downloadable archieves.

## Contract

Logical contract of the microservice is presented below. For physical implementation (HTTP/REST),
please, refer to documentation of the specific protocol.

```dart
class PartyActivityV1 implements IStringIdentifiable {
  /* Identification */
  String id;
  String org_id;

  /* Identification fields */
  DateTime time;
  String type;
  ReferenceV1 party;

  /* References objects (notes, goals, etc.) */
  ReferenceV1 ref_item;
  List<ReferenceV1> ref_parents;
  ReferenceV1 ref_party;

  /* Other details like % of progress or new status */
  StringValueMap details;
}

class ReferenceV1 implements IStringIdentifiable {
  String id;
  String type;
  String name;
}

abstract class IActivitiesV1 {
  Future<DataPage<PartyActivityV1>> getPartyActivities(
      String correlationId, FilterParams filter, PagingParams paging);

  Future<PartyActivityV1> logPartyActivity(String correlationId, PartyActivityV1 activity);

  Future<List<PartyActivityV1>> batchPartyActivities(String correlationId, List<PartyActivityV1> activities);

  Future deletePartyActivities(String correlationId, dynamic filter);
}
```

## Use

The easiest way to work with the microservice is to use client SDK. 

Define client configuration parameters that match the configuration of the microservice's external API
```dart
// Client configuration
var httpConfig = ConfigParams.fromTuples(
	"connection.protocol", "http",
	"connection.host", "localhost",
	"connection.port", 8080
);
```

Instantiate the client and open connection to the microservice
```dart
// Create the client instance
var client = ActivitiesHttpClientV1(config);

// Configure the client
client.configure(httpConfig);

// Connect to the microservice
try{
  await client.open(null)
}catch() {
  // Error handling...
}       
// Work with the microservice
// ...
```

Now the client is ready to perform operations
```dart
// Create a new activity
final ACTIVITY = PartyActivityV1({
        type: 'signup',
        party: {
            id: '123',
            name: 'Test User'
        }
});

    // Create the activity
    try {
      var activity = await client.logPartyActivity('123', ACTIVITY);
      // Do something with the returned activity...
    } catch(err) {
      // Error handling...     
    }
```

```dart
// Get the list of activities for 'My Samples' product
var now = new Date();
try {
var page = await client.getPartyActivities(
    null,
    {
        party_id: '123',
        from_time: new Date(now.getTime() - 24 * 3600 * 1000),
        to_time: now
    },
    {
        total: true,
        skip: 0,
        take: 10
    });
    // Do something with page...

    } catch(err) { // Error handling}
```   


## Acknowledgements

This microservice was created and currently maintained by
- **Sergey Seroukhov**.
- **Nuzhnykh Egor**
