import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class ScraperService {

  static Future<String?> scrapeArticle(String url) async {
    if (url.isEmpty) return null;

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var document = parser.parse(response.body);

        var paragraphs = document.querySelectorAll('p');

        StringBuffer fullText = StringBuffer();

        for (var p in paragraphs) {
          String text = p.text.trim();
          if (text.length > 50) {
            fullText.writeln(text);
            fullText.writeln();
          }
        }

        if (fullText.isNotEmpty) {
          return fullText.toString().trim();
        }
      }
    } catch (e) {
      print("Scraping error: $e");
    }

    return null;
  }
}