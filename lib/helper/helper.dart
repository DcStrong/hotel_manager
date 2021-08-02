import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper {

  Future<String> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      helpText: 'Выберите дату',
      locale: Locale('ru', 'RU'),
      context: context,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101));
    if (picked != null)
      selectedDate = picked;
      return DateFormat.yMd().format(selectedDate);
  }

  Future<String> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      confirmText: 'Установить',
      cancelText: 'Закрыть',
      helpText: 'Выберите время',
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      String minute = picked.minute.toString().padLeft(2, '0');
      String hour = picked.hour.toString().padLeft(2, '0');
      return '$hour:$minute';
    }
    return '';
  }


  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  void showMessageSnackBar(BuildContext context, title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width - 50,
                child: Text(title, textAlign: TextAlign.center,)
              ),
            ],
          ),
        ),
        duration: const Duration(milliseconds: 3000),
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }


  Future showProgress(BuildContext context, Future func) async {
    Future getFuture(Future func) {
      return Future<bool>(() async {
        var result = await func;
        return result;
      });
    }

    var result = await showDialog(
      context: context,
      builder: (context) =>
          FutureProgressDialog(getFuture(func), message: Text('Loading...')),
    );
    // if(result)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                result 
                ? 'Заявка успешно отправлена' 
                : 'Проверьте данные и повторите попытку'
              ),
              Icon(result ? Icons.done : Icons.close, color: result ? Colors.green : Colors.red,)
            ],
          ),
        ),
        duration: const Duration(milliseconds: 3000),
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
    if(result) {
      Navigator.of(context).pop();
      return result;
    }

  }

}

Helper helper = Helper();