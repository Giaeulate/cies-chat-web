// import 'package:flutter/material.dart';
// import 'package:flutter_vetweb/apps/web/widgets/custom_button_widget.dart';
// import 'package:flutter_vetweb/global/date_times.dart';
// import 'package:flutter_vetweb/theme/theme_app.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// import 'custom_text.dart';

// List<GridColumn> gridColumnsByModel(List<dynamic> data,
//     {List<String> excludes = const []}) {
//   List<GridColumn> resp = [];
//   for (var item in data) {
//     if (!excludes.contains(item["key"])) {
//       resp.add(
//         GridColumn(
//           columnName: item["key"],
//           label: Container(
//             padding: const EdgeInsets.all(5.0),
//             child: CustomText(item["label"]),
//           ),
//         ),
//       );
//     }
//   }
//   return resp;
// }

// DataGridCell rowGrid(String key, String val,
//     {String type = 'string',
//     Function()? onPress,
//     Function()? onPressCreate,
//     Function()? onPressEdit}) {
//   switch (type.toLowerCase()) {
//     case 'string':
//       return DataGridCell<String>(columnName: key, value: toString(val));
//     case 'int':
//       return DataGridCell<int>(columnName: key, value: int.parse(val));
//     case 'create/edit':
//       return DataGridCell<Widget>(
//         columnName: key,
//         value: Row(
//           children: [
//             IconButton(
//               icon: Icon(Icons.add_box_outlined, color: ThemeApp.primary),
//               onPressed: onPressCreate,
//             ),
//             IconButton(
//               icon: Icon(Icons.mode_edit_outline_outlined,
//                   color: ThemeApp.primary),
//               onPressed: onPressEdit,
//             ),
//           ],
//         ),
//       );
//     case 'button':
//       return DataGridCell<Widget>(
//         columnName: key,
//         value: CustomButtonWidget(
//           w: 10,
//           onPress: onPress,
//           text: '',
//           suffix: const Icon(Icons.insert_drive_file_outlined),
//           // text: val,
//         ),
//       );
//     case 'iconbutton':
//       return DataGridCell<Widget>(
//         columnName: key,
//         value: IconButton(
//           icon: Icon(Icons.insert_drive_file_outlined, color: ThemeApp.primary),
//           onPressed: onPress,
//         ),
//       );
//     default:
//       return DataGridCell<String>(columnName: key, value: val);
//   }
// }
