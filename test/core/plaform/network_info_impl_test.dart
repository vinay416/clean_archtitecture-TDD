import 'package:clean_architecture/core/platform/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'my_network_info.mocks.dart';

void main() {
  final dataCheckerMock = MockMyNetworkInfo();
  final networkInfo = NetwokInfoImpl(dataCheckerMock);

  group(
    "Network Info Impl Test",
    () {
      test(
        "Network Info Impl - when connected",
        () async {
          when(dataCheckerMock.checkConnectivity())
              .thenAnswer((_) => Future.value(true));

          final status = await networkInfo.isConnected();  
          verify(dataCheckerMock.checkConnectivity());
          expect(status, true);
        },
      );
    },
  );
}
