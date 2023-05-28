import 'dart:async' as _i4;

import 'package:abc_tech_app/provider/assist_provider.dart' as _i3;
import 'package:get/get_connect.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

class _FakeResponse_0<T> extends _i1.SmartFake implements _i2.Response<T> {
  _FakeResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class MockAssistanceProviderInterface extends _i1.Mock
    implements _i3.AssistanceProviderInterface {
  MockAssistanceProviderInterface() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Response<dynamic>> getAssists() => (super.noSuchMethod(
        Invocation.method(
          #getAssists,
          [],
        ),
        returnValue:
            _i4.Future<_i2.Response<dynamic>>.value(_FakeResponse_0<dynamic>(
          this,
          Invocation.method(
            #getAssists,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Response<dynamic>>);
}