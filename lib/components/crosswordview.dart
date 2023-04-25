import 'package:cruzadista/components/fonte_size.dart';
import 'package:flutter/material.dart';

const double _MARGIN_HORIZONTAL = 30.0;
const double _MARGIN_VERTICAL = 4.0;
const Color _CELL_BACKGROUND = const Color(0xFFFFFFFF);
const Color _BLANK_CELL_BACKGROUND = const Color(0xFF000000);
const double _CELL_SPACING = 2.0;

class CrosswordView extends StatelessWidget {
  List<int>? gridElements;
  Color? color;
  Color? colorCell;
  CrosswordView({Key? key, this.gridElements,this.color,this.colorCell,}) : super(key: key);

  // A simplified way to represent the list of cells in the grid. In practice,
  // you would want more complex data than an integer to represent each cell
  // in a crossword, but this is beyond the scope of this tutorial.


  @override
  Widget build(BuildContext context) {
    Widget grid = new GridView.count(
        crossAxisCount: 8,
        shrinkWrap: true,
        childAspectRatio: 1.0, // This means each cell is a square
        padding: const EdgeInsets.only(left: _MARGIN_HORIZONTAL,
            right: _MARGIN_HORIZONTAL,
            top: _MARGIN_VERTICAL,
            bottom: _MARGIN_VERTICAL),
        mainAxisSpacing: _CELL_SPACING,
        crossAxisSpacing: _CELL_SPACING,
        children: gridElements!.map((int cell) {
          return new Container(
            color: cell == 0?_BLANK_CELL_BACKGROUND: colorCell,
          );
        }).toList())
    ;

    return Container(
      color: Colors.black,
      child: grid,
    );
  }

}




class CluesView extends StatelessWidget {
  CluesView({Key? key, this.acrossClues, this.downClues}) : super(key: key);

  List<String>? acrossClues;

  List<String>? downClues;

  @override
  Widget build(BuildContext context) {
    Widget cluesRowTitle = new Row(
      children: <Widget>[
        new Expanded(
          child: new Text('Across',
            style: new TextStyle(fontWeight: FontWeight.bold),),
        )
        ,
        new Expanded(
          child: new Text('Down',
            style: new TextStyle(fontWeight: FontWeight.bold),),
        )
        ,
      ],
    );

    Widget acrossCluesWidget = new ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: acrossClues!.map((String clue) {
          return new Text(clue);
        }).toList());

    Widget downCluesWidget = new ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: downClues!.map((String clue) {
          return new Text(clue);
        }).toList());


    Widget cluesRow = new Row(children: <Widget>[
      new Expanded(
        child: acrossCluesWidget,
      )
      ,
      new Expanded(
        child: downCluesWidget,
      )
      ,
    ],
    );

    return new Container(
      padding: const EdgeInsets.all(8.0),
      child: new Column(
        children: <Widget>[
          new Container(
            height: 28.0,
            child: cluesRowTitle,
          ),
          new Expanded(
            child: cluesRow,
          ),
        ],
      ),
    );
  }

}

const double _ROW_HEIGHT = 40.0;
const double _KEY_WIDTH = 40.0;
const Color _KEY_BACKGROUND = const Color(0xFFA6A6A6);

