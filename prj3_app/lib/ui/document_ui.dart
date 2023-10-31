import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:prj3_app/main.dart';
import 'package:prj3_app/services/apis/api.dart';

class DocumentUI extends StatefulWidget {
  const DocumentUI({super.key});

  @override
  State<DocumentUI> createState() => _DocumentUIState();
}

class _DocumentUIState extends State<DocumentUI> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: FutureBuilder(
          future: Api().getDocuments(),
          builder: (context, snapshot) {
            final data = snapshot.data?["data"]?["files"] ?? [];
            return ListView.builder(
              itemBuilder: (context, index) {
                return _DocumentCard(data: data[index]);
              },
              itemCount: data.length,
            );
          }),
    );
  }
}

class _DocumentCard extends StatefulWidget {
  const _DocumentCard({required this.data});

  final dynamic data;

  @override
  State<_DocumentCard> createState() => _DocumentCardState();
}

class _DocumentCardState extends State<_DocumentCard> {
  double? progress;

  @override
  void initState() {
    super.initState();
    File("$dataPath/${widget.data["name"]}").exists().then((value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (value) setState(() => progress = 1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Icon(
            Icons.file_copy,
            size: 36,
          ),
          const SizedBox(width: 15),
          Expanded(
              child: Column(
            children: [
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal, child: Text(widget.data["name"])),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("${((widget.data["size"] / 1024) as double).toStringAsFixed(1)}KB"),
                  switch (progress) {
                    null => IconButton(
                        onPressed: () {
                          setState(() => progress = 0);
                          Api().downloadDocument(
                              name: widget.data["name"],
                              onReceivedProgress: (current, total) =>
                                  setState(() => progress = current / total));
                        },
                        icon: const Icon(Icons.download)),
                    1 => IconButton(
                        onPressed: () async {
                          print((await OpenFile.open("$dataPath/${widget.data["name"]}")).message);
                        },
                        icon: const Icon(Icons.file_open)),
                    _ => CircularProgressIndicator(value: progress, strokeWidth: 1)
                  }
                ],
              )
            ],
          )),
        ],
      ),
    ));
  }
}
