import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const CyberLabApp());

const green = Color(0xFF71F58B);
const bg = Color(0xFF080D0A);
const panel = Color(0xFF111A14);

class CyberLabApp extends StatelessWidget {
  const CyberLabApp({super.key});
  @override
  Widget build(BuildContext context) {
    final base = ThemeData.dark(useMaterial3: true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CyberLab',
      theme: base.copyWith(
        scaffoldBackgroundColor: bg,
        colorScheme: base.colorScheme.copyWith(primary: green, secondary: green, surface: panel),
        textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(bodyColor: Colors.white, displayColor: Colors.white),
        appBarTheme: const AppBarTheme(backgroundColor: bg, foregroundColor: Colors.white, centerTitle: false),
        cardTheme: CardThemeData(color: panel, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
      ),
      home: const HomePage(),
    );
  }
}

class Lesson {
  final String title, category, level, description, command, explanation;
  const Lesson(this.title, this.category, this.level, this.description, this.command, this.explanation);
}

const lessons = <Lesson>[
  Lesson('Termux setup', 'Termux', 'Beginner', 'Termux ko update karke basic environment ready karo.', 'pkg update && pkg upgrade', 'Package list refresh hoti hai aur installed packages upgrade hote hain.'),
  Lesson('Useful Termux packages', 'Termux', 'Beginner', 'Common development utilities install karo.', 'pkg install python git curl nano', 'Python, Git, curl aur Nano editor install hote hain.'),
  Lesson('Linux files & folders', 'Termux', 'Beginner', 'Current folder aur files samjho.', 'pwd && ls -la', 'pwd current location dikhata hai; ls files aur folders list karta hai.'),
  Lesson('Python version check', 'Termux', 'Beginner', 'Python installation verify karo.', 'python --version', 'Installed Python version print hota hai.'),
  Lesson('Bash scripting intro', 'Termux', 'Intermediate', 'Simple shell script ka structure samjho.', 'echo "Hello CyberLab"', 'echo terminal par text print karta hai. Isse scripts ka basic output samajh aata hai.'),
  Lesson('Kali Linux system info', 'Kali Linux', 'Beginner', 'System details check karo.', 'uname -a', 'Kernel aur system architecture details show hoti hain.'),
  Lesson('APT package management', 'Kali Linux', 'Beginner', 'Kali packages update karo.', 'sudo apt update', 'Repository package indexes refresh hote hain.'),
  Lesson('Nmap: local lab discovery', 'Kali Linux', 'Intermediate', 'Sirf apne lab machine ya authorized target ko scan karna seekho.', 'nmap -sV 192.168.56.10', 'Ye example isolated lab IP ke liye hai. Apne network ke bahar permission ke bina scan mat karo.'),
  Lesson('Wireshark basics', 'Kali Linux', 'Intermediate', 'Packet capture aur protocol analysis ka intro.', 'wireshark', 'Wireshark GUI launch hota hai. Capture sirf apne ya authorized network par karo.'),
  Lesson('HTTP security basics', 'Cybersecurity', 'Beginner', 'HTTP request/response aur HTTPS ka role samjho.', 'curl -I https://example.com', 'Headers inspect karke server response metadata seekh sakte ho.'),
  Lesson('File integrity check', 'Scripts', 'Beginner', 'File hash se integrity verify karo.', 'sha256sum sample.txt', 'SHA-256 digest file change detect karne mein help karta hai.'),
  Lesson('Password strength concept', 'Cybersecurity', 'Beginner', 'Length, uniqueness aur randomness kyun matter karte hain.', 'python -c "print(len(input()) >= 14)"', 'Ye sirf length demo hai; real password ko terminal ya kisi third-party site par paste mat karo.'),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;
  String query = '';
  final search = TextEditingController();
  final categories = const ['All', 'Termux', 'Kali Linux', 'Scripts', 'Cybersecurity'];
  String selected = 'All';

  @override
  Widget build(BuildContext context) {
    final pages = [
      _home(),
      _library(),
      const PracticePage(),
      const LearnPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Container(width: 34, height: 34, decoration: BoxDecoration(color: green.withOpacity(.14), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.shield_moon_outlined, color: green)),
          const SizedBox(width: 10),
          const Text('Cyber', style: TextStyle(fontWeight: FontWeight.w800)),
          const Text('Lab', style: TextStyle(color: green, fontWeight: FontWeight.w800)),
        ]),
        actions: [IconButton(onPressed: () => _showAbout(context), icon: const Icon(Icons.info_outline))],
      ),
      body: IndexedStack(index: tab, children: pages),
      bottomNavigationBar: NavigationBar(
        backgroundColor: panel,
        indicatorColor: green.withOpacity(.15),
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.terminal), label: 'Library'),
          NavigationDestination(icon: Icon(Icons.code), label: 'Practice'),
          NavigationDestination(icon: Icon(Icons.school_outlined), label: 'Learn'),
        ],
      ),
    );
  }

  Widget _home() {
    return ListView(padding: const EdgeInsets.all(18), children: [
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(gradient: LinearGradient(colors: [const Color(0xFF183B25), panel]), borderRadius: BorderRadius.circular(22), border: Border.all(color: green.withOpacity(.25))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('LEARN • PRACTICE • SECURE', style: TextStyle(color: green, letterSpacing: 1.3, fontSize: 11, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Text('Cybersecurity\\nseekho, safely.', style: TextStyle(fontSize: 29, height: 1.1, fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          Text('Termux, Kali Linux aur security fundamentals — simple Hinglish mein.', style: TextStyle(color: Colors.white.withOpacity(.72), height: 1.4)),
          const SizedBox(height: 18),
          FilledButton.icon(onPressed: () => setState(() => tab = 1), icon: const Icon(Icons.arrow_forward), label: const Text('Explore learning library')),
        ]),
      ),
      const SizedBox(height: 22),
      const _SectionTitle('Learning tracks', 'Apna path choose karo'),
      const SizedBox(height: 10),
      _TrackCard(icon: Icons.terminal, title: 'Termux Complete Course', subtitle: 'Commands, packages, Python, Bash', count: '5 lessons', onTap: () => _openCategory('Termux')),
      _TrackCard(icon: Icons.computer, title: 'Kali Linux Complete Course', subtitle: 'Linux basics, tools aur lab workflow', count: '4 lessons', onTap: () => _openCategory('Kali Linux')),
      _TrackCard(icon: Icons.code, title: 'Tools & Scripts Library', subtitle: 'Safe command examples and code concepts', count: '2 lessons', onTap: () => setState(() => tab = 1)),
      _TrackCard(icon: Icons.shield_outlined, title: 'Cybersecurity Academy', subtitle: 'Networking, web security, privacy', count: '3 lessons', onTap: () => _openCategory('Cybersecurity')),
      const SizedBox(height: 12),
      const _SectionTitle('Safety first', 'Practice only where you have permission'),
      const Text('CyberLab educational use ke liye hai. Real systems, accounts ya networks ko test karne se pehle explicit authorization lo. Practice ke liye local/isolated lab use karo.', style: TextStyle(color: Colors.white70, height: 1.5)),
    ]);
  }

  Widget _library() {
    final filtered = lessons.where((l) {
      final matchCategory = selected == 'All' || l.category == selected;
      final q = query.toLowerCase();
      final matchQuery = q.isEmpty || '${l.title} ${l.description} ${l.category}'.toLowerCase().contains(q);
      return matchCategory && matchQuery;
    }).toList();
    return Column(children: [
      Padding(padding: const EdgeInsets.fromLTRB(16, 14, 16, 8), child: TextField(
        controller: search,
        onChanged: (v) => setState(() => query = v),
        decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: 'Tools, commands, topics search karo...', filled: true, fillColor: panel, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none)),
      )),
      SizedBox(height: 48, child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 12), children: categories.map((c) => Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: ChoiceChip(label: Text(c), selected: selected == c, onSelected: (_) => setState(() => selected = c))).toList())),
      Expanded(child: filtered.isEmpty ? const Center(child: Text('Koi result nahi mila.')) : ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
        itemCount: filtered.length,
        itemBuilder: (_, i) => _LessonCard(lesson: filtered[i]),
      )),
    ]);
  }

  void _openCategory(String category) {
    setState(() { selected = category; tab = 1; });
  }
}

