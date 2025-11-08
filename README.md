# 📱 Flutter Frontend — Habits App

## 🧩 Descripción general

Este proyecto corresponde al **frontend móvil** de la aplicación de hábitos, desarrollado en **Flutter**.  
Está diseñado con una arquitectura limpia, minimalista y modular, que permite conectarse al backend basado en microservicios (NestJS).

Actualmente el frontend permite:
- Registrar y autenticar usuarios mediante **API Gateway** (NestJS).
- Enviar y recibir datos a través de peticiones HTTP.
- Mostrar formularios modernos y adaptativos con un estilo **minimalista**.

---

## 🏗️ Arquitectura del proyecto

El proyecto sigue una estructura inspirada en **Clean Architecture**, separando capas de presentación, dominio y datos.

```
lib/
 ├── core/                 # Configuración global, temas, constantes, utilidades
 │   └── theme.dart        # Define colores, tipografía y estilos globales
 │
 ├── data/                 # Acceso a datos (API REST, almacenamiento local)
 │   └── api_service.dart  # Lógica para conectar con el backend NestJS
 │
 ├── domain/               # Modelos de datos y entidades (User, Habit, etc.)
 │
 ├── presentation/         # Capa visual (UI)
 │   ├── screens/          # Pantallas principales (Login, Register, Home)
 │   └── widgets/          # Componentes reutilizables
 │
 └── main.dart             # Punto de entrada de la aplicación
```

Esta estructura facilita la escalabilidad y el mantenimiento del código.

---

## ⚙️ Tecnologías utilizadas

| Tecnología | Uso principal |
|-------------|----------------|
| **Flutter** | Framework principal para desarrollo móvil |
| **Dart** | Lenguaje base de Flutter |
| **http** | Comunicación con el backend (API Gateway) |
| **provider** | Gestión de estado simple y escalable |
| **shared_preferences** | Almacenamiento local de tokens JWT |
| **google_fonts** | Tipografías modernas y personalizadas |
| **flutter_spinkit** | Animaciones de carga |
| **Material Design 3** | Base visual moderna y consistente |

---

## 🧰 Requisitos previos

Antes de ejecutar el proyecto, asegúrate de tener instalado:

| Requisito | Versión recomendada |
|------------|--------------------|
| **Flutter SDK** | >= 3.22 |
| **Dart** | >= 3.x |
| **Android Studio** | Última versión estable |
| **Android SDK** | Configurado correctamente |
| **VS Code (opcional)** | Editor recomendado |
| **Git** | Para clonar repositorios |

Verifica tu entorno con:

```bash
flutter doctor
```

---

## 🚀 Instalación y configuración

### 1️⃣ Clonar el repositorio

```bash
git clone https://github.com/gustavitoo/habitsApp_frontend.git
cd habitsApp_frontend
```

---

### 2️⃣ Instalar dependencias

```bash
flutter pub get
```

---

### 3️⃣ Configurar conexión al backend
Edita el archivo `lib/data/api_service.dart` para apuntar a la URL correcta del API Gateway:

```dart
const String apiUrl = 'http://localhost:3000/api'; // Cambia esto por la URL de tu API Gateway
```

---

### 4️⃣ Ejecutar la aplicación

```bash
flutter run
```

Esto iniciará la aplicación en un emulador o dispositivo conectado (Android/iOS).

---

## 🎨 Diseño y estilo

El tema visual está definido en `lib/core/theme.dart`.  
Utiliza una paleta **minimalista y moderna** con base en **indigo** y tipografía **Poppins**.

Ejemplo:

```dart
ThemeData get lightTheme {
  return ThemeData(
    primarySwatch: Colors.indigo,
    textTheme: GoogleFonts.poppinsTextTheme(),
    // Otros estilos...
  );
}
```

---

## 📱 Pantallas principales

| Pantalla | Descripción |
|-----------|-------------|
| **Login** | Pantalla de inicio de sesión para usuarios existentes. |
| **[EN PROCESO] Register** | Pantalla de registro para nuevos usuarios. |
| **[EN PROCESO] Home** | Pantalla principal que muestra los hábitos del usuario. |

---

## 🐳 Levantar el backend con Docker

Para que el frontend funcione correctamente, necesitas tener el backend corriendo. Sigue estos pasos:

1. Asegúrate de tener Docker y Docker Compose instalados.
2. Clona el repositorio del backend:

```bash
git clone https://github.com/gustavitoo/habitsApp_backend.git
cd habitsApp_backend
```

3. Levanta los servicios con Docker Compose:

```bash
docker-compose up -d
```

Esto levantará el API Gateway, PostgreSQL y RabbitMQ necesarios para el funcionamiento del backend.
4. Verifica que los servicios estén corriendo correctamente:

```bash
docker-compose ps
```

---

## 🧱 Próximos pasos / Roadmap

- 🔹 Implementar `RegisterScreen`
- 🔹 Persistir sesión con `shared_preferences`
- 🔹 Crear `ProfileScreen` protegida por token JWT
- 🔹 Añadir navegación (`GoRouter` o `Navigator 2.0`)
- 🔹 Incorporar animaciones suaves (`flutter_animate`)
- 🔹 Agregar internacionalización (i18n)

---

## 🧾 Licencia
Este proyecto está bajo licencia **MIT**.  