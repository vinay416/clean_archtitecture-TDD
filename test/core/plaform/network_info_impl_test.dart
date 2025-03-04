import 'package:clean_architecture/core/platform/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'my_network_info.mocks.dart';

void main() {
  final dataCheckerMock = MockMyNetworkInfo();
  final networkInfo = NetworkInfoImpl(dataCheckerMock);

  group(
    "Network Info Impl Test",
    () {
      test(
        "Network Info Impl - when connected",
        () async {
          when(dataCheckerMock.hasConnection)
              .thenAnswer((_) => Future.value(true));

          final status = await networkInfo.isConnected();
          verify(dataCheckerMock.hasConnection);
          expect(status, true);
        },
      );

      test(
        "Network Info Impl - when not connected",
        () async {
          when(dataCheckerMock.hasConnection)
              .thenAnswer((_) => Future.value(false));

          final status = await networkInfo.isConnected();
          verify(dataCheckerMock.hasConnection);
          expect(status, false);
        },
      );
    },
  );
}
