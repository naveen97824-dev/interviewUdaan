import 'package:demo/models/cellModel.dart';

class SheetModel {
  List<EachRow> eachRowData;
  SheetModel({this.eachRowData});
}

class EachRow {
  List<CellInfo> singleRow;
  EachRow({this.singleRow});
}
