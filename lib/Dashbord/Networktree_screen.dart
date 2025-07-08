
// import 'package:flutter/material.dart';
//
// class NetworkTree extends StatelessWidget {
//   const NetworkTree({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text("My Network Tree"),
//         backgroundColor: Colors.black,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: TreeNode(
//           title: "👤 You (ID123456)",
//           children: [
//             TreeNode(
//               title: "👩 Ayesha (ID327087)",
//               children: [
//                 LeafNode(title: "👩 Sana (ID327088)"),
//                 TreeNode(
//                   title: "👩 Tripti (ID327088)",
//                   children: [
//                     LeafNode(title: "👩 Sana (ID327088)"),
//                     LeafNode(title: "👩 Khushi (ID327088)"),
//                     LeafNode(title: "👩 Jaya (ID327088)"),
//                   ],
//                 ),
//               ],
//             ),
//             TreeNode(
//               title: "👨 Keshav (ID327089)",
//               children: [
//                 LeafNode(title: "👩 Payal (ID327090)"),
//                 TreeNode(
//                   title: "👩 Deepika (ID327090)",
//                   children: [
//                     LeafNode(title: "👨 Avdhesh (ID327090)"),
//                     TreeNode(
//                       title: "👨 Yuvraj (ID327090)",
//                       children: [
//                         LeafNode(title: "👨 Amit (ID327090)"),
//                         LeafNode(title: "👩 Aditi (ID327090)"),
//                       ],
//                     ),
//                     LeafNode(title: "👨 Abc (ID327090)"),
//                     LeafNode(title: "👩 Xyz (ID327090)"),
//                   ],
//                 ),
//               ],
//             ),
//             TreeNode(
//               title: "👨 A (ID327089)",
//               children: [
//                 LeafNode(title: "👩 B (ID327090)"),
//                 TreeNode(
//                   title: "👩 C (ID327090)",
//                   children: [
//                     LeafNode(title: "👨 D (ID327090)"),
//                     TreeNode(
//                       title: "👨 Y (ID327090)",
//                       children: [
//                         LeafNode(title: "👨 F (ID327090)"),
//                         LeafNode(title: "👩 G (ID327090)"),
//                       ],
//                     ),
//                     LeafNode(title: "👨 Abc (ID327090)"),
//                     LeafNode(title: "👩 Xyz (ID327090)"),
//                   ],
//                 ),
//               ],
//             ),
//
//             TreeNode(
//               title: "👨 Keshav (ID327089)",
//               children: [
//                 LeafNode(title: "👩 Payal (ID327090)"),
//                 TreeNode(
//                   title: "👩 Deepika (ID327090)",
//                   children: [
//                     LeafNode(title: "👨 Avdhesh (ID327090)"),
//                     TreeNode(
//                       title: "👨 Yuvraj (ID327090)",
//                       children: [
//                         LeafNode(title: "👨 Amit (ID327090)"),
//                         LeafNode(title: "👩 Aditi (ID327090)"),
//                       ],
//                     ),
//                     LeafNode(title: "👨 Abc (ID327090)"),
//                     LeafNode(title: "👩 Xyz (ID327090)"),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class TreeNode extends StatefulWidget {
//   final String title;
//   final List<Widget> children;
//
//   const TreeNode({super.key, required this.title, required this.children});
//
//   @override
//   State<TreeNode> createState() => _TreeNodeState();
// }
//
// class _TreeNodeState extends State<TreeNode> {
//   bool _expanded = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         GestureDetector(
//           onTap: () => setState(() => _expanded = !_expanded),
//           child: Row(
//             children: [
//               Icon(
//                 _expanded ? Icons.arrow_drop_down : Icons.arrow_right,
//                 color: Colors.blue,
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 widget.title,
//                 style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//         if (_expanded)
//           Padding(
//             padding: const EdgeInsets.only(left: 24),
//             child: Column(
//               children: widget.children.map((child) {
//                 return Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: 1,
//                       height: 30,
//                       color: Colors.white,
//                       margin: const EdgeInsets.only(top: 0, right: 12),
//                     ),
//                     Expanded(child: child),
//                   ],
//                 );
//               }).toList(),
//             ),
//           ),
//       ],
//     );
//   }
// }
//
// class LeafNode extends StatelessWidget {
//   final String title;
//
//   const LeafNode({super.key, required this.title});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Text(
//         title,
//         style: const TextStyle(color: Colors.white),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hotstar/service/api_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkTree extends StatefulWidget {
  const NetworkTree({super.key});

  @override
  State<NetworkTree> createState() => _NetworkTreeState();
}

class _NetworkTreeState extends State<NetworkTree> {
  bool _loading = true;
  Map<String, dynamic>? treeData;

  @override
  void initState() {
    super.initState();
    fetchTree();
  }

  Future<void> fetchTree() async {
    final prefs = await SharedPreferences.getInstance();
    final id =  await prefs.getString('id');
    print("deepika");
    print(id);
    try {
      final response = await ApiMethods.fetchNetworkTree(id as String); // Replace with actual user ID
      print(response);
      setState(() {
        treeData = response['data'];
        _loading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() => _loading = false);
    }
  }

  Widget buildTree(Map<String, dynamic> node) {
    final String name = node['name'];
    final String memberId = node['memberid'];
    final List<dynamic> downlines = node['downlines'];

    if (downlines.isEmpty) {
      return LeafNode(title: "👤 $name ($memberId)");
    }

    return TreeNode(
      title: "👤 $name ($memberId)",
      children: downlines.map<Widget>((child) => buildTree(child)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("My Network Tree"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : treeData == null
          ? const Center(
        child: Text("No data found", style: TextStyle(color: Colors.white)),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: buildTree(treeData!),
      ),
    );
  }
}
class TreeNode extends StatefulWidget {
  final String title;
  final List<Widget> children;

  const TreeNode({super.key, required this.title, required this.children});

  @override
  State<TreeNode> createState() => _TreeNodeState();
}

class _TreeNodeState extends State<TreeNode> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  _expanded ? Icons.arrow_drop_down : Icons.arrow_right,
                  color: Colors.blue,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Column(
                children: widget.children.map((child) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.white,
                        margin: const EdgeInsets.only(top: 0, right: 12),
                      ),
                      Expanded(child: child),
                    ],
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class LeafNode extends StatelessWidget {
  final String title;

  const LeafNode({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
