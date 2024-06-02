import 'package:busha_app/util/functions.dart' as functions;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:busha_app/services/net.dart';

import 'register_services_test.mocks.dart';


// Generate mocks using:
// flutter pub run build_runner build

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late Net net;

  setUp(() {
    mockClient = MockClient();
    net = Net(mockClient);
  });

  group('HTTP Network', () {


    test('get makes a GET request and returns the response', () async {
      // Mock the HTTP client to return a successful response.
      final response = http.Response('Success', 200);
      when(mockClient.get(any)).thenAnswer((_) async => response);

      // Call the get method.
      final result = await net.get('/testOnly');

      // Verify that the client's get method was called with the correct URL.
      verify(mockClient.get(Uri.parse('${Net.getBushaUrl()}/testOnly')));

      // Verify that the result is the expected response.
      expect(result, response);
    });

    test('post makes a POST request and returns the response', () async {
      // Mock the HTTP client to return a successful response.
      final response = http.Response('Success', 200);
      when(mockClient.post(any, body: anyNamed('body'))).thenAnswer((_) async => response);

      // Call the post method.
      final result = await net.post(path: '/test', data: {'key': 'value'}, token: 'test_token');

      // Verify that the client's post method was called with the correct URL and data.
      verify(mockClient.post(Uri.parse('${Net.getBushaUrl()}/test'), body: {'key': 'value'}));

      // Verify that the result is the expected response.
      expect(result, response);
    });

    test('sayHello makes a GET request and prints the response', () async {
      // Mock the HTTP client to return a successful response.
      final response = http.Response('Go fuck yourself, Boss!', 200);
      when(mockClient.get(any)).thenAnswer((_) async => response);

      // Call the sayHello method.
      await net.sayHello();

      // Verify that the client's get method was called with the correct URL.
      verify(mockClient.get(Uri.parse(Net.getBushaUrl())));

      // Since sayHello only prints the response, we don't need to assert the result.
    });
  });
}