class _SectionTitle extends StatelessWidget {
  final String title, subtitle;
  const _SectionTitle(this.title, this.subtitle);
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
    const SizedBox(height: 3),
    Text(subtitle, style: const TextStyle(color: Colors.white60, fontSize: 12)),
  ]);
}

class _TrackCard extends StatelessWidget {
  final IconData icon;
  final String title, subtitle, count;
  final VoidCallback onTap;
  const _TrackCard({required this.icon, required this.title, required this.subtitle, required this.count, required this.onTap});
  @override
  Widget build(BuildContext context) => Card(child: ListTile(
    onTap: onTap, contentPadding: const EdgeInsets.all(12),
    leading: Container(width: 46, height: 46, decoration: BoxDecoration(color: green.withOpacity(.12), borderRadius: BorderRadius.circular(13)), child: Icon(icon, color: green)),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Padding(padding: const EdgeInsets.only(top: 4), child: Text('$subtitle\\n$count', style: const TextStyle(color: Colors.white60, height: 1.4))),
    trailing: const Icon(Icons.chevron_right, color: green),
  ));
}

class _LessonCard extends StatelessWidget {
  final Lesson lesson;
  const _LessonCard({required this.lesson});
  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 10),
    child: ListTile(
      contentPadding: const EdgeInsets.all(14),
      leading: const Icon(Icons.menu_book_outlined, color: green, size: 28),
      title: Text(lesson.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Padding(padding: const EdgeInsets.only(top: 5), child: Text('${lesson.category} • ${lesson.level}\\n${lesson.description}', style: const TextStyle(color: Colors.white60, height: 1.4))),
      trailing: const Icon(Icons.arrow_forward_ios, size: 15),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LessonPage(lesson: lesson))),
    ),
  );
}

