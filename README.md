# 📱🔵 Controle de Arduino via Bluetooth (Flutter + HC-05)

Projeto de aplicativo mobile desenvolvido em **Flutter** para controlar um **Arduino UNO** via **Bluetooth (HC-05)**.

Permite ligar e desligar dispositivos (LED, relé, motor, etc.) através de botões personalizados no app.

---

## 🚀 Funcionalidades

* 🔗 Conexão com módulo Bluetooth (HC-05 / HC-06)
* 🔘 Botão **LIGAR**
* 🔘 Botão **DESLIGAR**
* 📡 Envio de comandos via serial (`"1"` e `"0"`)
* 🎨 Interface simples e personalizável

---

## 🧱 Tecnologias Utilizadas

* Flutter (Dart)
* Arduino (C++)
* Bluetooth Serial (HC-05)

---

## 📦 Dependências Flutter

Adicione no `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bluetooth_serial: ^0.4.0
  permission_handler: ^11.0.0
```

---

## 🔐 Permissões Android

Arquivo: `android/app/src/main/AndroidManifest.xml`

```xml
<uses-permission android:name="android.permission.BLUETOOTH"/>
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN"/>

<!-- Android 12+ -->
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT"/>
<uses-permission android:name="android.permission.BLUETOOTH_SCAN"/>

<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
```

---

## 📱 Código Flutter (resumo)

```dart
void enviar(String comando) {
  connection!.output.add(Uint8List.fromList(comando.codeUnits));
}
```

* `"1"` → Ligar
* `"0"` → Desligar

---

## 🔌 Código Arduino

```cpp
void setup() {
  Serial.begin(9600);
  pinMode(13, OUTPUT);
}

void loop() {
  if (Serial.available()) {
    char c = Serial.read();

    if (c == '1') digitalWrite(13, HIGH);
    if (c == '0') digitalWrite(13, LOW);
  }
}
```

---

## 🔧 Ligações do HC-05

| HC-05 | Arduino        |
| ----- | -------------- |
| VCC   | 5V             |
| GND   | GND            |
| TX    | RX (pino 0)    |
| RX    | TX (pino 1) ⚠️ |

> ⚠️ Recomendado usar divisor de tensão no RX do HC-05

---

## ⚠️ Importante

* Pareie o HC-05 no celular antes de usar
* Use o **MAC Address correto**
* Ative o Bluetooth do celular
* Conceda permissões no app

---

## 🧪 Teste

1. Abra o app
2. Conecte ao HC-05
3. Pressione:

   * **LIGAR** → LED acende
   * **DESLIGAR** → LED apaga

---

## 🎨 Melhorias Futuras

* 🔍 Lista de dispositivos Bluetooth
* 🎛️ Interface avançada (botões animados)
* 🌈 Controle RGB
* 🔐 Sistema de autenticação
* 📊 Feedback em tempo real

---

## 📌 Estrutura do Projeto

```
lib/
 ├── main.dart
android/
 ├── AndroidManifest.xml
```

---

## 🏁 Conclusão

Este projeto demonstra a comunicação entre um app mobile e um sistema embarcado, sendo uma base sólida para automação residencial, robótica e IoT.

---

## 👨‍💻 Autor

Desenvolvido por Simei Freitas 🚀
