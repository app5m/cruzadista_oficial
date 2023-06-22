import 'package:cruzadista/ui/game/word_position.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class Word {
  final String position;
  final String hint;

  Word(this.position, this.hint);
}

class PuzFile {
  int width;
  int height;
  List<List<String>> solution;
  List<List<String>> playerSolution;
  String playerState;
  List<String> strings;
  List<List<int>> wordStartPositions;
  List<Word>? wordsAcross;
  List<Word>? wordsDown;
  List<String> clues;

  PuzFile(this.width, this.height, this.solution, this.playerSolution,
      this.playerState, this.strings, this.wordStartPositions, this.clues);

  PuzFile.empty()
      : width = 0,
        height = 0,
        solution = [],
        playerSolution = [],
        playerState = '',
        strings = [],
        clues = [],
        wordStartPositions = [];
  


  void autoFillSolution() {
    for (int row = 0; row < height; row++) {
      for (int col = 0; col < width; col++) {
        if (playerSolution[row][col] == '') {
          playerSolution[row][col] = solution[row][col];
        }
      }
    }
    //setState(() {});
  }
  
  

  Map<String, String> getWordHintsMap() {
    List<String> wordHints = strings.sublist(3);
    List<WordPosition> wordPositions = findWordPositions(solution);
    Map<String, String> wordHintsMap = {};

    int minLength = wordPositions.length < wordHints.length
        ? wordPositions.length
        : wordHints.length;

    for (int i = 0; i < minLength; i++) {
      WordPosition position = wordPositions[i];
      String wordHint = wordHints[i];
      wordHintsMap[position.toString()] = wordHint;
    }

    return wordHintsMap;
  }

  List<WordPosition> findWordPositions(List<List<String>> grid) {
    List<String> words = extractWords(grid);
    List<WordPosition> wordPositions = [];

    for (String word in words) {
      int startRow = -1;
      int startCol = -1;
      int endRow = -1;
      int endCol = -1;
      bool isHorizontal = false;

      // Verifica as palavras na horizontal
      for (int row = 0; row < grid.length; row++) {
        String rowString = grid[row].join('');
        int startIndex = rowString.indexOf(word);
        if (startIndex != -1) {
          startRow = row;
          startCol = startIndex;
          endRow = row;
          endCol = startIndex + word.length - 1;
          isHorizontal = true;
          break;
        }
      }

      // Verifica as palavras na vertical
      if (startRow == -1) {
        for (int col = 0; col < grid[0].length; col++) {
          String colString = '';
          for (int row = 0; row < grid.length; row++) {
            colString += grid[row][col];
          }
          int startIndex = colString.indexOf(word);
          if (startIndex != -1) {
            startRow = startIndex;
            startCol = col;
            endRow = startIndex + word.length - 1;
            endCol = col;
            isHorizontal = false;
            break;
          }
        }
      }

      if (startRow != -1 && startCol != -1 && endRow != -1 && endCol != -1) {
        wordPositions.add(
            WordPosition(startRow, startCol, endRow, endCol, isHorizontal));
      }
    }

    return wordPositions;
  }

  String extractHint(String palavraselecionada) {

    List<String> wordHints = strings.sublist(3);
    List<String> clues = [
      "Propagado pela boca:ORAL",
      "Antigo carro da GM, foi produzido de 1968 até 1992:OPALA",
      "Boato:RUMOR",
      "A prova de que o réu não estava no local do crime:ALIBI",
      "A segunda parte de um disco de vinil:LADOB",
      "Omitir algo de propósito:PULAR",
      "Flor dada de presente em ocasiões especiais:ROSA",
      "Pó obtido dos grãos de cereais:AMIDO",
      "Animais sobreviventes da Era do Gelo:LOBOS",
      "Árvore cuja madeira é usada em móveis de luxo e tacos para assoalhos:ARIBA",
    ];

    for (String clue in wordHints) {
      List<String> parts = clue.split("#");
      String hint = parts[0];
      String word = parts[1];

      if (word == palavraselecionada) {
        return hint;
      }
    }

    return "";
  }


  void extractCrosswordWords() {
    List<WordPosition> wordPositions = findWordPositions(solution);
    Map<String, String> wordHintsMap = getWordHintsMap();

    wordsAcross = [];
    wordsDown = [];

    for (WordPosition position in wordPositions) {
      String wordHint = wordHintsMap[position.toString()]!;
      if (wordHint != null) {
        Word word = Word(position.toString(), wordHint);
        if (position.isHorizontal) {
          wordsAcross!.add(word);
        } else {
          wordsDown!.add(word);
        }
      }
    }
    // Imprimir a lista de palavras
    print('Words Across:');
    for (Word word in wordsAcross!) {
      print('${word.hint}');
    }

    print('Words Down:');
    for (Word word in wordsDown!) {
      print('${word.hint}');
    }
  }