class KeyboardView extends StatelessWidget {
  Color? colorCell;
  KeyboardView({Key? key, this.colorCell}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: new Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: _KEY_WIDTH,
                height: _ROW_HEIGHT,
                color: _KEY_BACKGROUND,
                child: Center(child: new Text('Q', style: TextStyle(fontSize: FontSizes.textoGrande),)),
              ),
              Container(
                width: _KEY_WIDTH,
                height: _ROW_HEIGHT,
                color: _KEY_BACKGROUND,
                child:  Center(child: new Text('W', style: TextStyle(fontSize: FontSizes.textoGrande),)),
              ),
              Container(
                width: _KEY_WIDTH,
                height: _ROW_HEIGHT,
                color: _KEY_BACKGROUND,
                child:  Center(child: new Text('E', style: TextStyle(fontSize: FontSizes.textoGrande),)),
              ),
              Container(
                width: _KEY_WIDTH,
                height: _ROW_HEIGHT,
                color: _KEY_BACKGROUND,
                child:  Center(child: new Text('R', style: TextStyle(fontSize: FontSizes.textoGrande),)),
              ),
              Container(
                width: _KEY_WIDTH,
                height: _ROW_HEIGHT,
                color: _KEY_BACKGROUND,
                child:  Center(child: new Text('T', style: TextStyle(fontSize: FontSizes.textoGrande),)),
              ),
              Container(
                width: _KEY_WIDTH,
                height: _ROW_HEIGHT,
                color: _KEY_BACKGROUND,
                child:  Center(child: new Text('Y', style: TextStyle(fontSize: FontSizes.textoGrande),)),
              ),
              Container(
                width: _KEY_WIDTH,
                height: _ROW_HEIGHT,
                color: _KEY_BACKGROUND,
                child:  Center(child: new Text('U', style: TextStyle(fontSize: FontSizes.textoGrande),)),
              ),
              Container(
                width: _KEY_WIDTH,
                height: _ROW_HEIGHT,
                color: _KEY_BACKGROUND,
                child:  Center(child: new Text('I', style: TextStyle(fontSize: FontSizes.textoGrande),)),
              ),
              Container(
                width: _KEY_WIDTH,
                height: _ROW_HEIGHT,
                color: _KEY_BACKGROUND,
                child:  Center(child: new Text('O', style: TextStyle(fontSize: FontSizes.textoGrande),)),
              ),
            ],
          ),
          Container(
            height: 1.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: _KEY_WIDTH,
                height: _ROW_HEIGHT,
                color: _KEY_BACKGROUND,
                child: Center(child: new Text('A', style: TextStyle(fontSize: FontSizes.textoGrande),)),
              ),
              Container(
                width: _KEY_WIDTH,
                height: _ROW_HEIGHT,
                color: _KEY_BACKGROUND,
                child:  Center(child: new Text('S', style: TextStyle(fontSize: FontSizes.textoGrande),)),
              ),
              Container(
                width: _KEY_WIDTH,
                height: _ROW_HEIGHT,
                color: _KEY_BACKGROUND,
                child:  Center(child: new Text('D', style: TextStyle(fontSize: FontSizes.textoGrande),)),
              ),
              Container(
                width: _KEY_WIDTH,
                height: _ROW_HEIGHT,
                color: _KEY_BACKGROUND,
                child:  Center(child: new Text('F', style: TextStyle(fontSize: FontSizes.textoGrande),)),
              ),
              Container(
                width: _KEY_WIDTH,
                height: _ROW_HEIGHT,
                color: _KEY_BACKGROUND,
                child:  Center(child: new Text('G', style: TextStyle(fontSize: FontSizes.textoGrande),)),
              ),
              Container(
                width: _KEY_WIDTH,
                height: _ROW_HEIGHT,
                color: _KEY_BACKGROUND,
                child:  Center(child: new Text('H', style: TextStyle(fontSize: FontSizes.textoGrande),)),
              ),
              Container(
                width: _KEY_WIDTH,
                height: _ROW_HEIGHT,
                color: _KEY_BACKGROUND,
                child:  Center(child: new Text('J', style: TextStyle(fontSize: FontSizes.textoGrande),)),
              ),
              Container(
                width: _KEY_WIDTH,
                height: _ROW_HEIGHT,
                color: _KEY_BACKGROUND,
                child:  Center(child: new Text('K', style: TextStyle(fontSize: FontSizes.textoGrande),)),
              ),
              Container(
                width: _KEY_WIDTH,
                height: _ROW_HEIGHT,
                color: _KEY_BACKGROUND,
                child:  Center(child: new Text('L', style: TextStyle(fontSize: FontSizes.textoGrande),)),
              ),
            ],
          ),

        ],
      ),
    );
  }
}





