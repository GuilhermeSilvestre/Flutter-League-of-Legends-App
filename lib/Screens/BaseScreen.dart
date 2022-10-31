import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:leagueoflegends/Screens/ChallengersScreen.dart';
import 'package:leagueoflegends/Screens/PerfilScreen.dart';
import 'package:leagueoflegends/constants.dart';
import 'package:leagueoflegends/network.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  String url = '';
  int needToChange = 0;
  bool flag = false;
  String loading = 'start';
  List<bool> exibirJogos = List.filled(20, false);
  bool botao_clicado = false;

  String nickPlayer = ''; // Vem de TextField do app (input)

  // Tipos de Resposta
  dynamic apiData;
  dynamic apiDataRank;
  dynamic apiDataGames;
  dynamic apiDataGame;
  dynamic apiDataTopPlayers;
  late List<dynamic> apiTopPlayersListId = List.filled(200, 'players');
  late List<dynamic> apiTopPlayersListName = List.filled(200, 'players');
  late List<dynamic> apiTopPlayersListPoints = List.filled(200, 'players');

  //Dados dos endpoints
  dynamic apiPlayerId;
  dynamic apiPlayerPUUID;
  dynamic apiGame1;
  dynamic apiGame2;
  dynamic apiGame3;
  dynamic apiGame4;
  dynamic apiGame5;
  dynamic apiGame6;
  dynamic apiGame7;
  dynamic apiGame8;
  dynamic apiGame9;
  dynamic apiGame10;
  dynamic apiGame11;
  dynamic apiGame12;
  dynamic apiGame13;
  dynamic apiGame14;
  dynamic apiGame15;
  dynamic apiGame16;
  dynamic apiGame17;
  dynamic apiGame18;
  dynamic apiGame19;
  dynamic apiGame20;

  //Dados de resposta ao usuário
  dynamic apiPlayerNick;
  dynamic apiPlayerLevel;

  dynamic apiPlayerTierFlex;
  dynamic apiPlayerRankFlex;
  dynamic apiPlayerPointsFlex;
  dynamic apiPlayerWinsFlex;
  dynamic apiPlayerLossFlex;

  dynamic apiPlayerTierSoloQ;
  dynamic apiPlayerRankSoloQ;
  dynamic apiPlayerPointsSoloQ;
  dynamic apiPlayerWinsSoloQ;
  dynamic apiPlayerLossSoloQ;

  late List<dynamic> apiTeamMate1Nick = List.filled(20, 'null');
  late List<dynamic> apiTeamMate1Champion = List.filled(20, 'null');
  late List<dynamic> apiTeamMate1Lane = List.filled(20, 'null');
  late List<dynamic> apiTeamMate1Kills = List.filled(20, 'null');
  late List<dynamic> apiTeamMate1Deaths = List.filled(20, 'null');
  late List<dynamic> apiTeamMate1Assists = List.filled(20, 'null');

  late List<dynamic> apiTeamMate2Nick = List.filled(20, 'null');
  late List<dynamic> apiTeamMate2Champion = List.filled(20, 'null');
  late List<dynamic> apiTeamMate2Lane = List.filled(20, 'null');
  late List<dynamic> apiTeamMate2Kills = List.filled(20, 'null');
  late List<dynamic> apiTeamMate2Deaths = List.filled(20, 'null');
  late List<dynamic> apiTeamMate2Assists = List.filled(20, 'null');

  late List<dynamic> apiTeamMate3Nick = List.filled(20, 'null');
  late List<dynamic> apiTeamMate3Champion = List.filled(20, 'null');
  late List<dynamic> apiTeamMate3Lane = List.filled(20, 'null');
  late List<dynamic> apiTeamMate3Kills = List.filled(20, 'null');
  late List<dynamic> apiTeamMate3Deaths = List.filled(20, 'null');
  late List<dynamic> apiTeamMate3Assists = List.filled(20, 'null');

  late List<dynamic> apiTeamMate4Nick = List.filled(20, 'null');
  late List<dynamic> apiTeamMate4Champion = List.filled(20, 'null');
  late List<dynamic> apiTeamMate4Lane = List.filled(20, 'null');
  late List<dynamic> apiTeamMate4Kills = List.filled(20, 'null');
  late List<dynamic> apiTeamMate4Deaths = List.filled(20, 'null');
  late List<dynamic> apiTeamMate4Assists = List.filled(20, 'null');

  late List<dynamic> apiTeamMate5Nick = List.filled(20, 'null');
  late List<dynamic> apiTeamMate5Champion = List.filled(20, 'null');
  late List<dynamic> apiTeamMate5Lane = List.filled(20, 'null');
  late List<dynamic> apiTeamMate5Kills = List.filled(20, 'null');
  late List<dynamic> apiTeamMate5Deaths = List.filled(20, 'null');
  late List<dynamic> apiTeamMate5Assists = List.filled(20, 'null');

  late List<dynamic> apiTeamMate6Nick = List.filled(20, 'null');
  late List<dynamic> apiTeamMate6Champion = List.filled(20, 'null');
  late List<dynamic> apiTeamMate6Lane = List.filled(20, 'null');
  late List<dynamic> apiTeamMate6Kills = List.filled(20, 'null');
  late List<dynamic> apiTeamMate6Deaths = List.filled(20, 'null');
  late List<dynamic> apiTeamMate6Assists = List.filled(20, 'null');

  late List<dynamic> apiTeamMate7Nick = List.filled(20, 'null');
  late List<dynamic> apiTeamMate7Champion = List.filled(20, 'null');
  late List<dynamic> apiTeamMate7Lane = List.filled(20, 'null');
  late List<dynamic> apiTeamMate7Kills = List.filled(20, 'null');
  late List<dynamic> apiTeamMate7Deaths = List.filled(20, 'null');
  late List<dynamic> apiTeamMate7Assists = List.filled(20, 'null');

  late List<dynamic> apiTeamMate8Nick = List.filled(20, 'null');
  late List<dynamic> apiTeamMate8Champion = List.filled(20, 'null');
  late List<dynamic> apiTeamMate8Lane = List.filled(20, 'null');
  late List<dynamic> apiTeamMate8Kills = List.filled(20, 'null');
  late List<dynamic> apiTeamMate8Deaths = List.filled(20, 'null');
  late List<dynamic> apiTeamMate8Assists = List.filled(20, 'null');

  late List<dynamic> apiTeamMate9Nick = List.filled(20, 'null');
  late List<dynamic> apiTeamMate9Champion = List.filled(20, 'null');
  late List<dynamic> apiTeamMate9Lane = List.filled(20, 'null');
  late List<dynamic> apiTeamMate9Kills = List.filled(20, 'null');
  late List<dynamic> apiTeamMate9Deaths = List.filled(20, 'null');
  late List<dynamic> apiTeamMate9Assists = List.filled(20, 'null');

  late List<dynamic> apiTeamMate10Nick = List.filled(20, 'null');
  late List<dynamic> apiTeamMate10Champion = List.filled(20, 'null');
  late List<dynamic> apiTeamMate10Lane = List.filled(20, 'null');
  late List<dynamic> apiTeamMate10Kills = List.filled(20, 'null');
  late List<dynamic> apiTeamMate10Deaths = List.filled(20, 'null');
  late List<dynamic> apiTeamMate10Assists = List.filled(20, 'null');

  late List<dynamic> gameDuration = List.filled(20, 0.0);

  late List<dynamic> team1WinGame = List.filled(20, false);
  late List<dynamic> team2WinGame = List.filled(20, false);

  Future<void> updateScreen() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      loading = 'finish';
    });
  }

  void showToast(String mensagem, Color toastColor, String webColor) {
    Fluttertoast.showToast(
      msg: mensagem,
      backgroundColor: toastColor,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      fontSize: 14.0,
      webBgColor: webColor,
    );
  }

  apiRequest() async {
    url =
        'https://br1.api.riotgames.com/lol/summoner/v4/summoners/by-name/$nickPlayer';

    Network api = Network(url);

    apiData = await api.getData();

    if (apiData != -1) {
      apiPlayerLevel = apiData['summonerLevel'].toString();
      apiPlayerNick = apiData['name'];
      apiPlayerId = apiData['id'];
      apiPlayerPUUID = apiData['puuid'];
    }
  }

  apiRequestRank() async {
    url =
        'https://br1.api.riotgames.com/lol/league/v4/entries/by-summoner/$apiPlayerId';

    Network api = Network(url);

    apiDataRank = await api.getData();

    //Zerando as variáveis para caso você pesquise vários players seguidos
    //e encontre algum que não tenha elo (não trazer o da última busca)
    apiPlayerTierFlex = null;
    apiPlayerRankFlex = null;
    apiPlayerPointsFlex = null;
    apiPlayerWinsFlex = null;
    apiPlayerLossFlex = null;

    apiPlayerTierSoloQ = null;
    apiPlayerRankSoloQ = null;
    apiPlayerPointsSoloQ = null;
    apiPlayerWinsSoloQ = null;
    apiPlayerLossSoloQ = null;

    //Acho que a ordem é TFT, FLEX, SOLOQ
    if (apiData != -1) {
      if (apiDataRank.toString() != '[]') {
        if (apiDataRank[0]['queueType'] != 'RANKED_TFT_DOUBLE_UP') {
          if (apiDataRank[0]['queueType'] == 'RANKED_SOLO_5x5') {
            apiPlayerTierSoloQ = apiDataRank[0]['tier'];
            apiPlayerRankSoloQ = apiDataRank[0]['rank'];
            apiPlayerPointsSoloQ = apiDataRank[0]['leaguePoints'];
            apiPlayerWinsSoloQ = apiDataRank[0]['wins'];
            apiPlayerLossSoloQ = apiDataRank[0]['losses'];
          } else if (apiDataRank[0]['queueType'] == 'RANKED_FLEX_SR') {
            apiPlayerTierFlex = apiDataRank[0]['tier'];
            apiPlayerRankFlex = apiDataRank[0]['rank'];
            apiPlayerPointsFlex = apiDataRank[0]['leaguePoints'];
            apiPlayerWinsFlex = apiDataRank[0]['wins'];
            apiPlayerLossFlex = apiDataRank[0]['losses'];
          }
        }

        if (apiDataRank[1]['queueType'] != 'RANKED_TFT_DOUBLE_UP') {
          if (apiDataRank[1]['queueType'] == 'RANKED_SOLO_5x5') {
            apiPlayerTierSoloQ = apiDataRank[1]['tier'];
            apiPlayerRankSoloQ = apiDataRank[1]['rank'];
            apiPlayerPointsSoloQ = apiDataRank[1]['leaguePoints'];
            apiPlayerWinsSoloQ = apiDataRank[1]['wins'];
            apiPlayerLossSoloQ = apiDataRank[1]['losses'];
          } else if (apiDataRank[1]['queueType'] == 'RANKED_FLEX_SR') {
            apiPlayerTierFlex = apiDataRank[1]['tier'];
            apiPlayerRankFlex = apiDataRank[1]['rank'];
            apiPlayerPointsFlex = apiDataRank[1]['leaguePoints'];
            apiPlayerWinsFlex = apiDataRank[1]['wins'];
            apiPlayerLossFlex = apiDataRank[1]['losses'];
          }
        }

        if (apiDataRank[2]['queueType'] !=
            null) if (apiDataRank[2]['queueType'] != 'RANKED_TFT_DOUBLE_UP') {
          if (apiDataRank[2]['queueType'] == 'RANKED_SOLO_5x5') {
            apiPlayerTierSoloQ = apiDataRank[2]['tier'];
            apiPlayerRankSoloQ = apiDataRank[2]['rank'];
            apiPlayerPointsSoloQ = apiDataRank[2]['leaguePoints'];
            apiPlayerWinsSoloQ = apiDataRank[2]['wins'];
            apiPlayerLossSoloQ = apiDataRank[2]['losses'];
          } else if (apiDataRank[2]['queueType'] == 'RANKED_FLEX_SR') {
            apiPlayerTierFlex = apiDataRank[2]['tier'];
            apiPlayerRankFlex = apiDataRank[2]['rank'];
            apiPlayerPointsFlex = apiDataRank[2]['leaguePoints'];
            apiPlayerWinsFlex = apiDataRank[2]['wins'];
            apiPlayerLossFlex = apiDataRank[2]['losses'];
          }
        }
      }
    }
  }

  apiRequestGames() async {
    url =
        'https://americas.api.riotgames.com/lol/match/v5/matches/by-puuid/$apiPlayerPUUID/ids?start=0&count=20';

    Network api = Network(url);

    apiDataGames = await api.getData();

    if (apiDataGames.toString() != '[]') {
      apiGame1 = apiDataGames[0];
      apiGame2 = apiDataGames[1];
      apiGame3 = apiDataGames[2];
      apiGame4 = apiDataGames[3];
      apiGame5 = apiDataGames[4];
      apiGame6 = apiDataGames[5];
      apiGame7 = apiDataGames[6];
      apiGame8 = apiDataGames[7];
      apiGame9 = apiDataGames[8];
      apiGame10 = apiDataGames[9];
      apiGame11 = apiDataGames[10];
      apiGame12 = apiDataGames[11];
      apiGame13 = apiDataGames[12];
      apiGame14 = apiDataGames[13];
      apiGame15 = apiDataGames[14];
      apiGame16 = apiDataGames[15];
      apiGame17 = apiDataGames[16];
      apiGame18 = apiDataGames[17];
      apiGame19 = apiDataGames[18];
      apiGame20 = apiDataGames[19];
    }
  }

  apiRequestGameData(dynamic game, int x) async {
    url = 'https://americas.api.riotgames.com/lol/match/v5/matches/$game';

    Network api = Network(url);

    apiDataGame = await api.getData();

    //Game Duration em minutos
    gameDuration[x] = apiDataGame['info']['gameDuration'] / 60;
    gameDuration[x] = gameDuration[x].truncate();
    gameDuration[x] = gameDuration[x].toString();

    //Vitoria ou derrota
    team1WinGame[x] = apiDataGame['info']['teams'][0]['win'];
    team2WinGame[x] = apiDataGame['info']['teams'][1]['win'];

    //Carregando os dados dos jogadores por partida
    //----------------------------------------------
    apiTeamMate1Nick[x] =
        apiDataGame['info']['participants'][0]['summonerName'];
    apiTeamMate1Champion[x] =
        apiDataGame['info']['participants'][0]['championName'];
    apiTeamMate1Lane[x] = apiDataGame['info']['participants'][0]['lane'];
    apiTeamMate1Kills[x] = apiDataGame['info']['participants'][0]['kills'];
    apiTeamMate1Deaths[x] = apiDataGame['info']['participants'][0]['deaths'];
    apiTeamMate1Assists[x] = apiDataGame['info']['participants'][0]['assists'];

    //-----------------------------------------------

    apiTeamMate2Nick[x] =
        apiDataGame['info']['participants'][1]['summonerName'];
    apiTeamMate2Champion[x] =
        apiDataGame['info']['participants'][1]['championName'];
    apiTeamMate2Lane[x] = apiDataGame['info']['participants'][1]['lane'];
    apiTeamMate2Kills[x] = apiDataGame['info']['participants'][1]['kills'];
    apiTeamMate2Deaths[x] = apiDataGame['info']['participants'][1]['deaths'];
    apiTeamMate2Assists[x] = apiDataGame['info']['participants'][1]['assists'];

    //-----------------------------------------------

    apiTeamMate3Nick[x] =
        apiDataGame['info']['participants'][2]['summonerName'];
    apiTeamMate3Champion[x] =
        apiDataGame['info']['participants'][2]['championName'];
    apiTeamMate3Lane[x] = apiDataGame['info']['participants'][2]['lane'];
    apiTeamMate3Kills[x] = apiDataGame['info']['participants'][2]['kills'];
    apiTeamMate3Deaths[x] = apiDataGame['info']['participants'][2]['deaths'];
    apiTeamMate3Assists[x] = apiDataGame['info']['participants'][2]['assists'];

    //-----------------------------------------------

    apiTeamMate4Nick[x] =
        apiDataGame['info']['participants'][3]['summonerName'];
    apiTeamMate4Champion[x] =
        apiDataGame['info']['participants'][3]['championName'];
    apiTeamMate4Lane[x] = apiDataGame['info']['participants'][3]['lane'];
    apiTeamMate4Kills[x] = apiDataGame['info']['participants'][3]['kills'];
    apiTeamMate4Deaths[x] = apiDataGame['info']['participants'][3]['deaths'];
    apiTeamMate4Assists[x] = apiDataGame['info']['participants'][3]['assists'];

    //-----------------------------------------------

    apiTeamMate5Nick[x] =
        apiDataGame['info']['participants'][4]['summonerName'];
    apiTeamMate5Champion[x] =
        apiDataGame['info']['participants'][4]['championName'];
    apiTeamMate5Lane[x] = apiDataGame['info']['participants'][4]['lane'];
    apiTeamMate5Kills[x] = apiDataGame['info']['participants'][4]['kills'];
    apiTeamMate5Deaths[x] = apiDataGame['info']['participants'][4]['deaths'];
    apiTeamMate5Assists[x] = apiDataGame['info']['participants'][4]['assists'];

    //-----------------------------------------------

    apiTeamMate6Nick[x] =
        apiDataGame['info']['participants'][5]['summonerName'];
    apiTeamMate6Champion[x] =
        apiDataGame['info']['participants'][5]['championName'];
    apiTeamMate6Lane[x] = apiDataGame['info']['participants'][5]['lane'];
    apiTeamMate6Kills[x] = apiDataGame['info']['participants'][5]['kills'];
    apiTeamMate6Deaths[x] = apiDataGame['info']['participants'][5]['deaths'];
    apiTeamMate6Assists[x] = apiDataGame['info']['participants'][5]['assists'];

    //-----------------------------------------------

    apiTeamMate7Nick[x] =
        apiDataGame['info']['participants'][6]['summonerName'];
    apiTeamMate7Champion[x] =
        apiDataGame['info']['participants'][6]['championName'];
    apiTeamMate7Lane[x] = apiDataGame['info']['participants'][6]['lane'];
    apiTeamMate7Kills[x] = apiDataGame['info']['participants'][6]['kills'];
    apiTeamMate7Deaths[x] = apiDataGame['info']['participants'][6]['deaths'];
    apiTeamMate7Assists[x] = apiDataGame['info']['participants'][6]['assists'];

    //-----------------------------------------------

    apiTeamMate8Nick[x] =
        apiDataGame['info']['participants'][7]['summonerName'];
    apiTeamMate8Champion[x] =
        apiDataGame['info']['participants'][7]['championName'];
    apiTeamMate8Lane[x] = apiDataGame['info']['participants'][7]['lane'];
    apiTeamMate8Kills[x] = apiDataGame['info']['participants'][7]['kills'];
    apiTeamMate8Deaths[x] = apiDataGame['info']['participants'][7]['deaths'];
    apiTeamMate8Assists[x] = apiDataGame['info']['participants'][7]['assists'];

    //-----------------------------------------------

    apiTeamMate9Nick[x] =
        apiDataGame['info']['participants'][8]['summonerName'];
    apiTeamMate9Champion[x] =
        apiDataGame['info']['participants'][8]['championName'];
    apiTeamMate9Lane[x] = apiDataGame['info']['participants'][8]['lane'];
    apiTeamMate9Kills[x] = apiDataGame['info']['participants'][8]['kills'];
    apiTeamMate9Deaths[x] = apiDataGame['info']['participants'][8]['deaths'];
    apiTeamMate9Assists[x] = apiDataGame['info']['participants'][8]['assists'];

    //-----------------------------------------------

    apiTeamMate10Nick[x] =
        apiDataGame['info']['participants'][9]['summonerName'];
    apiTeamMate10Champion[x] =
        apiDataGame['info']['participants'][9]['championName'];
    apiTeamMate10Lane[x] = apiDataGame['info']['participants'][9]['lane'];
    apiTeamMate10Kills[x] = apiDataGame['info']['participants'][9]['kills'];
    apiTeamMate10Deaths[x] = apiDataGame['info']['participants'][9]['deaths'];
    apiTeamMate10Assists[x] = apiDataGame['info']['participants'][9]['assists'];

    //-----------------------------------------------
  }

  apiRequestTopPlayers() async {
    url =
        'https://br1.api.riotgames.com/lol/league/v4/challengerleagues/by-queue/RANKED_SOLO_5x5';

    Network api = Network(url);

    apiDataTopPlayers = await api.getData();

    for (int i = 0; i < 200; i++) {
      apiTopPlayersListId[i] = apiDataTopPlayers['entries'][i]['summonerId'];
      apiTopPlayersListName[i] =
          apiDataTopPlayers['entries'][i]['summonerName'];
      apiTopPlayersListPoints[i] =
          apiDataTopPlayers['entries'][i]['leaguePoints'];
    }

    //ORDENAÇÃO DOS VETORES POR ORDEM DE LIST POINTS
    needToChange = 0;
    while (needToChange < 200) {
      for (int i = 0; i < 199; i++) {
        //Ordenando o ELO em orden decrescente
        if (apiTopPlayersListPoints[i + 1] > apiTopPlayersListPoints[i]) {
          int aux = apiTopPlayersListPoints[i + 1];
          apiTopPlayersListPoints[i + 1] = apiTopPlayersListPoints[i];
          apiTopPlayersListPoints[i] = aux;
          //Ajustando os nomes dos players em cada iteração
          String auxName = apiTopPlayersListName[i + 1];
          apiTopPlayersListName[i + 1] = apiTopPlayersListName[i];
          apiTopPlayersListName[i] = auxName;
        }
      }
      needToChange++;
    }
    flag = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('LEAGUE OF LEGENDS'),
        shadowColor: Colors.purple,
        actions: [
          PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              icon: Icon(Icons.account_circle_rounded),
              itemBuilder: (context) {
                return [
                  /*PopupMenuItem<int>(
                    value: 0,
                    child: Text(
                      "Perfil",
                      style: TextStyle(color: Colors.deepPurpleAccent),
                    ),
                  ),*/
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text("Challengers",
                        style: TextStyle(color: Colors.deepPurpleAccent)),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Text("Fechar App",
                        style: TextStyle(color: Colors.deepPurpleAccent)),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PerfilScreen()),
                  );
                  print(
                      "Redirecionar para página de perfil - salvar nome de invocador");
                } else if (value == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChallengersScreen()),
                  );
                  print("Redirecionar para página dos Challengers ");
                } else if (value == 2) {
                  SystemNavigator.pop();
                  print("Fechar App");
                }
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'images/loliconscreen.png',
                width: 80,
                height: 80,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    child: SizedBox(
                      width: 210,
                      height: 50,
                      child: TextField(
                        style: TextStyle(color: Colors.deepPurpleAccent),
                        onChanged: (typed) {
                          nickPlayer = typed;
                        },
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.blueAccent,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.purpleAccent,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 30),
                          hintText: 'Nome do Invocador',
                          hintStyle: TextStyle(
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        exibirJogos[0] = false;
                        exibirJogos[1] = false;
                        exibirJogos[2] = false;
                        exibirJogos[3] = false;
                        exibirJogos[4] = false;
                        exibirJogos[5] = false;
                        exibirJogos[6] = false;
                        exibirJogos[7] = false;
                        exibirJogos[8] = false;
                        exibirJogos[9] = false;
                        exibirJogos[10] = false;
                        exibirJogos[11] = false;
                        exibirJogos[12] = false;
                        exibirJogos[13] = false;
                        exibirJogos[14] = false;
                        exibirJogos[15] = false;
                        exibirJogos[16] = false;
                        exibirJogos[17] = false;
                        exibirJogos[18] = false;
                        exibirJogos[19] = false;

                        //Aqui primeiro ele pega os dados, depois ranking, depois atualiza tela
                        if (nickPlayer != '') {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            loading = 'loading';
                            apiRequest().then((finish) {
                              apiRequestRank();
                            }).then((atualizar) {
                              updateScreen();
                            }).then((games) {
                              apiRequestGames();
                            });
                          });
                        } else {
                          showToast('Por favor entre com o nome do Invocador',
                              Colors.deepPurpleAccent, '#225251');
                        }
                      },
                      child: Text(
                        'Pesquisar',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                child: SizedBox(
                  width: 330,
                  child: Text(
                    'Descubra o elo Ranked SOLOQ e FLEX dos jogadores do servidor de League of Legends brasileiro!',
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // RESULTADO DA PESQUISA
              if (loading == 'loading')
                Column(
                  children: const [
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      child: SizedBox(
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ],
                ),
              if (loading == 'finish' && apiData == -1)
                Column(
                  children: [
                    SizedBox(
                      height: 22,
                    ),
                    Center(
                      child: Text(
                        'Invocador não encontrado',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'images/teemo-sad.png',
                      width: 180,
                      height: 180,
                    ),
                  ],
                ),

              if (loading == 'finish' && apiData != -1)
                Center(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            '$apiPlayerNick',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                          Text(
                            'Level: $apiPlayerLevel',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.lightGreen,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //RANKED SOLOQ
                              if (apiPlayerTierSoloQ != null)
                                Column(
                                  children: [
                                    Text(
                                      'RANKED SOLOQ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                    ),
                                    if (apiPlayerTierSoloQ == 'IRON')
                                      Image.asset(
                                        'images/tier-icons/Iron.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    if (apiPlayerTierSoloQ == 'BRONZE')
                                      Image.asset(
                                        'images/tier-icons/Bronze.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    if (apiPlayerTierSoloQ == 'SILVER')
                                      Image.asset(
                                        'images/tier-icons/Silver.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    if (apiPlayerTierSoloQ == 'GOLD')
                                      Image.asset(
                                        'images/tier-icons/Gold.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    if (apiPlayerTierSoloQ == 'PLATINUM')
                                      Image.asset(
                                        'images/tier-icons/Platinum.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    if (apiPlayerTierSoloQ == 'DIAMOND')
                                      Image.asset(
                                        'images/tier-icons/Diamond.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    if (apiPlayerTierSoloQ == 'MASTER')
                                      Image.asset(
                                        'images/tier-icons/Master.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    if (apiPlayerTierSoloQ == 'GRANDMASTER')
                                      Image.asset(
                                        'images/tier-icons/Grandmaster.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    if (apiPlayerTierSoloQ == 'CHALLENGER')
                                      Image.asset(
                                        'images/tier-icons/challenger.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '$apiPlayerTierSoloQ $apiPlayerRankSoloQ - $apiPlayerPointsSoloQ PDL',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                    Text('Vitórias: $apiPlayerWinsSoloQ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.lightBlue,
                                        )),
                                    Text(
                                      'Derrotas: $apiPlayerLossSoloQ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(
                                width: 20,
                              ),
                              //RANKED FLEX
                              if (apiPlayerTierFlex != null)
                                Column(
                                  children: [
                                    Text(
                                      'RANKED FLEX',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                    ),
                                    //RANKED SOLOQ
                                    if (apiPlayerTierFlex == 'IRON')
                                      Image.asset(
                                        'images/tier-icons/Iron.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    if (apiPlayerTierFlex == 'BRONZE')
                                      Image.asset(
                                        'images/tier-icons/Bronze.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    if (apiPlayerTierFlex == 'SILVER')
                                      Image.asset(
                                        'images/tier-icons/Silver.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    if (apiPlayerTierFlex == 'GOLD')
                                      Image.asset(
                                        'images/tier-icons/Gold.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    if (apiPlayerTierFlex == 'PLATINUM')
                                      Image.asset(
                                        'images/tier-icons/Platinum.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    if (apiPlayerTierFlex == 'DIAMOND')
                                      Image.asset(
                                        'images/tier-icons/Diamond.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    if (apiPlayerTierFlex == 'MASTER')
                                      Image.asset(
                                        'images/tier-icons/Master.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    if (apiPlayerTierFlex == 'GRANDMASTER')
                                      Image.asset(
                                        'images/tier-icons/Grandmaster.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    if (apiPlayerTierFlex == 'CHALLENGER')
                                      Image.asset(
                                        'images/tier-icons/challenger.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        '$apiPlayerTierFlex $apiPlayerRankFlex - $apiPlayerPointsFlex PDL',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.lightBlue,
                                        )),
                                    Text('Vitórias: $apiPlayerWinsFlex',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.lightBlue,
                                        )),
                                    Text(
                                      'Derrotas: $apiPlayerLossFlex',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.lightBlue,
                              fixedSize: const Size(160, 45),
                            ),
                            onPressed: () {
                              setState(() {
                                botao_clicado = true;
                              });
                              if (apiGame1 != null) {
                                apiRequestGameData(apiGame1, 0)
                                    .then((exibirjogos) {
                                  exibirJogos[0] = true;
                                  botao_clicado = false;
                                }).then((atualizar) {
                                  updateScreen();
                                });
                              }
                              if (apiGame2 != null) {
                                apiRequestGameData(apiGame2, 1)
                                    .then((exibirjogos) {
                                  exibirJogos[1] = true;
                                  botao_clicado = false;
                                }).then((atualizar) {
                                  updateScreen();
                                });
                              }
                              if (apiGame3 != null) {
                                apiRequestGameData(apiGame3, 2)
                                    .then((exibirjogos) {
                                  exibirJogos[2] = true;
                                  botao_clicado = false;
                                }).then((atualizar) {
                                  updateScreen();
                                });
                              }
                              if (apiGame4 != null) {
                                apiRequestGameData(apiGame4, 3)
                                    .then((exibirjogos) {
                                  exibirJogos[3] = true;
                                  botao_clicado = false;
                                }).then((atualizar) {
                                  updateScreen();
                                });
                              }
                              if (apiGame5 != null) {
                                apiRequestGameData(apiGame5, 4)
                                    .then((exibirjogos) {
                                  exibirJogos[4] = true;
                                  botao_clicado = false;
                                }).then((atualizar) {
                                  updateScreen();
                                });
                              }
                              if (apiGame6 != null) {
                                apiRequestGameData(apiGame6, 5)
                                    .then((exibirjogos) {
                                  exibirJogos[5] = true;
                                  botao_clicado = false;
                                }).then((atualizar) {
                                  updateScreen();
                                });
                              }
                              if (apiGame7 != null) {
                                apiRequestGameData(apiGame7, 6)
                                    .then((exibirjogos) {
                                  exibirJogos[6] = true;
                                  botao_clicado = false;
                                }).then((atualizar) {
                                  updateScreen();
                                });
                              }
                              if (apiGame8 != null) {
                                apiRequestGameData(apiGame8, 7)
                                    .then((exibirjogos) {
                                  exibirJogos[7] = true;
                                  botao_clicado = false;
                                }).then((atualizar) {
                                  updateScreen();
                                });
                              }
                              if (apiGame9 != null) {
                                apiRequestGameData(apiGame9, 8)
                                    .then((exibirjogos) {
                                  exibirJogos[8] = true;
                                  botao_clicado = false;
                                }).then((atualizar) {
                                  updateScreen();
                                });
                              }
                              if (apiGame10 != null) {
                                apiRequestGameData(apiGame10, 9)
                                    .then((exibirjogos) {
                                  exibirJogos[9] = true;
                                  botao_clicado = false;
                                }).then((atualizar) {
                                  updateScreen();
                                });
                              }
                              if (apiGame11 != null) {
                                apiRequestGameData(apiGame11, 10)
                                    .then((exibirjogos) {
                                  exibirJogos[10] = true;
                                  botao_clicado = false;
                                }).then((atualizar) {
                                  updateScreen();
                                });
                              }
                              if (apiGame12 != null) {
                                apiRequestGameData(apiGame12, 11)
                                    .then((exibirjogos) {
                                  exibirJogos[11] = true;
                                  botao_clicado = false;
                                }).then((atualizar) {
                                  updateScreen();
                                });
                              }
                              if (apiGame13 != null) {
                                apiRequestGameData(apiGame13, 12)
                                    .then((exibirjogos) {
                                  exibirJogos[12] = true;
                                  botao_clicado = false;
                                }).then((atualizar) {
                                  updateScreen();
                                });
                              }
                              if (apiGame14 != null) {
                                apiRequestGameData(apiGame14, 13)
                                    .then((exibirjogos) {
                                  exibirJogos[13] = true;
                                  botao_clicado = false;
                                }).then((atualizar) {
                                  updateScreen();
                                });
                              }
                              if (apiGame15 != null) {
                                apiRequestGameData(apiGame15, 14)
                                    .then((exibirjogos) {
                                  exibirJogos[14] = true;
                                  botao_clicado = false;
                                }).then((atualizar) {
                                  updateScreen();
                                });
                              }
                              if (apiGame16 != null) {
                                apiRequestGameData(apiGame16, 15)
                                    .then((exibirjogos) {
                                  exibirJogos[15] = true;
                                  botao_clicado = false;
                                }).then((atualizar) {
                                  updateScreen();
                                });
                              }
                              if (apiGame17 != null) {
                                apiRequestGameData(apiGame17, 16)
                                    .then((exibirjogos) {
                                  exibirJogos[16] = true;
                                  botao_clicado = false;
                                }).then((atualizar) {
                                  updateScreen();
                                });
                              }
                              if (apiGame18 != null) {
                                apiRequestGameData(apiGame18, 17)
                                    .then((exibirjogos) {
                                  exibirJogos[17] = true;
                                  botao_clicado = false;
                                }).then((atualizar) {
                                  updateScreen();
                                });
                              }
                              if (apiGame19 != null) {
                                apiRequestGameData(apiGame19, 18)
                                    .then((exibirjogos) {
                                  exibirJogos[18] = true;
                                  botao_clicado = false;
                                }).then((atualizar) {
                                  updateScreen();
                                });
                              }
                              if (apiGame20 != null) {
                                apiRequestGameData(apiGame20, 19)
                                    .then((exibirjogos) {
                                  exibirJogos[19] = true;
                                  botao_clicado = false;
                                }).then((atualizar) {
                                  updateScreen();
                                });
                              }

                              exibirJogos[0] = false;
                              exibirJogos[1] = false;
                              exibirJogos[2] = false;
                              exibirJogos[3] = false;
                              exibirJogos[4] = false;
                              exibirJogos[5] = false;
                              exibirJogos[6] = false;
                              exibirJogos[7] = false;
                              exibirJogos[8] = false;
                              exibirJogos[9] = false;
                              exibirJogos[10] = false;
                              exibirJogos[11] = false;
                              exibirJogos[12] = false;
                              exibirJogos[13] = false;
                              exibirJogos[14] = false;
                              exibirJogos[15] = false;
                              exibirJogos[16] = false;
                              exibirJogos[17] = false;
                              exibirJogos[18] = false;
                              exibirJogos[19] = false;
                            },
                            child: Text(
                              'Exibir jogos',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      for (int i = 0; i < 20; i++)
                        if (exibirJogos[i] == true)
                          Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                        'Duração da partida: ${gameDuration[i]} minutos'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 140,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (team1WinGame[i] == true)
                                                Text(
                                                  'VITÓRIA',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.lightGreen),
                                                ),
                                              if (team1WinGame[i] == false)
                                                Text(
                                                  'DERROTA',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.deepOrange),
                                                ),
                                              SelectableText(
                                                apiTeamMate1Nick[i],
                                                style: gameNicksStyle,
                                              ),
                                              Text(
                                                  '${apiTeamMate1Kills[i]}/${apiTeamMate1Deaths[i]}/${apiTeamMate1Assists[i]}'),
                                              Text(apiTeamMate1Champion[i]),
                                              Text(apiTeamMate1Lane[i]),
                                              SelectableText(
                                                apiTeamMate2Nick[i],
                                                style: gameNicksStyle,
                                              ),
                                              Text(
                                                  '${apiTeamMate2Kills[i]}/${apiTeamMate2Deaths[i]}/${apiTeamMate2Assists[i]}'),
                                              Text(apiTeamMate2Champion[i]),
                                              Text(apiTeamMate2Lane[i]),
                                              SelectableText(
                                                apiTeamMate3Nick[i],
                                                style: gameNicksStyle,
                                              ),
                                              Text(
                                                  '${apiTeamMate3Kills[i]}/${apiTeamMate3Deaths[i]}/${apiTeamMate3Assists[i]}'),
                                              Text(apiTeamMate3Champion[i]),
                                              Text(apiTeamMate3Lane[i]),
                                              SelectableText(
                                                apiTeamMate4Nick[i],
                                                style: gameNicksStyle,
                                              ),
                                              Text(
                                                  '${apiTeamMate4Kills[i]}/${apiTeamMate4Deaths[i]}/${apiTeamMate4Assists[i]}'),
                                              Text(apiTeamMate4Champion[i]),
                                              Text(apiTeamMate4Lane[i]),
                                              SelectableText(
                                                apiTeamMate5Nick[i],
                                                style: gameNicksStyle,
                                              ),
                                              Text(
                                                  '${apiTeamMate5Kills[i]}/${apiTeamMate5Deaths[i]}/${apiTeamMate5Assists[i]}'),
                                              Text(apiTeamMate5Champion[i]),
                                              Text(apiTeamMate5Lane[i]),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Text(
                                          'VS',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.green,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Container(
                                          width: 140,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (team2WinGame[i] == true)
                                                Text(
                                                  'VITÓRIA',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.lightGreen),
                                                ),
                                              if (team2WinGame[i] == false)
                                                Text(
                                                  'DERROTA',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.deepOrange),
                                                ),
                                              SelectableText(
                                                apiTeamMate6Nick[i],
                                                style: gameNicksStyle,
                                              ),
                                              Text(
                                                  '${apiTeamMate6Kills[i]}/${apiTeamMate6Deaths[i]}/${apiTeamMate6Assists[i]}'),
                                              Text(apiTeamMate6Champion[i]),
                                              Text(apiTeamMate6Lane[i]),
                                              SelectableText(
                                                apiTeamMate7Nick[i],
                                                style: gameNicksStyle,
                                              ),
                                              Text(
                                                  '${apiTeamMate7Kills[i]}/${apiTeamMate7Deaths[i]}/${apiTeamMate7Assists[i]}'),
                                              Text(apiTeamMate7Champion[i]),
                                              Text(apiTeamMate7Lane[i]),
                                              SelectableText(
                                                apiTeamMate8Nick[i],
                                                style: gameNicksStyle,
                                              ),
                                              Text(
                                                  '${apiTeamMate8Kills[i]}/${apiTeamMate8Deaths[i]}/${apiTeamMate8Assists[i]}'),
                                              Text(apiTeamMate8Champion[i]),
                                              Text(apiTeamMate8Lane[i]),
                                              SelectableText(
                                                apiTeamMate9Nick[i],
                                                style: gameNicksStyle,
                                              ),
                                              Text(
                                                  '${apiTeamMate9Kills[i]}/${apiTeamMate9Deaths[i]}/${apiTeamMate9Assists[i]}'),
                                              Text(apiTeamMate9Champion[i]),
                                              Text(apiTeamMate9Lane[i]),
                                              SelectableText(
                                                apiTeamMate10Nick[i],
                                                style: gameNicksStyle,
                                              ),
                                              Text(
                                                  '${apiTeamMate10Kills[i]}/${apiTeamMate10Deaths[i]}/${apiTeamMate10Assists[i]}'),
                                              Text(apiTeamMate10Champion[i]),
                                              Text(apiTeamMate10Lane[i]),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      if (botao_clicado == true)
                        Column(
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            Align(
                              child: SizedBox(
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
