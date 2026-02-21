import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../routes/app_router.dart';

/// 旧版首页（已被 MainShell 替代，保留为备用入口）
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.appName)),
      body: ListView(
        children: [
          const ListTile(
            title: Text('系统说明'),
            subtitle: Text(AppConstants.disclaimer),
          ),
          ListTile(
            title: const Text('股票搜索'),
            onTap: () => Navigator.of(context).pushNamed(AppRouter.stockSearch),
          ),
        ],
      ),
    );
  }
}
