import 'dart:math';

import 'package:cruzadista/components/alert_dialog_dica.dart';
import 'package:cruzadista/components/colors.dart';
import 'package:cruzadista/model/cruzada.dart';
import 'package:cruzadista/ui/game/puz_file.dart';
import 'package:cruzadista/ui/game/sucess_game.dart';
import 'package:cruzadista/ui/game/word_position.dart';
import 'package:flutter/material.dart';
import '../../components/crosswordview.dart';
import '../../components/fonte_size.dart';
import '../../config/constants.dart';
import '../../config/preferences.dart';
import '../../config/requests.dart';

class Game extends StatefulWidget {
  Cruzada cruzada;

  Game({Key? key, required this.cruzada}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late List<int> _gridElements;

  late List<String> _acrossClues;

  late List<String> _downClues;
  var _theme = Colors.white;
  var _colorCell = Colors.white;
  var _colorCellKeyboard = Colors.black;
  var _colorTextKeyboard = Colors.white;
  var _colorText = MyColors.colorCellDark;
  var _themeDark = MyColors.darkMode;
  List<String> usedLetters = [];

  bool _reveltionWord = false;
  bool _reveltionLetre = false;
  bool isTyperFinish = true;
  bool _reveltionCrossword = false;

  PuzFile puzFile = PuzFile.empty();

  //final String fileUrl = 'https://wetransfer.com/downloads/6d100658bb755a3bef7e44ec95b038c620230613174114/43c6cae7e67bfd39ecf9178fd953b02720230613174142/5e45af?trk=TRN_TDL_01&utm_campaign=TRN_TDL_01&utm_medium=email&utm_source=sendgrid';
  //final String fileUrl = 'https://cruzadista.com.br/uploads/cruzadas/cf99b8ff9624cb90ab364c56a56733d8.puz';
  int selectedWordIndex = -1;
  int startRowVertic = -1;
  int startColVertic = -1;
  int endRowVertic = -1;
  int endColVertic = -1; // Variáveis para armazenar as posições
  int startRow = -1;
  int startCol = -1;
  int endRow = -1;
  int endCol = -1;
  bool isHorizontal = false;
  int rowAll = 0;
  int colAll = 0;
  bool isDoubleClick = false;
  DateTime? lastTapTime;
  List<String> alphabet = ['ABCDEFGHIJKLMNOPQRSTUVWXYZ'];
  final requestsWebServices = RequestsWebServices(WSConstantes.URLBASE);
  List<String> keyboardLetters = [];
  bool isCompleted = false;

// Lista de letras do teclado
  String selectedWord = ''; // Palavra selecionada
  bool showKeyboard = false;
  List<List<int>> verticalWordPositions = [];
  String wordHint = "";
  bool _isLoading = true;

  //keyboardLetters.addAll(List.generate(5, (_) => alphabet[Random().nextInt(alphabet.length)]));
  String getRandomLetter() {
    Random random = Random();
    int randomNumber = random.nextInt(26); // Gera um número aleatório de 0 a 25
    String alphabet = 'abcdefghijklmnopqrstuvwxyz';
    return alphabet[randomNumber];
  }

  Future<void> concludeCruazad(String idCruzadas) async {
    try {
      await Preferences.init();
      final userId = Preferences.getUserData()?.id;

      final body = {
        WSConstantes.ID: userId,
        WSConstantes.ID_CRUZADA: idCruzadas,
        WSConstantes.TOKENID: WSConstantes.TOKEN
      };

      final List<dynamic> decodedResponse = await requestsWebServices
          .sendPostRequestList(WSConstantes.CONCLUDE_CRUZADA, body);
      if (decodedResponse.isNotEmpty) {
        setState(() {
          final crossWord = Cruzada(
            status: decodedResponse[0]['status'],
            msg: decodedResponse[0]['msg'],
          );
          if (crossWord.status == "01") {
            setState(() {
              isCompleted = true;
            });
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SucessGame()));
          }
        });
      } else {
        print('NULO');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    String? url = widget.cruzada.url;
    String fileUrl = 'https://cruzadista.com.br/uploads/cruzadas/$url';
    print(fileUrl);

    Future.delayed(Duration(seconds: 1)).then((_) {
      loadPuzFile(fileUrl).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });

    autoFillSolution(_reveltionCrossword);
  }

  void printGridWithWords() {
    print('Grid com palavras preenchidas:');

    // Impressão das palavras na horizontal
    print('Horizontal:');
    for (int row = 0; row < puzFile.height; row++) {
      String rowString = '';
      for (int col = 0; col < puzFile.width; col++) {
        rowString += puzFile.playerSolution[row][col] + ' ';
      }
      print(rowString);
    }

    // Impressão das palavras na vertical
    print('Vertical:');
    for (int col = 0; col < puzFile.width; col++) {
      String colString = '';
      for (int row = 0; row < puzFile.height; row++) {
        colString += puzFile.playerSolution[row][col] + '\n';

        if (puzFile.playerSolution[row][col] != '.' &&
            (row == 0 || puzFile.playerSolution[row - 1][col] == '.')) {
          verticalWordPositions.add([row, col]);
        }
      }
      print(colString);
    }

    List<String> words = puzFile.listAllWords(puzFile.solution);
    print('lista de palavras:');
    for (String word in words) {
      print(word);
    }
  }

  Future<void> loadPuzFile(String fileUrl) async {
    await puzFile.parse(fileUrl);
    setState(() {});
  }

  void updatePlayerSolution(int row, int col, String value) {
    setState(() {
      puzFile.playerSolution[row][col] = value.toUpperCase();
    });
  }

  Color getCellColor(int row, int col) {
    if (row >= startRow && row <= endRow && col >= startCol && col <= endCol) {
      return Colors.green.withOpacity(0.5);
    } else if (row >= startRowVertic &&
        row <= endRowVertic &&
        col == startColVertic) {
      return Colors.green.withOpacity(0.5);
    } else if (puzFile.solution[row][col] == '.') {
      return Colors.black;
    } else if (puzFile.playerSolution[row][col] == puzFile.solution[row][col]) {
      return Colors.lightGreen;
    } else {
      return _colorCell;
    }
  }

  void selectWord(int index) {
    setState(() {
      selectedWordIndex = index;
      String hint =
          getWordHint(index, puzFile.wordStartPositions, puzFile.strings);
      // Exiba a dica abaixo do grid ou faça algo com ela
      print(hint);
      wordHint = hint;
    });
  }

  void deselectWord() {
    setState(() {
      selectedWordIndex = -1;
    });
  }

  void autoFillSolution(bool relevetionCrossword) {
    if (relevetionCrossword) {
      setState(() {
        puzFile.autoFillSolution();
      });
    }
  }

  void findWordCoordinates(String word) {
    for (int row = 0; row < puzFile.height; row++) {
      for (int col = 0; col < puzFile.width; col++) {
        if (puzFile.playerSolution[row][col] == word[0]) {
          // Check if word matches horizontally to the right
          if (col + word.length <= puzFile.width) {
            bool matches = true;
            for (int i = 1; i < word.length; i++) {
              if (puzFile.playerSolution[row][col + i] != word[i]) {
                matches = false;
                break;
              }
            }
            if (matches) {
              startRow = row;
              startCol = col;
              endRow = row;
              endCol = col + word.length - 1;
              return;
            }
          }

          // Check if word matches vertically downwards
          if (row + word.length <= puzFile.height) {
            bool matches = true;
            for (int i = 1; i < word.length; i++) {
              if (puzFile.playerSolution[row + i][col] != word[i]) {
                matches = false;
                break;
              }
            }
            if (matches) {
              setState(() {
                startRowVertic = row;
                startColVertic = col;
                endRowVertic = row + word.length - 1;
                endColVertic = col;
              });
              return;
            }
          }
        }
      }
    }
  }

  WordPosition findContainingWord(
      List<WordPosition> wordPositions, int row, int col) {
    for (WordPosition wordPosition in wordPositions) {
      if (wordPosition.containsCell(row, col)) {
        return wordPosition;
      }
    }
    return null!;
  }

  void revealLetter(int row, int col, String value) {
    setState(() {
      if (puzFile.playerSolution[row][col] == "") {
        puzFile.playerSolution[row][col] = value.toUpperCase();
      }
    });
  }

  void resetGame() {
    setState(() {
      // Redefinir as variáveis de controle da seleção
      startRow = -1;
      startCol = -1;
      endRow = -1;
      endCol = -1;
      isHorizontal = false;
      isDoubleClick = false;
      //selectedRow = -1;
      // selectedCol = -1;

      // Redefinir a solução do jogador
      for (int row = 0; row < puzFile.solution.length; row++) {
        for (int col = 0; col < puzFile.solution[row].length; col++) {
          if (puzFile.solution[row][col] != '.') {
            puzFile.playerSolution[row][col] = ''; // Remover a letra revelada
          }
        }
      }
    });
  }

  bool isGameCompleted() {
    for (int row = 0; row < puzFile.height; row++) {
      for (int col = 0; col < puzFile.width; col++) {
        if (puzFile.solution[row][col] != '.' &&
            puzFile.playerSolution[row][col] != puzFile.solution[row][col]) {
          return false;
        }
      }
    }
    return true;
  }

  List<String> alphabet1 = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "delete",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
    "vertical/horizontal"
  ];

// Função para atualizar a palavra selecionada
  void updateSelectedWord(String word) {
    setState(() {
      selectedWord = word;
      List<String> alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');

      if (selectedWord.length < 12) {
        int remaining = 12 - selectedWord.length;
        List<String> additionalLetters = alphabet.sublist(0, remaining);
        selectedWord += additionalLetters.join('');
      }

      keyboardLetters = shuffleWord(selectedWord).split('');
    });
  }

// Função para embaralhar as letras de uma palavra
  String shuffleWord(String word) {
    List<String> letters = word.split('');
    letters.shuffle();
    return letters.join('');
  }

