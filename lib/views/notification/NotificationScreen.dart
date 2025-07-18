import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:websuites/utils/container_Utils/ContainerUtils.dart';

import '../../../utils/appColors/app_colors.dart';
import '../../../utils/components/widgets/appBar/custom_appBar.dart';
import '../../../utils/components/widgets/navBar/custom_navBar.dart';
import '../../../utils/fontfamily/FontFamily.dart';
import '../../../viewModels/notification/notification_view_model.dart';
import '../../resources/iconStrings/icon_strings.dart';
import '../../resources/imageStrings/image_strings.dart';
import '../../resources/strings/strings.dart';
import '../../resources/textStyles/responsive/test_responsive.dart';
import '../../utils/common_responsive_list/common_responsive_list.dart';
import '../../utils/components/widgets/navBar/floatingActionButton/floating_action_button.dart';
import '../../utils/dark_mode/dark_mode.dart';
import '../../viewModels/notification/delete/notification_delete__view_model.dart';
import '../homeScreen/home_manager/HomeManagerScreen.dart';

class NotificationScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const NotificationScreen({super.key, required this.scaffoldKey});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with TickerProviderStateMixin {
  final _notificationViewModel = Get.put(NotificationViewModel());
  final _notificationDeleteViewModel = Get.put(NotificationDeleteViewModel());
  final searchController = TextEditingController();
  bool showSearch = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final homeController = Get.find<HomeManagerController>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(),
      floatingActionButton: CustomFloatingButton(
        onPressed: () => setState(() => showSearch = !showSearch),
        imageIcon: IconStrings.navSearch3,
        backgroundColor: AllColors.mediumPurple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor:DarkMode.backgroundColor(context),
      body: Column(
        children: [


          CustomAppBar(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => homeController.resetOrderDetails(),
                  child: Icon(
                    CupertinoIcons.back,
                    color: DarkMode.backgroundColor2(context),
                  ),
                ),
                const SizedBox(width: 8),
                ResponsiveText.getAppBarTextSize(context, Strings.notification),
                Spacer(),


                // ),

                Obx(() {
                  if (_notificationViewModel.unreadCount.value > 0) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.blue.shade400,
                          Colors.blue.shade600
                        ]),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2))
                        ],
                      ),
                      child: Text(
                          '${_notificationViewModel.unreadCount.value}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),

                SizedBox(width: 15,),

              ],
            ),
          ),
          if (showSearch) _buildSearchField(),
          Expanded(
              child: FadeTransition(
            opacity: _fadeAnimation,
            child: Obx(() {
              if (_notificationViewModel.loading.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AllColors.mediumPurple)),
                      const SizedBox(height: 16),
                      Text('Loading notifications...',
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontFamily: FontFamily.sfPro)),
                    ],
                  ),
                );
              }

              if (_notificationViewModel.notifications.isEmpty)
                return _buildEmptyState();

              final filteredNotifications = searchController.text.isEmpty
                  ? _notificationViewModel.notifications
                  : _notificationViewModel.notifications
                      .where((n) =>
                          n.message
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()) ||
                          (n.title?.name?.toLowerCase() ?? '')
                              .contains(searchController.text.toLowerCase()))
                      .toList();

              return RefreshIndicator(
                  onRefresh: () => _notificationViewModel.notificationListApi(),
                  color: AllColors.mediumPurple,
                  child: CardMasonryGrid(

                    items: filteredNotifications,
                    minCardWidth: 327.0,
                    spacing: 10,
                    padding: const EdgeInsets.only(
                        top: 10, left: 15, right: 15, bottom: 0),
                    useCard: false,
                    maxCrossAxisCount: 10,
                    cardBuilder: (notification, index) {
                      return NotificationCard(
                        notification: notification,
                        viewModel: _notificationViewModel,
                        deleteViewModel: _notificationDeleteViewModel,
                        index: index,
                      );
                    },
                  ));
            }),
          )),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
      child: TextField(
        controller: searchController,
        decoration: const InputDecoration(
            hintText: 'Search notifications...',
            border: InputBorder.none,
            icon: Icon(Icons.search, color: Colors.grey)),
        onChanged: (value) => setState(() {}),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
                color: Colors.grey.shade100, shape: BoxShape.circle),
            child: Icon(Icons.notifications_none_rounded,
                size: 80, color: Colors.grey.shade400),
          ),
          const SizedBox(height: 24),
          Text('No notifications yet',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                  fontFamily: FontFamily.sfPro)),
          const SizedBox(height: 8),
          Text('You\'re all caught up! New notifications will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade500,
                  fontFamily: FontFamily.sfPro)),
        ],
      ),
    );
  }
}

class NotificationCard extends StatefulWidget {
  final dynamic notification;
  final NotificationViewModel viewModel;
  final NotificationDeleteViewModel deleteViewModel;
  final int index;

