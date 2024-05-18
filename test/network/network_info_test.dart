import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/core/utils/network_info.dart';

class MockDataConnectionChecker extends Mock implements NetworkInfo {}

void main() {
  late NetworkInfo networkInfo;
  setUp(() {
    networkInfo = NetworkInfo();
  });

  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection',
      () async {
        // arrange
        final tHasConnectionFuture = Future.value(true);

        // when(networkInfo.hasConnection)
        //     .thenAnswer((_) => tHasConnectionFuture);
        // act
        // NOTICE: We're NOT awaiting the result
        final result = networkInfo.connectivityNotifier.value;
        // assert
        verify(networkInfo.initialize());
        // Utilizing Dart's default referential equality.
        // Only references to the same object are equal.
        expect(result, tHasConnectionFuture);
      },
    );
  });
}