  String getWordHint(int wordNumber, List<List<int>> wordStartPositions,
      List<String> strings) {
    int index = wordNumber - 1;
    if (index >= 0 && index < wordStartPositions.length) {
      List<int> startPosition = wordStartPositions[index];
      int startRow = startPosition[0];
      int startCol = startPosition[1];
      return strings[index] +
          " (" +
          (startRow + 1).toString() +
          ", " +
          (startCol + 1).toString() +
          ")";
    }
    return '';
  }

  //Metodos de revelar palavra, letra e mostra completo caso tive completo

  void reveltionWord() {
    if (isHorizontal) {
      // Seleção horizontal
      for (int colIndex = startCol; colIndex <= endCol; colIndex++) {
        String letter = puzFile.solution[rowAll][colIndex];
        selectedWord += letter;
        revealLetter(rowAll, colIndex, letter);
      }
    } else {
      // Seleção vertical
      for (int rowIndex = startRow; rowIndex <= endRow; rowIndex++) {
        String letter = puzFile.solution[rowIndex][colAll];
        selectedWord += letter;
        revealLetter(rowIndex, colAll, letter);
      }
    }
    // Aqui você pode fazer algo com a palavra selecionada, como exibi-la ou processá-la de alguma forma.
    print(selectedWord);
  }

