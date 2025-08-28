import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/models/action.dart';
import 'package:kabir_admin_panel/core/constants/colors.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/action_cell.dart';
import 'package:kabir_admin_panel/ui/widgets/common/data_grid/status_cell.dart';
import 'package:kabir_admin_panel/ui/widgets/navigation/route_breadcrumb.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DataGrid extends StatelessWidget {
  final List<String> columnNames;
  final List<List<dynamic>> records;

  const DataGrid({
    super.key,
    required this.columnNames,
    required this.records,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipper: CustomLeftClipper(),
      child: SfDataGrid(
        source: RecordDataSource(records: records, columnNames: columnNames),
        columns: _buildGridColumns(),
        highlightRowOnHover: false,
        verticalScrollPhysics: BouncingScrollPhysics(),
        rowHeight: 60,
        gridLinesVisibility: GridLinesVisibility.none,
        headerGridLinesVisibility: GridLinesVisibility.none,
      ),
    );
  }

  List<GridColumn> _buildGridColumns() {
    return columnNames.map((name) {
      return GridColumn(
        columnName: name,
        columnWidthMode: ColumnWidthMode.fill,
        label: _buildColumnHeader(name),
      );
    }).toList();
  }

  Widget _buildColumnHeader(String name) {
    return Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.centerLeft,
      child: name.toUpperCase().customText(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
    );
  }
}

class RecordDataSource extends DataGridSource {
  final List<DataGridRow> _rows;

  RecordDataSource(
      {required List<List<dynamic>> records, required List<String> columnNames})
      : _rows = records.map((record) {
          return DataGridRow(
            cells: List.generate(
              record.length,
              (index) => DataGridCell<dynamic>(
                  columnName: columnNames[index], value: record[index]),
            ),
          );
        }).toList();

  @override
  List<DataGridRow> get rows => _rows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      color: _rows.indexOf(row) % 2 == 0 ? Color(0xFFF9FAFB) : Colors.white,
      cells: row
          .getCells()
          .map<Widget>((cell) => _buildCell(cell, _rows.indexOf(row)))
          .toList(),
    );
  }

  Widget _buildCell(DataGridCell<dynamic> cell, int rowIndex) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE6E7EB), width: 2)),
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
      child: _getCellContent(cell, rowIndex),
    );
  }

  Widget _getCellContent(DataGridCell<dynamic> cell, int rowIndex) {
    switch (cell.columnName) {
      case 'action':
        return _buildActionCell(cell.value, rowIndex);
      case 'status':
      case 'payment status':
        return StatusCell(text: cell.value.toString());
      default:
        return cell.value.toString().customText(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF6E7292),
            );
    }
  }

  Widget _buildActionCell(List<ActionModel> actions, int rowIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: actions
          .map((action) => _buildActionButton(action, rowIndex))
          .toList(),
    );
  }

  Widget _buildActionButton(ActionModel action, int rowIndex) {
    return ActionCell(
      color: _getActionColor(action.text),
      icon: _getActionIcon(action.text),
      text: action.text.capitalize(),
      onTap: action.onTap,
    );
  }

  Color _getActionColor(String action) {
    switch (action) {
      case 'view':
        return primaryColor;
      case 'edit':
        return Color(0xFF20C55E);
      default:
        return Colors.red;
    }
  }

  IconData _getActionIcon(String action) {
    switch (action) {
      case 'view':
        return Icons.remove_red_eye_outlined;
      case 'edit':
        return Icons.edit_document;
      default:
        return Icons.delete_outline;
    }
  }
}

class CustomLeftClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(2, 2, size.width - 4, size.height - 4);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}