  List<String> extractWords(List<List<String>> grid) {
    List<String> words = [];

    // Verifica as palavras na horizontal
    for (int row = 0; row < grid.length; row++) {
      String word = '';
      for (int col = 0; col < grid[row].length; col++) {
        if (grid[row][col] != '.') {
          word += grid[row][col];
        } else if (word.isNotEmpty) {
          words.add(word);
          word = '';
        }
      }
      if (word.isNotEmpty) {
        words.add(word);
      }
    }

    // Verifica as palavras na vertical
    for (int col = 0; col < grid[0].length; col++) {
      String word = '';
      for (int row = 0; row < grid.length; row++) {
        if (grid[row][col] != '.') {
          word += grid[row][col];
        } else if (word.isNotEmpty) {
          words.add(word);
          word = '';
        }
      }
      if (word.isNotEmpty) {
        words.add(word);
      }
    }

    return words;
  }

  Future<void> parse(String fileUrl) async {
    final response = await http.get(Uri.parse(fileUrl));
    final bytes = Uint8List.fromList(response.bodyBytes);

    // Parse header
    width = bytes[0x2C];
    height = bytes[0x2D];
    int solutionLength = width * height;
    int playerStateOffset = 0x34 + solutionLength;

    // Parse solution
    List<String> solutionGrid = [];
    for (int i = 0x34; i < 0x34 + solutionLength; i++) {
      String cell = String.fromCharCode(bytes[i]);
      solutionGrid.add(cell);
    }
    solution = _createGrid(solutionGrid, width);
    playerSolution =
        _createGrid(List<String>.filled(solutionLength, ''), width);

    // Parse player state
    playerState = String.fromCharCodes(
        bytes.sublist(playerStateOffset, playerStateOffset + solutionLength));

    // Parse strings
    int stringsOffset = playerStateOffset + solutionLength;
    strings = [];
    int stringOffset = stringsOffset;
    while (stringOffset < bytes.length) {
      String string = '';
      while (bytes[stringOffset] != 0) {
        string += String.fromCharCode(bytes[stringOffset]);
        stringOffset++;
      }
      strings.add(string);
      stringOffset++; // Skip null terminator
    }

    //tentando ler o clues


    int cluesOffset = stringsOffset;
    for (String string in strings) {
      cluesOffset += string.length + 1;
    }

    List<String> clues = [];
    int currentOffset = cluesOffset;

    while (currentOffset < bytes.length) {
      String clue = '';
      while (currentOffset < bytes.length && bytes[currentOffset] != 0) {
        clue += String.fromCharCode(bytes[currentOffset]);
        currentOffset++;
        print('currentOffset: $currentOffset');
        print('current byte: ${bytes[currentOffset]}');
      }
      clues.add(clue);
      print('currentOffset after add: $currentOffset');
      currentOffset++; // Skip null terminator
    }

    print('bytes:');
    print(bytes.length);
    print('currentOffsetFinal:');
    print(currentOffset);
    print('Clues:');
    for (String clue in clues) {
      print(clue);
    }

    // Identify word start positions
    wordStartPositions = _getWordStartPositions(solution);
  }

  List<List<int>> _getWordStartPositions(List<List<String>> solution) {
    List<List<int>> wordPositions = [];

    for (int row = 0; row < height; row++) {
      for (int col = 0; col < width; col++) {
        if (isWordStart(solution, row, col)) {
          wordPositions.add([row, col]);
        }
      }
    }

    return wordPositions;
  }

  bool isWordStart(List<List<String>> grid, int row, int col) {
    if (grid[row][col] == '.') {
      return false;
    }

    if (row == 0 || col == 0) {
      return true;
    }

    if (grid[row - 1][col] == '.' || grid[row][col - 1] == '.') {
      return true;
    }

    return false;
  }

  List<List<String>> _createGrid(List<String> flatList, int width) {
    List<List<String>> grid = [];
    for (int i = 0; i < flatList.length; i += width) {
      grid.add(flatList.sublist(i, i + width));
    }
    return grid;
  }

  bool isSolutionCorrect() {
    for (int row = 0; row < height; row++) {
      for (int col = 0; col < width; col++) {
        if (playerSolution[row][col] != solution[row][col]) {
          return false;
        }
      }
    }
    return true;
  }

  List<String> listAllWords(List<List<String>> grid) {
    List<String> words = [];

    // Verifica as palavras na horizontal
    for (int row = 0; row < grid.length; row++) {
      String word = '';
      for (int col = 0; col < grid[row].length; col++) {
        if (grid[row][col] != '.') {
          word += grid[row][col];
        } else if (word.isNotEmpty) {
          words.add(word);
          word = '';
        }
      }
      if (word.isNotEmpty) {
        words.add(word);
      }
    }

    // Verifica as palavras na vertical
    for (int col = 0; col < grid[0].length; col++) {
      String word = '';
      for (int row = 0; row < grid.length; row++) {
        if (grid[row][col] != '.') {
          word += grid[row][col];
        } else if (word.isNotEmpty) {
          words.add(word);
          word = '';
        }
      }
      if (word.isNotEmpty) {
        words.add(word);
      }
    }

    return words;
  }
}
