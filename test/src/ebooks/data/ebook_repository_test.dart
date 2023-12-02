import 'dart:io';

import 'package:desafio_ebook/src/ebooks/data/ebook_repository.dart';
import 'package:desafio_ebook/src/ebooks/models/ebook.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class HttpClientMock extends Mock implements Client {}

void main() {
  final fixture = File("./test/src/ebooks/data/ebooks_fixture.json").readAsBytesSync();
  const happyResult = [
    Ebook(
      id: 1,
      title: "Title 1",
      author: "Autor 1",
      coverImageUrl: "https://www.example.com/cover.medium.1.jpg",
      downloadUrl: "https://www.example.com/ebooks/1.epub3",
    ),
    Ebook(
      id: 2,
      title: "Title 2",
      author: "Autor 2",
      coverImageUrl: "https://www.example.com/cover.medium.2.jpg",
      downloadUrl: "https://www.example.com/ebooks/2.epub3",
    ),
    Ebook(
      id: 3,
      title: "Title 3",
      author: "Autor 3",
      coverImageUrl: "https://www.example.com/cover.medium.3.jpg",
      downloadUrl: "https://www.example.com/ebooks/3.epub3",
    ),
    Ebook(
      id: 4,
      title: "Title 4",
      author: "Autor 4",
      coverImageUrl: "https://www.example.com/cover.medium.4.jpg",
      downloadUrl: "https://www.example.com/ebooks/4.epub3",
    ),
  ];
  final client = HttpClientMock();

  setUp(() {
    registerFallbackValue(Uri.parse("https://example.com/"));
    when(() => client.get(any())).thenAnswer((invocation) async => Response.bytes(fixture, 200));
  });

  test("should return the ebooks list", () async {
    final repo = EbookRepository(client: client);

    final result = await repo.getAllAvailableEbooks();

    expect(result, happyResult);
  });
}
