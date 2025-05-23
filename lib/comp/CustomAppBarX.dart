import 'package:flutter/material.dart';
import 'package:calc_upeux/theme/AppTheme.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function accionx;

  CustomAppBar({Key? key, required this.accionx})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0D47A1),
      elevation: 4,
      title: const Text(
        "Material UI",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          icon: Icon(
            AppTheme.useLightMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              AppTheme.useLightMode = !AppTheme.useLightMode;
              AppTheme.themeData = ThemeData(
                colorSchemeSeed: AppTheme.colorOptions[AppTheme.colorSelected],
                useMaterial3: AppTheme.useMaterial3,
                brightness: AppTheme.useLightMode ? Brightness.light : Brightness.dark,
              );
              widget.accionx();
            });
          },
          tooltip: "Modo claro / oscuro",
        ),
        IconButton(
          icon: Icon(
            AppTheme.useMaterial3 ? Icons.filter_3 : Icons.filter_2,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              AppTheme.useMaterial3 = !AppTheme.useMaterial3;
              AppTheme.themeData = ThemeData(
                colorSchemeSeed: AppTheme.colorOptions[AppTheme.colorSelected],
                useMaterial3: AppTheme.useMaterial3,
                brightness: AppTheme.useLightMode ? Brightness.light : Brightness.dark,
              );
              widget.accionx();
            });
          },
          tooltip: "Cambiar versión Material",
        ),
        PopupMenuButton<int>(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          itemBuilder: (context) {
            return List.generate(AppTheme.colorOptions.length, (index) {
              final selected = index == AppTheme.colorSelected;
              return PopupMenuItem<int>(
                value: index,
                child: Row(
                  children: [
                    Icon(
                      selected ? Icons.check_circle : Icons.circle_outlined,
                      color: selected ? Colors.teal : Colors.grey[500],
                    ),
                    const SizedBox(width: 12),
                    Text(
                      AppTheme.colorText[index],
                      style: TextStyle(
                        color: selected ? Colors.teal : Colors.black87,
                        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            });
          },
          onSelected: (value) {
            setState(() {
              AppTheme.colorSelected = value;
              AppTheme.themeData = ThemeData(
                colorSchemeSeed: AppTheme.colorOptions[value],
                useMaterial3: AppTheme.useMaterial3,
                brightness: AppTheme.useLightMode ? Brightness.light : Brightness.dark,
              );
              widget.accionx();
            });
          },
        ),
      ],
    );
  }
}
