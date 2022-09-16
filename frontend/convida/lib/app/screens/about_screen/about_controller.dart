import 'package:convida/app/shared/util/dialogs_widget.dart';
import 'package:url_launcher/url_launcher.dart';

openLink(String link, context) async {
  String url;

  if (link.contains("https://") || link.contains("http://")) {
    url = link;
  } else {
    url = "https://$link";
  }

  if (await launch(url)) {
    print('Abrindo link');
  } else {
    showError("Impossível abrir o link",
        "Não foi possível abrir esse link: $link", context);
  }
}
