import 'dart:ffi';

import 'package:demo/components/excel_sheet_page/excel_sheet_page.dart';
import 'package:demo/models/cellModel.dart';
import 'package:demo/models/sheetModel.dart';
import 'package:flutter/material.dart';
import './excel_sheet_page_view_model.dart';

class ExcelSheetPageView extends State<ExcelSheetPage> {
  ExcelSheetPageViewModel model;
  ExcelSheetPageView() {
    model = new ExcelSheetPageViewModel();
  }
  @override
  void initState() {
    // TODO: implement initState
    // where the cell address is created here and mapped to sheet
    initiaizeCellAddress();

    super.initState();
  }

  initiaizeCellAddress() async {
    // where address is created
    List<List<String>> arrayOfCellInfo = _makeData();
    print(arrayOfCellInfo.length);
    model.sheetData.eachRowData = [];
    arrayOfCellInfo.forEach((eachRow) {
      print(eachRow);
      EachRow singleDataRow = new EachRow();
      singleDataRow.singleRow = [];
      eachRow.forEach((eachCell) {
        CellInfo cellData = new CellInfo();
        cellData.cellAddress = eachCell.toString();
        singleDataRow.singleRow.add(cellData);
      });
      model.sheetData.eachRowData.add(singleDataRow);
    });
    print(model.sheetData);
  }

  List<List<String>> _makeData() {
    final List<List<String>> output = [];
    for (int i = 0; i < model.gridCount; i++) {
      final List<String> row = [];
      for (int j = 0; j < model.gridCount; j++) {
        row.add('$i$j');
      }
      output.add(row);
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    // Replace this with your build function
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // main UI widget starts here,
        child: pageContent(),
      ),
      floatingActionButton: InkWell(
          onTap: () {
            // for adding formula it is used
            bottomSheet();
          },
          child: Icon(Icons.add)),
    );
  }

  Widget pageContent() {
    return Container(
      child: Column(
        children: model.sheetData.eachRowData
            .asMap()
            .map(
              (key, value) => MapEntry(
                key,
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    children: model.sheetData.eachRowData[key].singleRow
                        .asMap()
                        .map(
                          (key, value) => MapEntry(
                            key,
                            Container(
                              child: cellUi(value),
                            ),
                          ),
                        )
                        .values
                        .toList(),
                  ),
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }
// individual cell widget 
  Widget cellUi(CellInfo eachCell) {
    return Container(
      height: 40,
      width: 70,
      child: TextFormField(
        decoration: InputDecoration(
          border: new OutlineInputBorder(
            borderSide: new BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        onChanged: (value) {
          if (model.formula != null) {
            // formula calculation function
            model.formulaCalculation();
          }
          eachCell.data = value;
        },
      ),
    );
  }

  bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return formulaAddition();
        });
  }

  Widget formulaAddition() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text("input formula"),
            ),
            Container(
              child: TextFormField(
                onChanged: (value) {
                  model.formula = value;
                },
              ),
            ),
          ]),
    );
  }
}