  void reveltionLetter() {
    updatePlayerSolution(rowAll, colAll, puzFile.solution[rowAll][colAll]);
    String selectedLetter = puzFile.solution[rowAll][colAll];
    print("Letra selecionada: $selectedLetter");
    printGridWithWords();
  }

  void revealAllWords() {
    for (int row = 0; row < puzFile.height; row++) {
      for (int col = 0; col < puzFile.width; col++) {
        if (puzFile.solution[row][col] != '.') {
          String letter = puzFile.solution[row][col];
          revealLetter(row, col, letter);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cruzada.status != null) {
      revealAllWords();
      setState(() {
        isTyperFinish = false;
      });
    }
    return Scaffold(
      backgroundColor: _theme,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: MyColors.colorPrimary,
              ), // Exibir o círculo de progresso enquanto estiver carregando
            )
          : Padding(
              padding: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: _colorCell == Colors.white
                              ? Colors.black
                              : _colorCell,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          widget.cruzada.name!,
                          style: TextStyle(
                            color: _colorCell == Colors.white
                                ? Colors.black
                                : _colorCell,
                            fontSize: FontSizes.titulo,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (_theme == Colors.white) {
                                  _colorText = MyColors.colorCellDark;
                                  _colorCell = MyColors.colorCellDark;
                                  _theme = _themeDark!;
                                  _colorCellKeyboard = Colors.black;
                                  _colorTextKeyboard = MyColors.colorCellDark;
                                } else {
                                  _colorText = MyColors.colorPrimary;
                                  _theme = Colors.white;
                                  _colorCell = Colors.white;
                                  _colorCellKeyboard = MyColors.colorPrimary;
                                  _colorTextKeyboard = Colors.white;
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            child: Text(
                              "MODO NOTURNO",
                              style: TextStyle(
                                color: _colorCell,
                                fontSize: FontSizes.textoNormal,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => DialogDic(
                                  colorCell: _theme,
                                  colorText: _colorCell,
                                  onContainerFilter: (bool reveletionWord,
                                      bool reveletionLetter, bool reveletionGrade) {
                                    if (reveletionWord) {
                                      reveltionWord();
                                    } else if (reveletionLetter) {
                                      reveltionLetter();
                                    }else if (reveletionGrade) {
                                      revealAllWords();
                                    }
                                  },
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            child: Text(
                              "DICAS",
                              style: TextStyle(
                                color: _colorCell,
                                fontSize: FontSizes.textoNormal,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      )
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        if (puzFile.solution.isNotEmpty)
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: puzFile.width,
                            ),
                            itemBuilder: (context, index) {
                              int row = index ~/ puzFile.width;
                              int col = index % puzFile.width;
                              String cellValue =
                                  puzFile.playerSolution[row][col];
                              if (puzFile.solution[row][col] == '.') {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    color: Colors.black,
                                  ),
                                  child: Center(),
                                );
                              }
                              return GestureDetector(
                                onTap: () {
                                  int wordIndex =
                                      0; // Obtenha o índice da palavra correspondente a este item da lista
                                  selectWord(wordIndex);

                                  Map<String, String> wordHintsMap =
                                      puzFile.getWordHintsMap();

                                  setState(() {
                                    rowAll = row;
                                    colAll = col;
                                  });

                                  if (lastTapTime != null &&
                                      DateTime.now().difference(lastTapTime!) <
                                          Duration(milliseconds: 300)) {
                                    // Clique duplo detectado
                                    isDoubleClick = true;
                                  } else {
                                    // Clique único
                                    isDoubleClick = false;
                                  }
                                  lastTapTime = DateTime.now();

                                  List<WordPosition> positionWords = puzFile.findWordPositions(puzFile.solution);
                                  WordPosition? positionWord = findContainingWord(positionWords, row, col);

                                  String selectedWord = '';

                                  if (puzFile.solution[row][col] != '.' &&
                                      positionWord != null &&
                                      ((isHorizontal &&
                                              col >= positionWord.startCol &&
                                              col <= positionWord.endCol) ||
                                          (!isHorizontal &&
                                              row >= positionWord.startRow &&
                                              row <= positionWord.endRow))) {
                                    wordHint =
                                        wordHintsMap[positionWord.toString()]!;
                                    if (startRow == -1 && startCol == -1) {
                                      // Início da seleção
                                      setState(() {
                                        startRow = positionWord.startRow;
                                        startCol = positionWord.startCol;
                                        endRow = positionWord.endRow;
                                        endCol = positionWord.endCol;
                                        print("inicio da Row: $startRow, inicio da Col: $startCol, fim da Row: $endRow, fim da Col: $endCol");
                                      });
                                    } else {
                                      // Fim da seleção
                                      setState(() {
                                        if (isHorizontal) {
                                          // Seleção horizontal
                                          if (isDoubleClick) {
                                            // Duplo clique detectado, selecionar verticalmente
                                            isHorizontal = false;
                                            int wordLength = 0;
                                            while (row <
                                                    puzFile.solution.length &&
                                                puzFile.solution[row][col] !=
                                                    '.') {
                                              wordLength++;
                                              row++;
                                            }
                                            startRow = positionWord.startRow;
                                            startCol = col;
                                            endRow = startRow + wordLength - 1;
                                            endCol = col;
                                            print("Seleção vertical");
                                          } else {
                                            // Clique simples fora da seleção vertical
                                            if (row < startRow ||
                                                row > endRow ||
                                                col < startCol ||
                                                col > endCol) {
                                              // Clique fora da seleção vertical, selecionar horizontalmente
                                              startRow = positionWord.startRow;
                                              startCol = positionWord.startCol;
                                              endRow = positionWord.endRow;
                                              endCol = positionWord.endCol;
                                              print("Seleção horizontal");
                                            }
                                          }
                                        } else {
                                          // Seleção vertical
                                          if (!isDoubleClick) {
                                            // Clique simples fora da seleção vertical
                                            if (col != startCol) {
                                              // Selecionar coluna verticalmente
                                              startCol = col;
                                              endCol = col;
                                              startRow = positionWord.startRow;
                                              endRow = positionWord.startRow;
                                              while (startRow > 0 &&
                                                  puzFile.solution[startRow - 1]
                                                          [col] !=
                                                      '.') {
                                                startRow--;
                                              }
                                              while (endRow <
                                                      puzFile.solution.length -
                                                          1 &&
                                                  puzFile.solution[endRow + 1]
                                                          [col] !=
                                                      '.') {
                                                endRow++;
                                              }
                                            }
                                          } else {
                                            // Duplo clique detectado, voltar para seleção horizontal
                                            isHorizontal = true;
                                            startRow = positionWord.startRow;
                                            startCol = positionWord.startCol;
                                            endRow = positionWord.endRow;
                                            endCol = positionWord.endCol;
                                            print("Seleção horizontal");
                                          }
                                        }
                                      });
                                    }
                                  }

                                  if (isHorizontal) {
                                    // Seleção horizontal
                                    for (int colIndex = startCol;
                                        colIndex <= endCol;
                                        colIndex++) {
                                      if (puzFile.solution[row][colIndex] !=
                                          '.') {
                                        selectedWord +=
                                            puzFile.solution[row][colIndex];
                                      } else {
                                        break;
                                      }
                                    }
                                  } else {
                                    // Seleção vertical
                                    for (int rowIndex = startRow;
                                        rowIndex <= endRow;
                                        rowIndex++) {
                                      if (puzFile.solution[rowIndex][col] !=
                                          '.') {
                                        selectedWord +=
                                            puzFile.solution[rowIndex][col];
                                      } else {
                                        break;
                                      }
                                    }
                                  }

                                  print(
                                      "inicio da Row: $startRow, inicio da Col: $startCol, fim da Row: $endRow, fim da Col: $endCol");

                                  var wordCoordinates = "";
                                  setState(() {
                                    // updateSelectedWord(selectedWord);
                                    wordHint =
                                        puzFile.extractHint(selectedWord);
                                    print("Palavra: ${selectedWord}");
                                  });
                                  isGameCompleted();

                                  //puzFile.extractCrosswordWords();
                                  print(
                                      "DICA ${puzFile.extractHint(selectedWord)}");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    color: (rowAll == row && colAll == col)
                                        ? Colors.green
                                        : getCellColor(row, col),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          child: Center(
                                            child: puzFile.wordStartPositions
                                                            .indexWhere(
                                                                (position) =>
                                                                    position[
                                                                            0] ==
                                                                        row &&
                                                                    position[
                                                                            1] ==
                                                                        col) +
                                                        1 ==
                                                    0
                                                ? SizedBox()
                                                : Text(
                                                    (puzFile.wordStartPositions
                                                                .indexWhere((position) =>
                                                                    position[
                                                                            0] ==
                                                                        row &&
                                                                    position[
                                                                            1] ==
                                                                        col) +
                                                            1)
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 8,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                    ), // Small number font size and color
                                                  ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          cellValue,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: puzFile.width * puzFile.height,
                          ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 0),
                          child: Column(
                            children: [
                              Text(
                                wordHint.isNotEmpty ? 'Dica: $wordHint' : '',
                                style: TextStyle(
                                  color: _colorCell == Colors.white
                                      ? Colors.black
                                      : _colorCell,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        if (!isGameCompleted())
                          Container(
                            width: double.infinity,
                            margin:
                                EdgeInsets.only(left: 16, right: 16, bottom: 0),
                            child: Align(
                              alignment: Alignment.center,
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      9, // Número de colunas do teclado
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 2,
                                ),
                                itemBuilder: (context, index) {
                                  String letter = alphabet1[index];
                                  if (letter == "delete") {
                                    return IconButton(
                                      onPressed: () {
                                        // Lógica para apagar a letra selecionada
                                        setState(() {
                                          if (rowAll != -1 && colAll != -1) {
                                            puzFile.playerSolution[rowAll]
                                                [colAll] = '';
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.backspace_outlined),
                                      color: Colors.red,
                                    );
                                  } else if (letter == "vertical/horizontal") {
                                    return IconButton(
                                      onPressed: () {
                                        // Lógica para apagar a letra selecionada
                                        setState(() {
                                          isHorizontal = !isHorizontal;
                                        });
                                      },
                                      icon: Icon(Icons.rotate_left_outlined,),
                                      color: Colors.red,
                                    );
                                  } else {
                                    return TextButton(
                                      onPressed: () {
                                          setState(() {
                                            updatePlayerSolution(
                                                rowAll, colAll, letter);
                                          });

                                      },
                                      child: Text(
                                        letter,
                                        style: TextStyle(color: _colorCell),
                                        textAlign: TextAlign.center,
                                      ),
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.black,
                                      ),
                                    );
                                  }
                                },
                                itemCount: alphabet1.length,
                              ),
                            ),
                          ),
                        if (isGameCompleted() && isTyperFinish)
                          Padding(
                            padding: const EdgeInsets.only(top: 26),
                            child: Container(
                              child: ElevatedButton(
                                onPressed: () {
                                  concludeCruazad(
                                      widget.cruzada!.id.toString());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                                child: Text(
                                  'Concluir o jogo',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSizes.textoNormal,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
