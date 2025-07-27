import 'package:baby_monitor/core/enums/row_message_type.dart';
import 'package:flutter/material.dart';

class FormMessageRow extends StatelessWidget {
  final String message;
  final RowMessageType type;
  const FormMessageRow({
    super.key,
    this.message = "",
    this.type = RowMessageType.success,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(color: _getColor, _getIcon),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              message,
              style: TextStyle(color: _getColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  IconData get _getIcon {
    switch (type) {
      case RowMessageType.success:
        return Icons.check_circle;
      case RowMessageType.warning:
        return Icons.warning;
      case RowMessageType.error:
        return Icons.dangerous;
      default:
        return Icons.info;
    }
  }

  Color get _getColor {
    switch (type) {
      case RowMessageType.success:
        return Colors.green;
      case RowMessageType.warning:
        return Colors.orange;
      case RowMessageType.error:
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }
}