class LessonPage extends StatelessWidget {
  final Lesson lesson;
  const LessonPage({super.key, required this.lesson});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(lesson.category)),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      Text(lesson.level.toUpperCase(), style: const TextStyle(color: green, letterSpacing: 1.2, fontWeight: FontWeight.bold, fontSize: 11)),
      const SizedBox(height: 8),
      Text(lesson.title, style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
      const SizedBox(height: 14),
      Text(lesson.description, style: const TextStyle(color: Colors.white70, height: 1.5)),
      const SizedBox(height: 22),
      const Text('Command example', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      const SizedBox(height: 8),
      _CommandBox(command: lesson.command),
      const SizedBox(height: 18),
      const Text('Ye command kya karti hai?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      const SizedBox(height: 8),
      Text(lesson.explanation, style: const TextStyle(color: Colors.white70, height: 1.5)),
      const SizedBox(height: 18),
      const Text('Note: command ko samajh kar hi run karein. Network testing sirf authorized lab ya apne system par karein.', style: TextStyle(color: green, height: 1.5)),
    ]),
  );
}

class _CommandBox extends StatelessWidget {
  final String command;
  const _CommandBox({required this.command});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: const Color(0xFF050806), borderRadius: BorderRadius.circular(14), border: Border.all(color: green.withOpacity(.25))),
    child: Row(children: [
      Expanded(child: SelectableText(command, style: const TextStyle(fontFamily: 'monospace', color: green, fontSize: 13))),
      IconButton(tooltip: 'Copy command', onPressed: () { Clipboard.setData(ClipboardData(text: command)); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Command copied'))); }, icon: const Icon(Icons.copy, color: green)),
    ]),
  );
}

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});
  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  final input = TextEditingController();
  final output = <String>['CyberLab safe practice terminal', 'Type help to see supported demo commands.'];
  void run() {
    final cmd = input.text.trim();
    if (cmd.isEmpty) return;
    String result;
    final lower = cmd.toLowerCase();
    if (lower == 'help') {
      result = 'Available demo commands: help, pwd, ls, whoami, date, clear, echo <text>, cyberlab-info';
    } else if (lower == 'pwd') {
      result = '/home/student/cyberlab-lab';
    } else if (lower == 'ls') {
      result = 'lessons/  notes/  sample.txt  README.md';
    } else if (lower == 'whoami') {
      result = 'student';
    } else if (lower == 'date') {
      result = DateTime.now().toLocal().toString();
    } else if (lower == 'cyberlab-info') {
      result = 'Isolated educational simulator. Ye real Android/Termux shell nahi hai.';
    } else if (lower == 'clear') {
      setState(() => output.clear()); input.clear(); return;
    } else if (lower.startsWith('echo ')) {
      result = cmd.substring(5);
    } else {
      result = 'Blocked: real shell execution disabled. Is terminal mein sirf safe demo commands run hoti hain. Termux/Kali ke liye Library se command copy karein.';
    }
    setState(() { output.add('\$ $cmd'); output.add(result); });
    input.clear();
  }
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Safe Practice Terminal', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
      const SizedBox(height: 5),
      const Text('Learning simulator — actual OS shell nahi.', style: TextStyle(color: Colors.white60)),
      const SizedBox(height: 14),
      Expanded(child: Container(width: double.infinity, padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFF030604), borderRadius: BorderRadius.circular(16), border: Border.all(color: green.withOpacity(.25))), child: ListView(children: output.map((line) => Padding(padding: const EdgeInsets.only(bottom: 7), child: SelectableText(line, style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: line.startsWith('\$') ? green : Colors.white70)))).toList()))),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(child: TextField(controller: input, onSubmitted: (_) => run(), style: const TextStyle(fontFamily: 'monospace'), decoration: InputDecoration(hintText: 'help', filled: true, fillColor: panel, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)))),
        const SizedBox(width: 8),
        IconButton.filled(onPressed: run, icon: const Icon(Icons.play_arrow)),
      ]),
    ]),
  );
}

