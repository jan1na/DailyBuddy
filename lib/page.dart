import 'package:daily_buddy_app/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'screens/screens.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(child: Image.asset('assets/images/logo.png')),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Wiki'),
            onTap: () => BlocProvider.of<NavigationBloc>(context)
                .add(OpenWikiPageEvent()),
          ),
          ListTile(
            leading: Icon(Icons.assignment_turned_in),
            title: Text('Erfolge'),
            onTap: () => BlocProvider.of<NavigationBloc>(context)
                .add(OpenUserSuccessesPageEvent()),
          ),
          ListTile(
            leading: Icon(Icons.local_activity),
            title: Text('Kalender'),
            onTap: () => BlocProvider.of<NavigationBloc>(context)
                .add(OpenCalendarPageEvent()),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Einstellungen'),
            onTap: () => BlocProvider.of<NavigationBloc>(context)
                .add(OpenPreferencesPageEvent()),
          ),
          ListTile(
            leading: Icon(Icons.live_help),
            title: Text('Hilfe'),
            onTap: () => BlocProvider.of<NavigationBloc>(context)
                .add(OpenHelpPageEvent()),
          ),
          ListTile(
            leading: Icon(Icons.rate_review),
            title: Text('Feedback'),
            onTap: () => BlocProvider.of<NavigationBloc>(context)
                .add(OpenFeedbackPageEvent()),
          ),
          ListTile(
            leading: Icon(Icons.group_work),
            title: Text('Über Uns'),
            onTap: () => BlocProvider.of<NavigationBloc>(context)
                .add(OpenAboutUsPageEvent()),
          ),
        ],
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, navigationState) {
      return BottomNavigationBar(
        // backgroundcolor not working with BottomNavigationBarType.shifting
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        currentIndex: navigationState.tabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            title: Text('Fragen'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            title: Text('Ziele'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            title: Text('Aufgaben'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_phone),
            title: Text('Kontakte'),
          ),
        ],
        onTap: (index) => setPageByIndex(context: context, index: index),
      );
    });
  }
}

class Page extends StatelessWidget {
  final String pageTitle;
  final Widget pageContent;
  final bool hasSideMenu;
  final bool hasBottomMenu;
  const Page({pageTitle, pageContent, hasSideMenu, hasBottomMenu})
      : pageTitle = pageTitle ?? "",
        pageContent = pageContent ?? null,
        hasSideMenu = hasSideMenu ?? false,
        hasBottomMenu = hasBottomMenu ?? false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: hasSideMenu ? SideBar() : null,
      bottomNavigationBar: hasBottomMenu ? BottomBar() : null,
      body: BlocListener<MessagesBloc, MessagesState>(
          listener: (context, messageState) {
            if (messageState is ShowMessage) {
              final TextStyle textStyle = Theme.of(context).textTheme.subhead;
              final double spacing = 10;
              switch (messageState.runtimeType) {
                case ShowErrorMessage:
                  Color errorColor = Theme.of(context).errorColor;      
                  Scaffold.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Wrap(
                        spacing: spacing,
                        children: <Widget>[
                          Icon(Icons.error_outline, color: errorColor),
                          Text(messageState.text,
                              style: textStyle.copyWith(color: errorColor))
                        ],
                      ),
                    ),
                  );
                  break;
                case ShowInfoMessage:
                Color infoColor = Theme.of(context).primaryColor;
                  Scaffold.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Wrap(
                        spacing: spacing,
                        children: <Widget>[
                          Icon(Icons.info_outline, color: infoColor),
                          Text(messageState.text,
                              style:textStyle.copyWith(color: infoColor))
                        ],
                      ),
                    ),
                  );
                  break;
              }
            }
          },
          child: pageContent),
      appBar: AppBar(
        title: Text(pageTitle),
        actions: <Widget>[
          IconButton(
            color: Theme.of(context).errorColor,
            icon: Icon(Icons.cached),
            onPressed: () {
              BlocProvider.of<NotificationsBloc>(context)
                  .add(ClearAllNotificationsEvent());
              BlocProvider.of<TasksBloc>(context).add(ClearAllTasksEvent());
              BlocProvider.of<PreferencesBloc>(context)
                  .add(LoadInitialPreferencesEvent());
              BlocProvider.of<PrioritiesBloc>(context)
                  .add(LoadInitialPrioritiesEvent());
            },
          )
        ],
      ),
    );
  }
}

