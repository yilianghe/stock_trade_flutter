import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../routes/app_router.dart';

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
            title: const Text('关注列表'),
            onTap: () => Navigator.of(context).pushNamed(AppRouter.watchlist),
          ),
          ListTile(
            title: const Text('信号历史'),
            onTap: () => Navigator.of(context).pushNamed(AppRouter.signal),
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
