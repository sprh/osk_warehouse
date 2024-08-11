// Mocks generated by Mockito 5.4.4 from annotations
// in osk_warehouse/test/unit/authorization/authorization_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dio/dio.dart' as _i3;
import 'package:flutter/foundation.dart' as _i4;
import 'package:flutter_bloc/flutter_bloc.dart' as _i11;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i10;
import 'package:osk_warehouse/core/authorization/bloc/authorization_data_bloc.dart'
    as _i8;
import 'package:osk_warehouse/core/authorization/bloc/state.dart' as _i9;
import 'package:osk_warehouse/core/authorization/data/repository.dart' as _i7;
import 'package:osk_warehouse/core/network/dio_client.dart' as _i6;

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

class _FakeIOSOptions_0 extends _i1.SmartFake implements _i2.IOSOptions {
  _FakeIOSOptions_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAndroidOptions_1 extends _i1.SmartFake
    implements _i2.AndroidOptions {
  _FakeAndroidOptions_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLinuxOptions_2 extends _i1.SmartFake implements _i2.LinuxOptions {
  _FakeLinuxOptions_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWindowsOptions_3 extends _i1.SmartFake
    implements _i2.WindowsOptions {
  _FakeWindowsOptions_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWebOptions_4 extends _i1.SmartFake implements _i2.WebOptions {
  _FakeWebOptions_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMacOsOptions_5 extends _i1.SmartFake implements _i2.MacOsOptions {
  _FakeMacOsOptions_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDio_6 extends _i1.SmartFake implements _i3.Dio {
  _FakeDio_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_7<T1> extends _i1.SmartFake implements _i3.Response<T1> {
  _FakeResponse_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [FlutterSecureStorage].
///
/// See the documentation for Mockito's code generation for more information.
class MockFlutterSecureStorage extends _i1.Mock
    implements _i2.FlutterSecureStorage {
  MockFlutterSecureStorage() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.IOSOptions get iOptions => (super.noSuchMethod(
        Invocation.getter(#iOptions),
        returnValue: _FakeIOSOptions_0(
          this,
          Invocation.getter(#iOptions),
        ),
      ) as _i2.IOSOptions);

  @override
  _i2.AndroidOptions get aOptions => (super.noSuchMethod(
        Invocation.getter(#aOptions),
        returnValue: _FakeAndroidOptions_1(
          this,
          Invocation.getter(#aOptions),
        ),
      ) as _i2.AndroidOptions);

  @override
  _i2.LinuxOptions get lOptions => (super.noSuchMethod(
        Invocation.getter(#lOptions),
        returnValue: _FakeLinuxOptions_2(
          this,
          Invocation.getter(#lOptions),
        ),
      ) as _i2.LinuxOptions);

  @override
  _i2.WindowsOptions get wOptions => (super.noSuchMethod(
        Invocation.getter(#wOptions),
        returnValue: _FakeWindowsOptions_3(
          this,
          Invocation.getter(#wOptions),
        ),
      ) as _i2.WindowsOptions);

  @override
  _i2.WebOptions get webOptions => (super.noSuchMethod(
        Invocation.getter(#webOptions),
        returnValue: _FakeWebOptions_4(
          this,
          Invocation.getter(#webOptions),
        ),
      ) as _i2.WebOptions);

  @override
  _i2.MacOsOptions get mOptions => (super.noSuchMethod(
        Invocation.getter(#mOptions),
        returnValue: _FakeMacOsOptions_5(
          this,
          Invocation.getter(#mOptions),
        ),
      ) as _i2.MacOsOptions);

  @override
  void registerListener({
    required String? key,
    required _i4.ValueChanged<String?>? listener,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #registerListener,
          [],
          {
            #key: key,
            #listener: listener,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  void unregisterListener({
    required String? key,
    required _i4.ValueChanged<String?>? listener,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #unregisterListener,
          [],
          {
            #key: key,
            #listener: listener,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  void unregisterAllListenersForKey({required String? key}) =>
      super.noSuchMethod(
        Invocation.method(
          #unregisterAllListenersForKey,
          [],
          {#key: key},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void unregisterAllListeners() => super.noSuchMethod(
        Invocation.method(
          #unregisterAllListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i5.Future<void> write({
    required String? key,
    required String? value,
    _i2.IOSOptions? iOptions,
    _i2.AndroidOptions? aOptions,
    _i2.LinuxOptions? lOptions,
    _i2.WebOptions? webOptions,
    _i2.MacOsOptions? mOptions,
    _i2.WindowsOptions? wOptions,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #write,
          [],
          {
            #key: key,
            #value: value,
            #iOptions: iOptions,
            #aOptions: aOptions,
            #lOptions: lOptions,
            #webOptions: webOptions,
            #mOptions: mOptions,
            #wOptions: wOptions,
          },
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<String?> read({
    required String? key,
    _i2.IOSOptions? iOptions,
    _i2.AndroidOptions? aOptions,
    _i2.LinuxOptions? lOptions,
    _i2.WebOptions? webOptions,
    _i2.MacOsOptions? mOptions,
    _i2.WindowsOptions? wOptions,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [],
          {
            #key: key,
            #iOptions: iOptions,
            #aOptions: aOptions,
            #lOptions: lOptions,
            #webOptions: webOptions,
            #mOptions: mOptions,
            #wOptions: wOptions,
          },
        ),
        returnValue: _i5.Future<String?>.value(),
      ) as _i5.Future<String?>);

  @override
  _i5.Future<bool> containsKey({
    required String? key,
    _i2.IOSOptions? iOptions,
    _i2.AndroidOptions? aOptions,
    _i2.LinuxOptions? lOptions,
    _i2.WebOptions? webOptions,
    _i2.MacOsOptions? mOptions,
    _i2.WindowsOptions? wOptions,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #containsKey,
          [],
          {
            #key: key,
            #iOptions: iOptions,
            #aOptions: aOptions,
            #lOptions: lOptions,
            #webOptions: webOptions,
            #mOptions: mOptions,
            #wOptions: wOptions,
          },
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);

  @override
  _i5.Future<void> delete({
    required String? key,
    _i2.IOSOptions? iOptions,
    _i2.AndroidOptions? aOptions,
    _i2.LinuxOptions? lOptions,
    _i2.WebOptions? webOptions,
    _i2.MacOsOptions? mOptions,
    _i2.WindowsOptions? wOptions,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [],
          {
            #key: key,
            #iOptions: iOptions,
            #aOptions: aOptions,
            #lOptions: lOptions,
            #webOptions: webOptions,
            #mOptions: mOptions,
            #wOptions: wOptions,
          },
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<Map<String, String>> readAll({
    _i2.IOSOptions? iOptions,
    _i2.AndroidOptions? aOptions,
    _i2.LinuxOptions? lOptions,
    _i2.WebOptions? webOptions,
    _i2.MacOsOptions? mOptions,
    _i2.WindowsOptions? wOptions,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readAll,
          [],
          {
            #iOptions: iOptions,
            #aOptions: aOptions,
            #lOptions: lOptions,
            #webOptions: webOptions,
            #mOptions: mOptions,
            #wOptions: wOptions,
          },
        ),
        returnValue: _i5.Future<Map<String, String>>.value(<String, String>{}),
      ) as _i5.Future<Map<String, String>>);

  @override
  _i5.Future<void> deleteAll({
    _i2.IOSOptions? iOptions,
    _i2.AndroidOptions? aOptions,
    _i2.LinuxOptions? lOptions,
    _i2.WebOptions? webOptions,
    _i2.MacOsOptions? mOptions,
    _i2.WindowsOptions? wOptions,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteAll,
          [],
          {
            #iOptions: iOptions,
            #aOptions: aOptions,
            #lOptions: lOptions,
            #webOptions: webOptions,
            #mOptions: mOptions,
            #wOptions: wOptions,
          },
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<bool?> isCupertinoProtectedDataAvailable() => (super.noSuchMethod(
        Invocation.method(
          #isCupertinoProtectedDataAvailable,
          [],
        ),
        returnValue: _i5.Future<bool?>.value(),
      ) as _i5.Future<bool?>);
}

/// A class which mocks [DioClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockDioClient extends _i1.Mock implements _i6.DioClient {
  MockDioClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Dio get core => (super.noSuchMethod(
        Invocation.getter(#core),
        returnValue: _FakeDio_6(
          this,
          Invocation.getter(#core),
        ),
      ) as _i3.Dio);

  @override
  void initialize() => super.noSuchMethod(
        Invocation.method(
          #initialize,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addInterceptor(_i3.Interceptor? interceptor) => super.noSuchMethod(
        Invocation.method(
          #addInterceptor,
          [interceptor],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeInterceptorWhere(bool Function(_i3.Interceptor)? test) =>
      super.noSuchMethod(
        Invocation.method(
          #removeInterceptorWhere,
          [test],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i5.Future<_i3.Response<T>> retry<T>(_i3.RequestOptions? requestOptions) =>
      (super.noSuchMethod(
        Invocation.method(
          #retry,
          [requestOptions],
        ),
        returnValue: _i5.Future<_i3.Response<T>>.value(_FakeResponse_7<T>(
          this,
          Invocation.method(
            #retry,
            [requestOptions],
          ),
        )),
      ) as _i5.Future<_i3.Response<T>>);
}

/// A class which mocks [AuthorizationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthorizationRepository extends _i1.Mock
    implements _i7.AuthorizationRepository {
  MockAuthorizationRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<String?> get username => (super.noSuchMethod(
        Invocation.getter(#username),
        returnValue: _i5.Future<String?>.value(),
      ) as _i5.Future<String?>);

  @override
  _i5.Future<String?> refreshToken({
    required String? username,
    required String? password,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #refreshToken,
          [],
          {
            #username: username,
            #password: password,
          },
        ),
        returnValue: _i5.Future<String?>.value(),
      ) as _i5.Future<String?>);

  @override
  _i5.Future<String?> getCachedToken() => (super.noSuchMethod(
        Invocation.method(
          #getCachedToken,
          [],
        ),
        returnValue: _i5.Future<String?>.value(),
      ) as _i5.Future<String?>);

  @override
  _i5.Future<String?> getTokenByCachedUserCreds() => (super.noSuchMethod(
        Invocation.method(
          #getTokenByCachedUserCreds,
          [],
        ),
        returnValue: _i5.Future<String?>.value(),
      ) as _i5.Future<String?>);

  @override
  bool needRetryUrl(
    String? url,
    int? statusCode,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #needRetryUrl,
          [
            url,
            statusCode,
          ],
        ),
        returnValue: false,
      ) as bool);

  @override
  _i5.Future<void> logout() => (super.noSuchMethod(
        Invocation.method(
          #logout,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}

/// A class which mocks [AuthorizationDataBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthorizationDataBloc extends _i1.Mock
    implements _i8.AuthorizationDataBloc {
  MockAuthorizationDataBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.AuthorizationDataState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i10.dummyValue<_i9.AuthorizationDataState>(
          this,
          Invocation.getter(#state),
        ),
      ) as _i9.AuthorizationDataState);

  @override
  _i5.Stream<_i9.AuthorizationDataState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i5.Stream<_i9.AuthorizationDataState>.empty(),
      ) as _i5.Stream<_i9.AuthorizationDataState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  void setAuthorized({required String? username}) => super.noSuchMethod(
        Invocation.method(
          #setAuthorized,
          [],
          {#username: username},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void setNotAuthorized() => super.noSuchMethod(
        Invocation.method(
          #setNotAuthorized,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i9.AuthorizationDataState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onChange(_i11.Change<_i9.AuthorizationDataState>? change) =>
      super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i5.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}
