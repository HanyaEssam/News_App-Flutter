import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class ScraperService {

  // 🔥 The magic function that rips text from a website
  static Future<String?> scrapeArticle(String url) async {
    if (url.isEmpty) return null;

    try {
      // 1. Visit the website behind the scenes
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // 2. Parse the HTML code
        var document = parser.parse(response.body);

        // 3. Find every paragraph (<p>) on the page
        var paragraphs = document.querySelectorAll('p');

        StringBuffer fullText = StringBuffer();

        for (var p in paragraphs) {
          String text = p.text.trim();
          // 4. Filter out junk text. If the paragraph is longer than 50 characters, it's usually real news!
          if (text.length > 50) {
            fullText.writeln(text);
            fullText.writeln(); // Add a blank line between paragraphs
          }
        }

        // 5. Return the clean text!
        if (fullText.isNotEmpty) {
          return fullText.toString().trim();
        }
      }
    } catch (e) {
      print("Scraping error: $e");
    }

    // If it fails (some sites block scrapers), return null so we can fall back to the short description.
    return null;
  }
}