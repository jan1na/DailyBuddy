import 'package:daily_buddy_app/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'advisor.dart';
import 'blocs/blocs.dart';
import 'screens/screens.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const TopBar(this.title);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
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
          },
        ),
        IconButton(
          icon: Icon(Icons.open_in_browser),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Advisor()),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

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
            leading: Icon(Icons.assignment_ind),
            title: Text('Profil'),
            onTap: () => BlocProvider.of<NavigationBloc>(context)
                .add(OpenUserProfilePageEvent()),
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Resourcen'),
            onTap: () => BlocProvider.of<NavigationBloc>(context)
                .add(OpenUserResourcesPageEvent()),
          ),
          ListTile(
            leading: Icon(Icons.assignment_turned_in),
            title: Text('Erfolge'),
            onTap: () => BlocProvider.of<NavigationBloc>(context)
                .add(OpenUserSuccessesPageEvent()),
          ),
          ListTile(
            leading: Icon(Icons.local_activity),
            title: Text('Aktivitäten'),
            onTap: () => BlocProvider.of<NavigationBloc>(context)
                .add(OpenActivitiesPageEvent()),
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

final Widget sideMenu = SideBar();
final Widget bottomMenu = BottomBar();
final List<Scaffold> mainPages = [
  Scaffold(
      appBar: TopBar("DailyBuddy"),
      body: DashboardPage(),
      drawer: sideMenu,
      bottomNavigationBar: bottomMenu),
  Scaffold(
      appBar: TopBar("Assistent"),
      body: QuestionsPage(),
      drawer: sideMenu,
      bottomNavigationBar: bottomMenu),
  Scaffold(
      appBar: TopBar("Wochenziele"),
      body: WeekGoalsPage(),
      drawer: sideMenu,
      bottomNavigationBar: bottomMenu),
  Scaffold(
      appBar: TopBar("Wochenplan"),
      body: WeekPlanPage(),
      drawer: sideMenu,
      bottomNavigationBar: bottomMenu),
  Scaffold(
      appBar: TopBar("Notfallkontakte"),
      body: EmergencyContactsPage(),
      drawer: sideMenu,
      bottomNavigationBar: bottomMenu),
];

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
          Scaffold sidePage;
          switch (navigationState.runtimeType) {
            case PreferencesPageNavigation:
              sidePage = Scaffold(
                appBar: TopBar("App Einstellungen"),
                body: PreferencesPage(),
              );
              break;
            case AboutUsPageNavigation:
              sidePage = Scaffold(
                appBar: TopBar("Über Uns"),
                body: AboutUsPage(),
              );
              break;
            case ActivitiesPageNavigation:
              sidePage = Scaffold(
                appBar: TopBar("Aktivitäten"),
                body: ActivitiesPage(),
              );
              break;
            case FeedbackPageNavigation:
              sidePage = Scaffold(
                appBar: TopBar("Feedback"),
                body: FeedbackPage(),
              );
              break;
            case HelpPageNavigation:
              sidePage = Scaffold(
                appBar: TopBar("Hilfe"),
                body: HelpPage(),
              );
              break;
            case UserProfilePageNavigation:
              sidePage = Scaffold(
                appBar: TopBar("Profil"),
                body: UserProfilPage(),
              );
              break;
            case UserResourcesPageNavigation:
              sidePage = Scaffold(
                appBar: TopBar("Resourcen"),
                body: UserResourcesPage(),
              );
              break;
            case UserSuccessesPageNavigation:
              sidePage = Scaffold(
                appBar: TopBar("Erfolge"),
                body: UserSuccessesPage(),
              );
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
          Scaffold subPage;
          switch (navigationState.runtimeType) {
            case AddTaskPageNavigation:
              subPage = Scaffold(
                appBar: TopBar("Neue Aufgabe"),
                body: AddTaskPage(),
              );
              break;
            case TaskDetailPageNavigation:
              subPage = Scaffold(
                appBar: TopBar("Aufgabe"),
                body: TaskDetailsPage(
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
            builder: (context, navigationState) {
      return mainPages[navigationState.tabIndex];
    }));
  }
}
