import 'dart:convert';
import 'dart:io';

import 'package:abc_tech_app/model/assist.dart';
import 'package:abc_tech_app/provider/assist_provider.dart';
import 'package:abc_tech_app/service/assist_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_connect.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'assist_service_test.mocks.dart';

@GenerateMocks([AssistanceProviderInterface])
void main() {
  late AssistanceProviderInterface providerInterface;
  late AssistanceService assistanceService;

  setUp(() async {
    providerInterface = MockAssistanceProviderInterface();
    assistanceService = AssistanceService().init(providerInterface);
    var json = File("${Directory.current.path}/test/resources/assists.json")
        .readAsStringSync();

    when(providerInterface.getAssists()).thenAnswer((_) async => Future.sync(
        () => Response(statusCode: HttpStatus.ok, body: jsonDecode(json))));
  });

  test('Teste de listagem de assistencias', () async {
    List<Assist> list = await assistanceService.getAssists();
    expect(list.length, 6);
    expect(list[0].title, "Troca de aparelho");
  });

  test('Teste de erro na conexão', () async {

    when(providerInterface.getAssists()).thenThrow(const SocketException('Erro de conexão'));
    expect(() => assistanceService.getAssists(), throwsA(isA<dynamic>()));
    verify(providerInterface.getAssists()).called(1);

  });

  test('Teste de resposta vazia', () async {

    when(providerInterface.getAssists()).thenAnswer((_) async =>
        Future.sync(() => Response(statusCode: HttpStatus.ok, body: [])));
    final assists = await assistanceService.getAssists();
    expect(assists.length, 0);
    verify(providerInterface.getAssists()).called(1);

  });

  test('Teste de exceção durante o processamento', () async {

    when(providerInterface.getAssists()).thenAnswer((_) async =>
        Future.sync(() => Response(statusCode: HttpStatus.ok, body: [
              {'id': 1, 'title': 'Assist 1'},
              // Faltando o campo 'description'
            ])));

    expect(() => assistanceService.getAssists(), throwsA(isA<dynamic>()));
    verify(providerInterface.getAssists()).called(1);

  });

  test('Teste de mapeamento de dados', () async {
    // Simulando uma resposta válida do provider
    final mockResponse = Response(statusCode: HttpStatus.ok, body: [
      {'id': 1, 'title': 'Assist 1', 'description': 'Description 1'},
      {'id': 2, 'title': 'Assist 2', 'description': 'Description 2'},
    ]);
    when(providerInterface.getAssists()).thenAnswer((_) async => Future.sync(() => mockResponse));

    final assists = await assistanceService.getAssists();

    expect(assists.length, 2);
    expect(assists[0].id, 1);
    expect(assists[0].title, 'Assist 1');
    expect(assists[0].description, 'Description 1');
    expect(assists[1].id, 2);
    expect(assists[1].title, 'Assist 2');
    expect(assists[1].description, 'Description 2');
    verify(providerInterface.getAssists()).called(1);
  });
}