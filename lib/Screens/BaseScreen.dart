import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:leagueoflegends/Screens/ChallengersScreen.dart';
import 'package:leagueoflegends/Screens/PerfilScreen.dart';
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

  dynamic apiTeamMate1Nick;
  dynamic apiTeamMate2Nick;
  dynamic apiTeamMate3Nick;
  dynamic apiTeamMate4Nick;
  dynamic apiTeamMate5Nick;
  dynamic apiTeamMate6Nick;
  dynamic apiTeamMate7Nick;
  dynamic apiTeamMate8Nick;
  dynamic apiTeamMate9Nick;
  dynamic apiTeamMate10Nick;

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

  apiRequestGameData(dynamic game) async {
    url = 'https://americas.api.riotgames.com/lol/match/v5/matches/$apiGame1';

    Network api = Network(url);

    apiDataGame = await api.getData();

    apiTeamMate1Nick = apiDataGame['info']['participants'][0]['summonerName'];
    apiTeamMate2Nick = apiDataGame['info']['participants'][1]['summonerName'];
    apiTeamMate3Nick = apiDataGame['info']['participants'][3]['summonerName'];
    apiTeamMate4Nick = apiDataGame['info']['participants'][4]['summonerName'];
    apiTeamMate5Nick = apiDataGame['info']['participants'][5]['summonerName'];
    apiTeamMate6Nick = apiDataGame['info']['participants'][6]['summonerName'];
    apiTeamMate7Nick = apiDataGame['info']['participants'][7]['summonerName'];
    apiTeamMate8Nick = apiDataGame['info']['participants'][8]['summonerName'];
    apiTeamMate9Nick = apiDataGame['info']['participants'][9]['summonerName'];
    apiTeamMate10Nick = apiDataGame['info']['participants'][10]['summonerName'];
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
                        //Aqui primeiro ele pega os dados, depois ranking, depois atualiza tela
                        if (nickPlayer != '') {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            loading = 'loading';
                            apiRequest().then((finish) {
                              apiRequestRank();
                            }).then((atualizar) {
                              updateScreen();
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
