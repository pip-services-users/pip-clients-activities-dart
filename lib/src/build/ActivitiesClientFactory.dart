import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import '../version1/ActivitiesNullClientV1.dart';
import '../version1/ActivitiesDirectClientV1.dart';
import '../version1/ActivitiesHttpClientV1.dart';

class ActivitiesClientFactory extends Factory {
  static final NullClientDescriptor =
      Descriptor('pip-services-activities', 'client', 'null', '*', '1.0');
  static final DirectClientDescriptor =
      Descriptor('pip-services-activities', 'client', 'direct', '*', '1.0');
  static final HttpClientDescriptor =
      Descriptor('pip-services-activities', 'client', 'http', '*', '1.0');

  ActivitiesClientFactory() : super() {
    registerAsType(
        ActivitiesClientFactory.NullClientDescriptor, ActivitiesNullClientV1);
    registerAsType(ActivitiesClientFactory.DirectClientDescriptor,
        ActivitiesDirectClientV1);
    registerAsType(
        ActivitiesClientFactory.HttpClientDescriptor, ActivitiesHttpClientV1);
  }
}
