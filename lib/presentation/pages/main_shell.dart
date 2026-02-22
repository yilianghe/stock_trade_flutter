import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/design_system/app_colors.dart';
import '../../shared/design_system/app_text_styles.dart';
import '../state/providers.dart';
import 'market_page.dart';
import 'signals_page.dart';
import 'strategies_page.dart';
import 'backtest_page.dart';

/// 主框架页面 - 包含底部导航栏和四个 Tab 页面
/// 对应设计稿的 App 主容器，底部 4 个导航按钮：
/// Market / Signals / Strategies / Backtest
class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  /// 当前选中的 Tab 索引
  int _currentIndex = 0;

  /// 四个 Tab 对应的页面，使用 IndexedStack 保持页面状态
  final List<Widget> _pages = const [
    MarketPage(),
    SignalsPage(),
    StrategiesPage(),
    BacktestPage(),
  ];

  /// 切换 Tab 时刷新对应页面的数据
  void _onTabChanged(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);

    switch (index) {
      case 0:
        // Market 页：刷新市场概览 + 指数行情 + 最近信号
        ref.invalidate(marketOverviewProvider);
        ref.invalidate(marketIndexProvider);
        ref.invalidate(signalListProvider);
        break;
      case 1:
        // Signals 页：刷新信号列表
        ref.invalidate(signalListProvider);
        break;
      case 2:
        // Strategies 页：刷新策略列表
        ref.invalidate(strategyListProvider);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      extendBody: true,
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  /// 构建毛玻璃效果的底部导航栏
  Widget _buildBottomNav() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            border: const Border(
              top: BorderSide(color: AppColors.border, width: 0.5),
            ),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 8,
            top: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.dashboard_rounded,
                label: 'Market',
                active: _currentIndex == 0,
                onTap: () => _onTabChanged(0),
              ),
              _NavItem(
                icon: Icons.show_chart_rounded,
                label: 'Signals',
                active: _currentIndex == 1,
                onTap: () => _onTabChanged(1),
              ),
              _NavItem(
                icon: Icons.bar_chart_rounded,
                label: 'Strategies',
                active: _currentIndex == 2,
                onTap: () => _onTabChanged(2),
              ),
              _NavItem(
                icon: Icons.history_rounded,
                label: 'Backtest',
                active: _currentIndex == 3,
                onTap: () => _onTabChanged(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 底部导航栏单个按钮
class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: active
                  ? AppColors.primaryBlue
                  : AppColors.textSecondary,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: active
                    ? AppColors.primaryBlue
                    : AppColors.textSecondary,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