class LearnPage extends StatelessWidget {
  const LearnPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Cybersecurity Academy', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    const SizedBox(height: 6),
    const Text('Fundamentals se practical security tak structured roadmap.', style: TextStyle(color: Colors.white60)),
    const SizedBox(height: 18),
    _RoadmapTile('01', 'Computer & Linux basics', 'Files, permissions, processes, shell basics'),
    _RoadmapTile('02', 'Networking fundamentals', 'IP, DNS, TCP/UDP, ports, HTTP/HTTPS'),
    _RoadmapTile('03', 'Programming for security', 'Python, Bash, reading code safely'),
    _RoadmapTile('04', 'Web security concepts', 'Authentication, sessions, input validation, OWASP concepts'),
    _RoadmapTile('05', 'Defensive security', 'Logs, patching, backups, MFA, threat modelling'),
    _RoadmapTile('06', 'Authorized practice labs', 'Use intentionally vulnerable local labs and CTF environments'),
    const SizedBox(height: 18),
    const Text('Next content expansion', style: TextStyle(color: green, fontWeight: FontWeight.bold)),
    const Text('Is starter version mein learning app ka core UI, search, command-copy aur safe terminal included hain. Full course ke liye verified lesson content aur lab exercises step-by-step add karne honge.', style: TextStyle(color: Colors.white70, height: 1.5)),
  ]);
}

class _RoadmapTile extends StatelessWidget {
  final String number, title, detail;
  const _RoadmapTile(this.number, this.title, this.detail);
  @override
  Widget build(BuildContext context) => Card(child: ListTile(
    leading: CircleAvatar(backgroundColor: green.withOpacity(.14), child: Text(number, style: const TextStyle(color: green, fontWeight: FontWeight.bold))),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(detail, style: const TextStyle(color: Colors.white60)),
  ));
}

void _showAbout(BuildContext context) => showAboutDialog(
  context: context, applicationName: 'CyberLab',
  applicationVersion: '1.0.0 MVP',
  applicationLegalese: 'Educational cybersecurity learning app. Use tools only on systems you own or are explicitly authorized to test.',
);
