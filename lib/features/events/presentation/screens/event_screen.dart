import 'package:allevents_pro/core/config/app_colors.dart';
import 'package:allevents_pro/core/utils/screen_dimesions_util.dart';
import 'package:allevents_pro/data/models/category_model.dart';
import 'package:allevents_pro/features/events/presentation/widgets/event_screen_widgets.dart';
import 'package:allevents_pro/features/events/presentation/widgets/events_shimmer.dart';
import 'package:allevents_pro/features/events/providers/event_provider.dart';
import 'package:allevents_pro/shared/custom_empty_display_widget.dart';
import 'package:flutter/material.dart';
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

    //! Fetch events when the screen is first loaded
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
      appBar: EventScreenWidgets.buildAppbar(
        screenHeight,
        context,
        widget.category,
      ),

      //! B O D Y
      body: Consumer<EventProvider>(
        builder: (context, eventProvider, child) {
          //! Displaying shimmer when events are loading
          if (eventProvider.isEventsLoading) {
            return EventsShimmer();
          }

          //! Events loading failed
          if (eventProvider.eventError != null) {
            return EventScreenWidgets.buildEventLoadingFailed(
              eventProvider,
              context,
              widget.category,
            );
          }

          //! Show empty message when events are empty
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

          //! When events are successfully loaded, show list and grid view
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! T I T L E
              EventScreenWidgets.buildPlaceResultsText(),
              //! L I S T - V I E W S  &   G R I D - V I E W S
              eventProvider.isGridView
                  ? Expanded(
                    child: EventScreenWidgets.buildGridView(eventProvider),
                  )
                  : Expanded(
                    child: EventScreenWidgets.buildListView(eventProvider),
                  ),
            ],
          );
        },
      ),
    );
  }
}
