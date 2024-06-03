// Mocks generated by Mockito 5.4.4 from annotations
// in busha_app/test/services/blockchain_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:busha_app/services/net.dart' as _i3;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeClient_0 extends _i1.SmartFake implements _i2.Client {
  _FakeClient_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_1 extends _i1.SmartFake implements _i2.Response {
  _FakeResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [Net].
///
/// See the documentation for Mockito's code generation for more information.
class MockNet extends _i1.Mock implements _i3.Net {
  MockNet() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Client get client => (super.noSuchMethod(
        Invocation.getter(#client),
        returnValue: _FakeClient_0(
          this,
          Invocation.getter(#client),
        ),
      ) as _i2.Client);

  @override
  _i4.Future<_i2.Response> get(String? path) => (super.noSuchMethod(
        Invocation.method(
          #get,
          [path],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #get,
            [path],
          ),
        )),
      ) as _i4.Future<_i2.Response>);

  @override
  _i4.Future<_i2.Response> post({
    required String? path,
    required Map<String, dynamic>? data,
    required String? token,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [],
          {
            #path: path,
            #data: data,
            #token: token,
          },
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #post,
            [],
            {
              #path: path,
              #data: data,
              #token: token,
            },
          ),
        )),
      ) as _i4.Future<_i2.Response>);

  @override
  _i4.Future<dynamic> sayHello() => (super.noSuchMethod(
        Invocation.method(
          #sayHello,
          [],
        ),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);
}