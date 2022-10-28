import 'package:flutter/material.dart';
import 'package:leagueoflegends/network.dart';
import 'BaseScreen.dart';

class ChallengersScreen extends StatefulWidget {
  const ChallengersScreen({Key? key}) : super(key: key);

  @override
  State<ChallengersScreen> createState() => _ChallengersScreenState();
}

class _ChallengersScreenState extends State<ChallengersScreen> {
  String url = '';
  int needToChange = 0;
  bool flag = false;
  String loading = 'Start';
  List<bool> showVitorias = List.filled(200, false);

  dynamic apiDataTopPlayers;
  late List<dynamic> apiTopPlayersListId = List.filled(200, 'players');
  late List<dynamic> apiTopPlayersListName = List.filled(200, 'players');
  late List<dynamic> apiTopPlayersListPoints = List.filled(200, 'players');

  dynamic apiTopPlayersWins = List.filled(200, -1);
  dynamic apiTopPlayersLoss = List.filled(200, -1);

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
      // Vitorias e Derrotas
      apiTopPlayersWins[i] = apiDataTopPlayers['entries'][i]['wins'];
      apiTopPlayersLoss[i] = apiDataTopPlayers['entries'][i]['losses'];
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

          //Ajustando as vitórias e derrotas em cada iteração
          int auxVitorias = apiTopPlayersWins[i + 1];
          apiTopPlayersWins[i + 1] = apiTopPlayersWins[i];
          apiTopPlayersWins[i] = auxVitorias;
          int auxDerrotas = apiTopPlayersLoss[i + 1];
          apiTopPlayersLoss[i + 1] = apiTopPlayersLoss[i];
          apiTopPlayersLoss[i] = auxDerrotas;
        }
      }
      needToChange++;
    }
    flag = true;
  }

  @override
  void initState() {
    super.initState();
    loading = 'loading';
    apiRequestTopPlayers().then((finish) {
      updateScreen();
    });
  }

  Future<void> updateScreen() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      loading = 'finish';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('LEAGUE OF LEGENDS'),
        shadowColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'images/tier-icons/challenger.png',
                      width: 80,
                      height: 80,
                    ),
                    Text(
                      'LEADERBOARD',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.lightBlue,
                      ),
                    ),
                    Image.asset(
                      'images/tier-icons/challenger.png',
                      width: 80,
                      height: 80,
                    ),
                  ],
                ),
                if (loading == 'finish')
                  for (int i = 0; i < 200; i++)
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              ' ${i + 1}',
                              style: TextStyle(
                                color: Colors.orangeAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.lightBlue,
                                fixedSize: const Size(160, 45),
                              ),
                              onPressed: () {
                                setState(() {
                                  showVitorias[i] = !showVitorias[i];
                                });
                              },
                              child: Text(
                                '${apiTopPlayersListName[i]}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(
                              '${apiTopPlayersListPoints[i]} PDL',
                              style: TextStyle(
                                color: Colors.orangeAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (showVitorias[i] == true)
                          Column(
                            children: [
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Vitórias: ',
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    '${apiTopPlayersWins[i]} ',
                                    style: TextStyle(
                                      color: Colors.lightGreen,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    'Derrotas: ',
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    '${apiTopPlayersLoss[i]}',
                                    style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                            ],
                          ),
                        Container(
                          width: double.infinity,
                          height: 1.5, // Thickness
                          color: Colors.teal,
                        ),
                      ],
                    ),
                SizedBox(
                  height: 20,
                ),
                if (loading == 'loading')
                  Column(
                    children: const [
                      SizedBox(
                        height: 50,
                      ),
                      Align(
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