void setPageByIndex({BuildContext context, int index}) {
  switch (index) {
    case 0:
      BlocProvider.of<NavigationBloc>(context).add(OpenDashboardPageEvent());
      break;
    case 1:
      BlocProvider.of<NavigationBloc>(context).add(OpenQuestionsPageEvent());
      break;
    case 2:
      BlocProvider.of<NavigationBloc>(context).add(OpenWeekGoalsPageEvent());
      break;
    case 3:
      BlocProvider.of<NavigationBloc>(context).add(OpenWeekPlanPageEvent());
      break;
    case 4:
      BlocProvider.of<NavigationBloc>(context)
          .add(OpenEmergencyContactsPageEvent());
      break;
  }
}

Widget getPageByIndex({BuildContext context, int index}) {
  switch (index) {
    case 0:
      return Page(
          pageTitle: "DailyBuddy",
          pageContent: DashboardPage(),
          hasBottomMenu: true,
          hasSideMenu: true);
      break;
    case 1:
      return Page(
          pageTitle: "Assistent",
          pageContent: QuestionsPage(),
          hasBottomMenu: true,
          hasSideMenu: true);
      break;
    case 2:
      return Page(
          pageTitle: "Wochenziele",
          pageContent: WeekGoalsPage(),
          hasBottomMenu: true,
          hasSideMenu: true);
      break;
    case 3:
      return Page(
          pageTitle: "Wochenplan",
          pageContent: WeekPlanPage(),
          hasBottomMenu: true,
          hasSideMenu: true);
      break;
    case 4:
      return Page(
          pageTitle: "Notfallkontakte",
          pageContent: EmergencyContactsPage(),
          hasBottomMenu: true,
          hasSideMenu: true);
      break;
    default:
      return Page(
          pageTitle: "",
          pageContent: Container(),
          hasBottomMenu: true,
          hasSideMenu: true);
  }
}

class DailyBuddyPage extends StatelessWidget {
  const DailyBuddyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
        listener: (context, navigationState) {
      if (navigationState is MainNavigation) {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      } else {
        if (navigationState is SideNavigation) {
          Widget sidePage;
          switch (navigationState.runtimeType) {
            case PreferencesPageNavigation:
              sidePage = Page(
                  pageTitle: "App Einstellungen",
                  pageContent: PreferencesPage());
              break;
            case AboutUsPageNavigation:
              sidePage =
                  Page(pageTitle: "Über Uns", pageContent: AboutUsPage());
              break;
            case CalendarPageNavigation:
              sidePage =
                  Page(pageTitle: "Kalender", pageContent: ActivitiesPage());
              break;
            case FeedbackPageNavigation:
              sidePage =
                  Page(pageTitle: "Feedback", pageContent: FeedbackPage());
              break;
            case HelpPageNavigation:
              sidePage = Page(pageTitle: "Hilfe", pageContent: HelpPage());
              break;
            case WikiPageNavigation:
              sidePage = Page(
                  pageTitle: "Wiki", pageContent: WikiPage());
              break;
            case UserSuccessesPageNavigation:
              sidePage =
                  Page(pageTitle: "Erfolge", pageContent: UserSuccessesPage());
              break;
          }
          if (sidePage != null) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => sidePage))
                .then((_) => setPageByIndex(
                    context: context, index: navigationState.tabIndex));
          }
        }
        if (navigationState is SubNavigation) {
          Widget subPage;
          switch (navigationState.runtimeType) {
            case AddTaskPageNavigation:
              subPage =
                  Page(pageTitle: "Neue Aufgabe", pageContent: AddTaskPage());
              break;
            case TaskDetailPageNavigation:
              subPage = Page(
                pageTitle: "Aufgabe",
                pageContent: TaskDetailsPage(
                    taskId:
                        (navigationState as TaskDetailPageNavigation).taskId),
              );
              break;
          }
          if (subPage != null) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => subPage))
                .then((_) => setPageByIndex(
                    context: context, index: navigationState.tabIndex));
          }
        }
      }
    }, child: BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, tabState) {
      return getPageByIndex(context: context, index: tabState.tabIndex);
    }));
  }
}
