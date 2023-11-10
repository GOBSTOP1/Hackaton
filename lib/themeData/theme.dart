import 'package:flutter/material.dart';

// Создание светлой темы
final lightTheme = ThemeData(
  
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
  }),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white, // Фон нижней панели навигации
    // Вы также можете настроить другие свойства нижней панели навигации здесь
  ),
  scaffoldBackgroundColor: Colors.white, // Фон всего экрана (Scaffold)
  // Основной цвет приложения
  dividerColor: Colors.white, // Цвет разделителей
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black), // Цвет значков в AppBar
    elevation: 0, // Высота тени верхней панели
    // Фон верхней панели
    titleTextStyle: TextStyle(
      color: Colors.black, // Цвет текста заголовка
      fontSize: 20, // Размер шрифта заголовка
      fontWeight: FontWeight.w700, // Жирность шрифта заголовка
    ),
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness
        .light, // Яркость темы (Brightness.light для светлой, Brightness.dark для темной)
    primary: Colors.white, // Основной цвет приложения
    onPrimary: Colors.black, // Цвет текста и значков на основном цвете
    secondary: Color.fromARGB(255, 158, 146, 146), // Вторичный цвет
    onSecondary: Colors.black, // Цвет текста и значков на вторичном цвете
    error: Color(0xFFB00020), // Цвет ошибок
    onError: Colors.black, // Цвет текста и значков на фоне ошибок
    background: Colors.white, // Фон
    onBackground: Colors.black, // Цвет текста и значков на фоне
    surface: Color(0xFFD3D3D3), // Цвет поверхности
    onSurface: Colors.black, // Цвет текста и значков на поверхности
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: Colors.black, // Цвет значков в элементах списка
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states ){
          return states.contains(MaterialState.disabled)
          ? Colors.grey
          : Colors.black;
        }
      ),
    )
  ) ,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.black, // Цвет среднего текста
      fontSize: 20, // Размер шрифта среднего текста
      fontWeight: FontWeight.w500, // Жирность шрифта среднего текста
    ),
    labelSmall: TextStyle(
      color: Colors.black, // Цвет меток
      fontSize: 14, // Размер шрифта меток
      fontWeight: FontWeight.w700, // Жирность шрифта меток
    ),
    headlineMedium: TextStyle(
      color: Colors.black, // Цвет заголовков среднего размера
      fontSize: 14, // Размер шрифта заголовков среднего размера
      fontWeight:
          FontWeight.w700, // Жирность шрифта заголовков среднего размера
    ),
    titleLarge: TextStyle(
      color: Colors.black, // Цвет заголовков среднего размера
      fontSize: 14, // Размер шрифта заголовков среднего размера
      fontWeight:
          FontWeight.w700, // Жирность шрифта заголовков среднего размера
    ),
    
  ),
);

// Создание темной темы
final darkTheme = ThemeData(
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
  }), 
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor:
        Color.fromARGB(0, 61, 58, 58), // Фон нижней панели навигации
    // Вы также можете настроить другие свойства нижней панели навигации здесь
  ),
  scaffoldBackgroundColor:
      Color.fromARGB(255, 26, 26, 26), // Фон всего экрана (Scaffold)
      textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states ){
          return states.contains(MaterialState.disabled)
          ? Colors.grey
          : Colors.white;
        }
      ),
    )
  ) ,

  dividerColor: Colors.grey, // Цвет разделителей
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white, // Цвет значков в AppBar
    ),
    elevation: 0, // Высота тени верхней панели

    titleTextStyle: TextStyle(
      color: Colors.white, // Цвет текста заголовка
      fontSize: 20, // Размер шрифта заголовка
      fontWeight: FontWeight.w700, // Жирность шрифта заголовка
    ),
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness
        .dark, // Яркость темы (Brightness.light для светлой, Brightness.dark для темной)
    primary: Colors.black, // Основной цвет приложения
    onPrimary: Colors.black, // Цвет текста и значков на основном цвете
    secondary: Color.fromARGB(255, 54, 49, 49), // Вторичный цвет
    onSecondary: Colors.white, // Цвет текста и значков на вторичном цвете
    error: Color(0xFFB00020), // Цвет ошибок
    onError: Colors.white, // Цвет текста и значков на фоне ошибок
    background: Colors.white, // Фон
    onBackground: Colors.white, // Цвет текста и значков на фоне
    surface: Color(0xFFD3D3D3), // Цвет поверхности
    onSurface: Colors.white, // Цвет текста и значков на поверхности
  ),

  listTileTheme: const ListTileThemeData(
    iconColor: Colors.white, // Цвет значков в элементах списка
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.white, // Цвет среднего текста
      fontSize: 20, // Размер шрифта среднего текста
      fontWeight: FontWeight.w500, // Жирность шрифта среднего текста
    ),
    labelSmall: TextStyle(
      color: Colors.white, // Цвет меток
      fontSize: 14, // Размер шрифта меток
      fontWeight: FontWeight.w700, // Жирность шрифта меток
    ),
    headlineMedium: TextStyle(
      color: Colors.white, // Цвет заголовков среднего размера
      fontSize: 14, // Размер шрифта заголовков среднего размера
      fontWeight:
          FontWeight.w700, // Жирность шрифта заголовков среднего размера
    ),
    titleLarge: TextStyle(
      color: Colors.white, // Цвет заголовков среднего размера
      fontSize: 14, // Размер шрифта заголовков среднего размера
      fontWeight:
          FontWeight.w700, // Жирность шрифта заголовков среднего размера
    ),
  ),
);
