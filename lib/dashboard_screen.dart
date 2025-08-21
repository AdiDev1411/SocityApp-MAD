import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Directory/emergency_numbers.dart';
import 'Directory/members_screen.dart';
import 'Directory/vehicles_screen.dart';
import 'Interaction/meetings_screen.dart';
import 'Interaction/announcements_screen.dart';
import 'Interaction/notices_screen.dart';
import 'Interaction/events_screen.dart';
import 'Interaction/voting_screen.dart';
import 'Interaction/resources_screen.dart';
import 'Interaction/proposals_screen.dart';
import 'Interaction/suggestions_screen.dart';
import 'Interaction/tasks_screen.dart';
import 'wing_details_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String userName = args['userName'] ?? 'Admin';
    final String joiningCode = args['joiningCode'] ?? 'N/A';
    final Map<String, List<FlatInfo>> wingsData = args['wingsData'] ?? {};

    return Scaffold(
      drawer: _buildAppDrawer(context, userName),
      appBar: AppBar(
        title: Text(userName),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInviteCard(context, joiningCode),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Directory',
              items: [
                _buildGridItem(
                  icon: Icons.people_outline,
                  label: 'Members',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MembersScreen(wingsData: wingsData),
                      ),
                    );
                  },
                ),
                _buildGridItem(
                  icon: Icons.directions_car_outlined,
                  label: 'Vehicles',
                  onTap: () {
                    Navigator.pushNamed(context, '/vehicles');
                  },
                ),
                _buildGridItem(
                  icon: Icons.call_outlined,
                  label: 'Emergency',
                  onTap: () {
                    Navigator.pushNamed(context, '/emergency_numbers');
                  },
                ),
                _buildGridItem(icon: Icons.bar_chart_outlined, label: 'Statistics'),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Interaction',
              items: [
                _buildGridItem(icon: Icons.timer_outlined, label: 'Meeting', onTap: () => Navigator.pushNamed(context, '/meetings')),
                _buildGridItem(icon: Icons.mic_none, label: 'Announcements', onTap: () => Navigator.pushNamed(context, '/announcements')),
                _buildGridItem(icon: Icons.campaign_outlined, label: 'Notice', onTap: () => Navigator.pushNamed(context, '/notices')),
                _buildGridItem(icon: Icons.event_outlined, label: 'Event', onTap: () => Navigator.pushNamed(context, '/events')),
                _buildGridItem(icon: Icons.how_to_vote_outlined, label: 'Voting', onTap: () => Navigator.pushNamed(context, '/voting')),
                _buildGridItem(icon: Icons.source_outlined, label: 'Resources', onTap: () => Navigator.pushNamed(context, '/resources')),
                _buildGridItem(icon: Icons.description_outlined, label: 'Proposal', onTap: () => Navigator.pushNamed(context, '/proposals')),
                _buildGridItem(icon: Icons.lightbulb_outline, label: 'Suggestions', onTap: () => Navigator.pushNamed(context, '/suggestions')),
                _buildGridItem(icon: Icons.task_alt_outlined, label: 'Tasks', onTap: () => Navigator.pushNamed(context, '/tasks')),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'My Building',
              items: [
                _buildGridItem(icon: Icons.business_outlined, label: 'Wings'),
                _buildGridItem(icon: Icons.info_outline, label: 'Building Info'),
                _buildGridItem(icon: Icons.rule_outlined, label: 'Rules'),
                _buildGridItem(icon: Icons.folder_outlined, label: 'Documents'),
                _buildGridItem(icon: Icons.account_balance_outlined, label: 'Bank'),
                _buildGridItem(icon: Icons.payment_outlined, label: 'Payment Gateway'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppDrawer(BuildContext context, String userName) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Colors.indigo),
                ),
                const SizedBox(height: 10),
                Text(
                  userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Terms and Conditions'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy Policy'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInviteCard(BuildContext context, String code) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(code, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                const SizedBox(height: 4),
                const Text('Invite members using this code.'),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: code));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Joining code copied to clipboard!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> items}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 8,
              mainAxisSpacing: 16,
              children: items,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem({required IconData icon, required String label, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.indigo),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
