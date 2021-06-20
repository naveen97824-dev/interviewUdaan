import 'package:demo/models/sheetModel.dart';

class ExcelSheetPageViewModel {
  // Add your state and logic here
  int gridCount = 10;
  String formula;
  SheetModel sheetData = new SheetModel();
  RegExp _numeric = RegExp(r'^[a-zA-Z]+$');

  formulaCalculation() {
    List<String> formulaSplited = [];
    List<String> cells = [];
    double operationValue = 0;
    formulaSplited = formula.split(":");
    cells = formulaSplited[1].split(",");
    print("$formulaSplited $cells");
    if (formulaSplited[0].toLowerCase() == "sum") {
      if (cells.isNotEmpty) {
        cells.forEach((eachCell) {
          if (findTheValueAndReturn(eachCell) != null) {
            operationValue = operationValue +
                ((isNumeric(findTheValueAndReturn(eachCell)) != null &&
                            isNumeric(findTheValueAndReturn(eachCell))) !=
                        null
                    ? int.parse(findTheValueAndReturn(eachCell))
                    : 0);
          } else {
            operationValue += 0;
          }
          print(operationValue.toString());
        });
      }
    }
  }

  bool isNumeric(String str) {
    if (str == null || _numeric.hasMatch(str)) {
      return false;
    } else {
      return true;
    }
    // return _numeric.hasMatch(str);
  }

  String findTheValueAndReturn(String eachCell) {
    if ((sheetData.eachRowData[int.parse(eachCell.trim()[0])]
                .singleRow[int.parse(eachCell.trim()[1])])
            .data !=
        null) {
      return sheetData.eachRowData[int.parse(eachCell.trim()[0])]
          .singleRow[int.parse(eachCell.trim()[1])].data;
    } else {
      return null;
    }
  }
}
