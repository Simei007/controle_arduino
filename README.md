# 🏠📱 Controle de Casa Inteligente (Flutter + Arduino + HC-05)

Aplicativo mobile desenvolvido em **Flutter** para controle de uma **mini casa inteligente com Arduino**, utilizando **Bluetooth clássico (HC-05)**.

O projeto utiliza **integração nativa Android (Kotlin)** via `MethodChannel`, garantindo compatibilidade com versões modernas do Flutter.

---

## 🚀 Funcionalidades

* 🔍 Listagem de dispositivos Bluetooth pareados
* 🔗 Conexão dinâmica (sem MAC fixo)
* 💡 Controle de iluminação (relé)
* 🚪 Controle de porta (servo motor)
* 🔔 Sistema de alarme (buzzer)
* 🌈 Controle de iluminação RGB
* 🎛️ Interface estilo painel
* 💬 Status de conexão em tempo real

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
Kotlin (Bluetooth clássico)
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

## 📱 Comandos do App

| Função       | Comando |
| ------------ | ------- |
| Luz ON       | A       |
| Luz OFF      | B       |
| Abrir porta  | C       |
| Fechar porta | D       |
| Alarme ON    | E       |
| Alarme OFF   | F       |
| RGB Vermelho | G       |
| RGB Verde    | H       |
| RGB Azul     | I       |
| RGB OFF      | Z       |

---

## 🤖 Código Arduino

```cpp
#include <Servo.h>

Servo servo;

#define RELE 7
#define BUZZER 8

int r = 10;
int g = 11;
int b = 12;

void setup() {
  Serial.begin(9600);

  pinMode(RELE, OUTPUT);
  pinMode(BUZZER, OUTPUT);

  pinMode(r, OUTPUT);
  pinMode(g, OUTPUT);
  pinMode(b, OUTPUT);

  servo.attach(9);
}

void loop() {
  if (Serial.available()) {
    char c = Serial.read();

    switch (c) {
      case 'A': digitalWrite(RELE, HIGH); break;
      case 'B': digitalWrite(RELE, LOW); break;

      case 'C': servo.write(90); break;
      case 'D': servo.write(0); break;

      case 'E': digitalWrite(BUZZER, HIGH); break;
      case 'F': digitalWrite(BUZZER, LOW); break;

      case 'G': digitalWrite(r, HIGH); break;
      case 'H': digitalWrite(g, HIGH); break;
      case 'I': digitalWrite(b, HIGH); break;

      case 'Z':
        digitalWrite(r, LOW);
        digitalWrite(g, LOW);
        digitalWrite(b, LOW);
        break;
    }
  }
}
```

---

## 🔌 Ligações

| Componente | Pino Arduino |
| ---------- | ------------ |
| Relé       | 7            |
| Buzzer     | 8            |
| Servo      | 9            |
| RGB R      | 10           |
| RGB G      | 11           |
| RGB B      | 12           |

---

## ⚠️ Importante

* Pareie o HC-05 no celular antes de usar
* Utilize baud rate **9600**
* Use divisor de tensão no RX do HC-05
* Cuidado ao usar relé com alta tensão (127V / 220V)

---

## 📦 Build do App

```bash
flutter build apk --release
```

APK gerado em:

```
build/app/outputs/flutter-apk/app-release.apk
```

---

## 🏷️ Versionamento

```
version: 1.1.0+2
```

* 1.1.0 → nova funcionalidade (casa inteligente)
* +2 → número do build

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

Este projeto demonstra integração completa entre:

* Aplicativo mobile
* Comunicação Bluetooth
* Sistema embarcado

Servindo como base para projetos de automação residencial, robótica e IoT.

---

## 👨‍💻 Autor

Desenvolvido por Simei Freitas 🚀
