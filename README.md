
# Desafio: Leitura de eBooks

## Como executar

### Requisitos

A solução foi desenvolvida utilizando as seguintes versões das ferramentas

- Flutter 3.16.1
- Dart 3.2.1
- DevTools 2.28.3

> Para instalar o Flutter voce pode conferir a [documentação oficial](https://docs.flutter.dev/get-started/install). Lembrando que ao instalar o Flutter, ele traz, embarcado ao pacote, o Dart SDK. Então, ao instalar o Flutter, também é instalado o Dart

### Carregue as dependências

Para instalar as dependências do projeto, execute o seguinte comando no seu terminal

```bash
flutter pub get
```

### Gerar códigos extras

Constantemente usamos gerador de código para auxiliar no desenvolvimento, principalmente para gerar alguns códigos repetitivos (boilerplate). Nesse projeto é utilizado alguns pacotes como, por exemplo, o `freezed` e `json_serializable` que fazem proveito do build_runner como gerador de código.

Para executar o `build_runner`, execute o seguinte comando no seu terminal

```bash
flutter pub run build_runner build
```

### Rodando o aplicativo

Você pode rodar a solução utilizando o seguinte comando no seu terminal

```bash
flutter run
```

## Pacotes de instalação

Para gerar os diferentes tipos de pacote do aplicativo, você pode usar os comandos do Flutter no terminal tanto para pacotes de produção (app bundle) como para gerar APKs release e debug

Para gerar APK, use o seguinte comando

```bash
flutter build apk
```

É possível também gerar APK com informações de debug usando a flag `--debug`.

```bash
flutter build apk --debug
```

> Confira a [documentação oficial](https://docs.flutter.dev/deployment/android) para acessar as diferentes opções disponíveis para gerar pacotes de aplicativo

Para gerar o pacote para lançamento na Google Play Store

```bash
flutter build appbundle
```

> É importante também conferir as informações sobre assinatura do aplicativo (também presente na [documentação](https://docs.flutter.dev/deployment/android))

---

Obrigado!
