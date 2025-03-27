import 'dart:developer';

import 'package:allevents_pro/core/config/app_colors.dart';
import 'package:allevents_pro/core/config/app_router.dart';
import 'package:allevents_pro/core/config/app_text_styles.dart';
import 'package:allevents_pro/core/utils/screen_dimesions_util.dart';
import 'package:allevents_pro/data/models/category_model.dart';
import 'package:allevents_pro/data/models/events_model.dart';
import 'package:allevents_pro/features/events/presentation/widgets/events_shimmer.dart';
import 'package:allevents_pro/features/events/providers/event_provider.dart';
import 'package:allevents_pro/shared/custom_empty_display_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
      backgroundColor: AppColors.whiteColor,
      //! A P P - B A R
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.145),
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
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.whiteColor,
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FadeInLeft(
                              child: Text(
                                overflow: TextOverflow.visible,
                                '${widget.category.category[0].toUpperCase() + widget.category.category.substring(1)} Events in Ahmedabad',
                                style: AppTextStyles.bodySmall2,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 14),
                          child: Consumer<EventProvider>(
                            builder: (context, eventProvider, child) {
                              return FadeInUp(
                                child: IconButton(
                                  icon: Icon(
                                    eventProvider.isGridView
                                        ? Icons.view_list_rounded
                                        : Icons.grid_view_rounded,
                                    size: 26,
                                    color: AppColors.whiteColor,
                                  ),
                                  onPressed:
                                      () => eventProvider.toggleViewMode(),
                                ),
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
                              onChanged: (value) {
                                Provider.of<EventProvider>(
                                  context,
                                  listen: false,
                                ).searchEvents(value);
                              },
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
            return EventsShimmer();
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

          if (eventProvider.events.isEmpty && eventProvider.isSearchStarted) {
            return CustomEmptyDisplayWidget(
              text:
                  'We couldn’t find what you’re looking for. Please refine your search.',
            );
          } else if (eventProvider.events.isEmpty) {
            return CustomEmptyDisplayWidget(
              text: 'We couldn’t find the events you’re looking for.',
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! T I T L E
              FadeInDown(
                duration: Duration(milliseconds: 600),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Text(
                    'Results in Ahmedabad',
                    style: AppTextStyles.subHeadings,
                  ),
                ),
              ),
              //! LIST & GRID VIEWS
              eventProvider.isGridView
                  ? Expanded(child: _buildGridView(eventProvider))
                  : Expanded(child: _buildListView(eventProvider)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGridView(EventProvider eventProvider) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: eventProvider.events.length,
      itemBuilder: (context, index) {
        final event = eventProvider.events[index];
        return buildEventGridCard(event);
      },
    );
  }

  Widget _buildListView(EventProvider eventProvider) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: eventProvider.events.length,
      itemBuilder: (context, index) {
        final event = eventProvider.events[index];
        return buildEventListCard(event);
      },
    );
  }

  Widget buildEventGridCard(EventModel event) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        children: [
          //! I M A G E
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              event.thumbUrl,
              height: 100,
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

          //! D E T A I L S
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              spacing: 3,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  event.eventName,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium,
                ),
                Text(
                  event.location,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.greyColor2,
                  ),
                ),
                Divider(thickness: 0.3),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          event.formattedStartDate,
                          style: AppTextStyles.bodySmall.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.greyColor2,
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.star_border_rounded,
                      color: AppColors.greyColor,
                      size: 25,
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.ios_share_rounded,
                      color: AppColors.greyColor,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEventListCard(EventModel event) {
    return GestureDetector(
      onTap: () async {
        final url = event.eventUrl;
        if (!await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.inAppBrowserView,
        )) {
          throw Exception('Could not launch url $url');
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //! I M A G E
            Flexible(
              flex: 6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  event.thumbUrl,
                  height: 100,
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
            ),
            SizedBox(width: 12),
            //! D E T A I L S
            Flexible(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  spacing: 3,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      event.eventName,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyMedium,
                    ),
                    Text(
                      event.location,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.greyColor2,
                      ),
                    ),
                    SizedBox(height: 4),
                    Divider(thickness: 0.3),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          event.formattedStartDate,
                          style: AppTextStyles.bodySmall.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.greyColor2,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.star_border_rounded,
                          color: AppColors.greyColor,
                          size: 25,
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.ios_share_rounded,
                          color: AppColors.greyColor,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
