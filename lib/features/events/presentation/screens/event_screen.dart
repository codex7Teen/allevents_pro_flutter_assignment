import 'package:allevents_pro/core/config/app_colors.dart';
import 'package:allevents_pro/core/config/app_text_styles.dart';
import 'package:allevents_pro/core/utils/screen_dimesions_util.dart';
import 'package:allevents_pro/data/models/category_model.dart';
import 'package:allevents_pro/features/events/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ScreenEvents extends StatefulWidget {
  final CategoryModel category;

  const ScreenEvents({super.key, required this.category});

  @override
  State<ScreenEvents> createState() => _ScreenEventsState();
}

class _ScreenEventsState extends State<ScreenEvents> {
  @override
  void initState() {
    super.initState();

    // Fetch events when the screen is first loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventProvider>(
        context,
        listen: false,
      ).fetchEventsByCategory(context, widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = ScreenDimensionsUtil.getScreenHeight(context);
    return Scaffold(
      //! A P P - B A R
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.155),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/appbar_bg_image.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Container(color: AppColors.blackColor.withValues(alpha: 0.7)),

              //! A P P - B A R   C O N T E N T
              Padding(
                padding: const EdgeInsets.only(left: 22, top: 40, right: 22),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 8,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              overflow: TextOverflow.visible,
                              '${widget.category.category[0].toUpperCase() + widget.category.category.substring(1)} Events in Ahmedabad',
                              style: AppTextStyles.bodySmall2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 14),
                          child: Consumer<EventProvider>(
                            builder: (context, eventProvider, child) {
                              return IconButton(
                                icon: Icon(
                                  eventProvider.isGridView
                                      ? Icons.view_list_rounded
                                      : Icons.grid_view_rounded,
                                  size: 26,
                                  color: AppColors.whiteColor,
                                ),
                                onPressed: () => eventProvider.toggleViewMode(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.search_rounded,
                            color: AppColors.greyColor2,
                            size: 22,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: "What’s your next adventure? 🎉",
                                border: InputBorder.none,
                                hintStyle: AppTextStyles.hintTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      //! B O D Y
      body: Consumer<EventProvider>(
        builder: (context, eventProvider, child) {
          if (eventProvider.isEventsLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (eventProvider.eventError != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error loading events'),
                  ElevatedButton(
                    onPressed:
                        () => eventProvider.refreshEvents(
                          context,
                          widget.category,
                        ),
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (eventProvider.events.isEmpty) {
            return Center(child: Text('No events found for this category'));
          }

          return eventProvider.isGridView
              ? _buildGridView(eventProvider)
              : _buildListView(eventProvider);
        },
      ),
    );
  }

  Widget _buildGridView(EventProvider eventProvider) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: eventProvider.events.length,
      itemBuilder: (context, index) {
        final event = eventProvider.events[index];
        return _buildEventCard(event, isGridView: true);
      },
    );
  }

  Widget _buildListView(EventProvider eventProvider) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: eventProvider.events.length,
      itemBuilder: (context, index) {
        final event = eventProvider.events[index];
        return _buildEventCard(event, isGridView: false);
      },
    );
  }

  Widget _buildEventCard(dynamic event, {bool isGridView = false}) {
    return GestureDetector(
      onTap:
          () => Provider.of<EventProvider>(
            context,
            listen: false,
          ).navigateToEventDetails(context, event),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                event.thumbUrl,
                height: isGridView ? 180 : 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Icon(Icons.image_not_supported),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value:
                          loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.eventName,
                    style: AppTextStyles.bodySmall2.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    event.formattedStartDate,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.greyColor2,
                    ),
                  ),
                  Text(
                    event.formattedStartTime,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.greyColor2,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    event.location,
                    style: AppTextStyles.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
