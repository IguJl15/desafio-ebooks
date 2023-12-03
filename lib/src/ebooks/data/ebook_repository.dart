import 'dart:convert';

import 'package:http/http.dart';

import '../../shared/constants.dart';
import '../models/ebook.dart';

class EbookRepository {
  final Client client;

  EbookRepository({
    required this.client,
  });

  Future<List<Ebook>> getAllAvailableEbooks() async {
    try {
      final response = await client.get(Uri.parse("$host/books.json"));

      if (response.statusCode >= 400) {}
      final data = jsonDecode(response.body);
      return (data as List).map((json) => Ebook.fromJson(json)).toSet().toList();
    } catch (e) {
      rethrow;
    }
  }
}