  const NotificationCard(
      {super.key,
      required this.notification,
      required this.viewModel,
      required this.deleteViewModel,
      required this.index});

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation, _scaleAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 300 + (widget.index * 50)),
        vsync: this);
    _slideAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUnread = widget.notification.status == 'Unread';
    final iconColor =
        widget.viewModel.getNotificationColor(widget.notification.title?.color);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0.3, 0), end: Offset.zero)
              .animate(_slideAnimation),
          child: ContainerUtils(
            paddingTop: 0,
            paddingBottom: 0,
            paddingLeft: 0,
            paddingRight: 0,
            margin: const EdgeInsets.only(bottom: 15),
            // decoration: BoxDecoration(
            //   color:Theme.of(context).brightness == Brightness.dark
            //       ? Colors.black
            //       : AllColors.whiteColor,
            //   borderRadius: BorderRadius.circular(16),

            // border: isUnread
            //     ? Border.all(color: Colors.blue.shade200, width: 2)
            //     : null,
            // boxShadow: [
            //   BoxShadow(
            //       color: Colors.black.withOpacity(0.05),
            //       blurRadius: 15,
            //       offset: const Offset(0, 5)),
            //   if (isUnread)
            //     BoxShadow(
            //         color: Colors.blue.withOpacity(0.1),
            //         blurRadius: 20,
            //         offset: const Offset(0, 8)),
            // ],

            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildIcon(iconColor),
                          const SizedBox(width: 16),
                          Expanded(child: _buildContent(isUnread)),
                        ],
                      ),
                      if (widget.notification.message.length > 100)
                        _buildExpandButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(Color iconColor) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [iconColor, iconColor.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: iconColor.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Icon(
          _getIconData(widget.notification.title?.icon,
              widget.notification.title?.color),
          color: Colors.white,
          size: 24),
    );
  }

  Widget _buildContent(bool isUnread) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
                child: Text(widget.notification.title?.name ?? 'Notification',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.sfPro,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black87,
                    ))),
            if (isUnread) _buildUnreadIndicator(),
          ],
        ),
        const SizedBox(height: 8),
        Text(widget.notification.message,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.sfPro,
                color: Colors.grey.shade700,
                height: 1.4),
            maxLines: _isExpanded ? null : 2,
            overflow: _isExpanded ? null : TextOverflow.ellipsis),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildDateChip(),
            const Spacer(),
            _buildActionButtons(isUnread),
          ],
        ),
      ],
    );
  }

  Widget _buildUnreadIndicator() {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.blue.shade600]),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: Colors.blue.withOpacity(0.4),
              blurRadius: 6,
              offset: const Offset(0, 2))
        ],
      ),
    );
  }

  Widget _buildDateChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
      child: Text(widget.viewModel.formatDate(widget.notification.createdAt),
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: FontFamily.sfPro,
              color: Colors.grey.shade600)),
    );
  }

  Widget _buildActionButtons(bool isUnread) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isUnread) ...[
          _buildActionButton(
              Icons.mark_email_read_rounded,
              Colors.blue,
              () => widget.viewModel.markAsRead(widget.notification.id),
              'Mark as read'),
          const SizedBox(width: 8),
        ],
        _buildActionButton(Icons.delete_outline_rounded, Colors.red,
            _showDeleteDialog, 'Delete'),
      ],
    );
  }

  Widget _buildActionButton(
      IconData icon, Color color, VoidCallback onTap, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withOpacity(0.2))),
          child: Icon(icon, color: color, size: 18),
        ),
      ),
    );
  }

  Widget _buildExpandButton() {
    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_isExpanded ? 'Show less' : 'Show more',
                style: TextStyle(
                    color: AllColors.mediumPurple,
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
            const SizedBox(width: 4),
            Icon(_isExpanded ? Icons.expand_less : Icons.expand_more,
                color: AllColors.mediumPurple, size: 20),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AllColors.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Notification'),
        content:
            const Text('Are you sure you want to delete this notification?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel',
                  style: TextStyle(color: Colors.grey.shade600))),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await widget.deleteViewModel
                  .deleteNotificationApi(widget.notification.id);
              await widget.viewModel.notificationListApi();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String? icon, String? color) {
    if (icon != null) {
      switch (icon) {
        case 'mdi:clipboard-check':
          return Icons.check_circle_rounded;
        case 'mdi:information':
          return Icons.info_rounded;
        case 'mdi:alert':
          return Icons.warning_rounded;
        case 'mdi:close-circle':
          return Icons.error_rounded;
      }
    }
    switch (color?.toLowerCase()) {
      case 'success':
        return Icons.check_circle_rounded;
      case 'info':
        return Icons.info_rounded;
      case 'warning':
        return Icons.warning_rounded;
      case 'error':
        return Icons.error_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }
}
