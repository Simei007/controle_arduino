# 📱🔵 Controle de Arduino via Bluetooth (Flutter + HC-05)

Aplicativo mobile desenvolvido em **Flutter** para controlar um **Arduino UNO** via **Bluetooth clássico (HC-05)**.

O projeto utiliza **integração nativa Android (Kotlin)** com `MethodChannel`, sem dependência de plugins Bluetooth desatualizados.

---

## 🚀 Funcionalidades

* 🔍 Lista de dispositivos Bluetooth pareados
* 🔗 Conexão dinâmica (sem MAC fixo)
* 🔘 Botões **LIGAR / DESLIGAR**
* 📡 Envio de comandos (`"1"` e `"0"`)
* 🎛️ Interface moderna estilo painel
* 💬 Feedback visual (status de conexão)

---

## 🧱 Tecnologias Utilizadas

* Flutter (Dart)
* Kotlin (Android nativo)
* Arduino (C++)
* Bluetooth clássico (HC-05)

---

## ⚙️ Arquitetura

```
Flutter (UI)
   ↓
MethodChannel
   ↓
Kotlin (Bluetooth)
   ↓
HC-05
   ↓
Arduino
```

---

## 📦 Dependências Flutter

```yaml
dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.8
```

> ❗ O Bluetooth é implementado via código nativo (Kotlin)

---

## 🔐 Permissões Android

Arquivo: `android/app/src/main/AndroidManifest.xml`

```xml
<uses-permission android:name="android.permission.BLUETOOTH"/>
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN"/>

<!-- Android 12+ -->
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT"/>
<uses-permission android:name="android.permission.BLUETOOTH_SCAN"/>
```

---

## 📱 Código Flutter (resumo)

```dart
static const platform = MethodChannel('bluetooth');

await platform.invokeMethod('connect', {"mac": mac});
await platform.invokeMethod('send', {"data": "1"});
```

---

## 🤖 Código Arduino

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

## 🔌 Ligações do HC-05

| HC-05 | Arduino        |
| ----- | -------------- |
| VCC   | 5V             |
| GND   | GND            |
| TX    | RX (pino 0)    |
| RX    | TX (pino 1) ⚠️ |

> ⚠️ Recomendado usar divisor de tensão no RX do HC-05

---

## ⚠️ Importante

* O HC-05 deve estar **pareado no celular**
* Bluetooth deve estar ativado
* Use o MAC selecionando na lista do app
* Baud rate: **9600**

---

## 🧪 Teste

1. Abra o app
2. Selecione o dispositivo (HC-05)
3. Conecte
4. Pressione:

   * **LIGAR** → LED acende
   * **DESLIGAR** → LED apaga

---

## 📌 Estrutura do Projeto

```
lib/
 ├── main.dart

android/
 ├── MainActivity.kt
 ├── AndroidManifest.xml
```

---

## 🏁 Conclusão

Este projeto demonstra integração entre Flutter e código nativo Android para comunicação com dispositivos Bluetooth clássicos, sendo uma base sólida para projetos de automação e IoT.

---

## 👨‍💻 Autor

Desenvolvido por Simei Freitas 🚀
