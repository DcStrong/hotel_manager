import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper {

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw "Could not launch $url";
    }
  }


  Future<void> showProgress(BuildContext context, Future func) async {
    Future getFuture(Future func) {
    return Future(() async {
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
    if(result)
      Navigator.of(context).pop();
  }
}

Helper helper = Helper();