import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prj3_app/blocs/document.bloc.dart';
import 'package:prj3_app/blocs/student.bloc.dart';
import 'package:prj3_app/helpers/formatter.dart';
import 'package:prj3_app/main.dart';
import 'package:prj3_app/models/document.model.dart';
import 'package:prj3_app/services/apis/api.dart';

enum FetchState { available, uptodate, fetching }

class DocumentUI extends StatefulWidget {
  const DocumentUI({super.key});

  @override
  State<DocumentUI> createState() => _DocumentUIState();
}

class _DocumentUIState extends State<DocumentUI> with TickerProviderStateMixin {
  FetchState fetchState = FetchState.available;
  Map<String, dynamic>? query;
  late final ctrl = TabController(length: 2, vsync: this)
    ..addListener(() {
      setState(() {});
    });
  late final scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollCtrl.addListener(() {
      if (fetchState == FetchState.fetching) {
        Fluttertoast.showToast(msg: "Yêu cầu lấy tài liệu đang được xử lý. Hãy thử lại sau.");
        return;
      }
      if (fetchState == FetchState.uptodate) return;
      if (scrollCtrl.offset < scrollCtrl.position.maxScrollExtent) return;
      fetchState = FetchState.fetching;
      var bloc = context.read<DocumentBloc>();
      bloc.add(DocumentFetch(
          offset: bloc.state.documents.lastOrNull?.createdAt?.millisecondsSinceEpoch,
          sort: query?["sort"],
          tags: query?["tags"],
          name: query?["name"],
          originalName: query?["originalName"]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
              controller: ctrl,
              physics: const NeverScrollableScrollPhysics(),
              tabs: const [Text("Tìm tài liệu"), Text("Tài liệu của tôi")]),
          Expanded(
            child: TabBarView(
              controller: ctrl,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                BlocConsumer<DocumentBloc, DocumentState>(
                  listenWhen: (previous, current) {
                    if ((previous.documents.length > current.documents.length - 10 &&
                        previous.documents.length <= current.documents.length &&
                        current.documents.isNotEmpty)) {
                      fetchState = FetchState.uptodate;
                    } else if (previous.documents.length + 10 == current.documents.length) {
                      fetchState = FetchState.available;
                    }
                    return previous.documents.length != current.documents.length;
                  },
                  listener: (context, state) {},
                  buildWhen: (previous, current) => previous.documents != current.documents,
                  builder: (context, state) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RefreshIndicator(
                          onRefresh: () async {
                            context.read<DocumentBloc>().add(DocumentRefresh());
                            fetchState = FetchState.fetching;
                            context.read<DocumentBloc>().add(DocumentFetch(
                                sort: query?["sort"],
                                tags: query?["tags"],
                                name: query?["name"],
                                originalName: query?["originalName"]));
                          },
                          child: ListView.builder(
                            controller: scrollCtrl,
                            itemBuilder: (context, index) {
                              if (index == state.documents.length) {
                                return Container(
                                    height: MediaQuery.sizeOf(context).height /
                                        7 *
                                        (7 - min(index, 7)));
                              }
                              return _DocumentCard(document: state.documents[index]);
                            },
                            itemCount: state.documents.length + 1,
                          ),
                        ));
                  },
                ),
                const Text("2")
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: ctrl.index == 0
          ? FloatingActionButton(
              onPressed: () => showDialog<Map<String, dynamic>?>(
                      context: context, builder: (context) => DocumentFilterDialog(query: query))
                  .then((value) => (mounted)
                      ? setState(() {
                          print(value);
                          query = value;
                          var bloc = context.read<DocumentBloc>();
                          bloc.add(DocumentRefresh());
                          fetchState == FetchState.fetching;
                          bloc.add(DocumentFetch(
                              sort: value?["sort"],
                              tags: value?["tags"],
                              name: value?["name"],
                              originalName: query?["originalName"]));
                        })
                      : null),
              child: const FaIcon(FontAwesomeIcons.magnifyingGlass))
          : null,
    );
  }
}

class _DocumentCard extends StatefulWidget {
  const _DocumentCard({required this.document});

  final Document document;

  @override
  State<_DocumentCard> createState() => _DocumentCardState();
}

class _DocumentCardState extends State<_DocumentCard> {
  double? progress;

  @override
  void initState() {
    super.initState();
    File("$dataPath/${widget.document.name}").exists().then((value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (value) setState(() => progress = 1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                (widget.document.vote.detail.contains(VoteDetail(
                        author: BlocProvider.of<StudentBloc>(context).state.student!.id, vote: 1)))
                    ? GestureDetector(
                        onTap: () => context.read<DocumentBloc>().add(DocumentVote(
                            widget.document.id,
                            0,
                            BlocProvider.of<StudentBloc>(context).state.student!.id,
                            1)),
                        child: CustomPaint(
                            painter: TrianglePainter(themeData.primaryColor),
                            size: const Size(30, 20)))
                    : GestureDetector(
                        onTap: () => context.read<DocumentBloc>().add(DocumentVote(
                            widget.document.id,
                            1,
                            BlocProvider.of<StudentBloc>(context).state.student!.id,
                            0)),
                        child:
                            CustomPaint(painter: TrianglePainter(null), size: const Size(30, 20))),
                Text("${widget.document.vote.count}", style: themeData.textTheme.labelLarge),
                (widget.document.vote.detail.contains(VoteDetail(
                        author: BlocProvider.of<StudentBloc>(context).state.student!.id, vote: -1)))
                    ? GestureDetector(
                        onTap: () => context.read<DocumentBloc>().add(DocumentVote(
                            widget.document.id,
                            0,
                            BlocProvider.of<StudentBloc>(context).state.student!.id,
                            -1)),
                        child: Transform.flip(
                          flipY: true,
                          child: CustomPaint(
                              painter: TrianglePainter(themeData.colorScheme.error),
                              size: const Size(30, 20)),
                        ))
                    : GestureDetector(
                        onTap: () => context.read<DocumentBloc>().add(DocumentVote(
                            widget.document.id,
                            -1,
                            BlocProvider.of<StudentBloc>(context).state.student!.id,
                            0)),
                        child: Transform.flip(
                            flipY: true,
                            child: CustomPaint(
                                painter: TrianglePainter(null), size: const Size(30, 20)))),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text.rich(TextSpan(children: [
                  WidgetSpan(
                      child: FaIcon(
                    fileExtensionFormatter(widget.document.name),
                    size: themeData.textTheme.titleMedium?.fontSize,
                  )),
                  const TextSpan(text: " "),
                  TextSpan(
                      text: widget.document.originalName, style: themeData.textTheme.titleMedium),
                ])),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(fileSizeFormatter(widget.document.size),
                      style: themeData.textTheme.bodySmall),
                  Text(widget.document.author["email"].toString().split("@")[0],
                      style: themeData.textTheme.bodySmall),
                  switch (progress) {
                    null => IconButton(
                        onPressed: () {
                          setState(() => progress = 0);
                          Api().downloadDocument(
                              name: widget.document.name,
                              onReceivedProgress: (current, total) =>
                                  setState(() => progress = current / total));
                        },
                        icon: const FaIcon(FontAwesomeIcons.download)),
                    1 => IconButton(
                        onPressed: () async {
                          var status = await Permission.storage.status;
                          if (status == PermissionStatus.permanentlyDenied) {
                            openAppSettings();
                            return;
                          } else if (status != PermissionStatus.granted) {
                            if (await Permission.storage.request() != PermissionStatus.granted) {
                              return;
                            }
                          }
                          OpenFile.open("$dataPath/${widget.document.name}");
                        },
                        icon: const FaIcon(FontAwesomeIcons.folderOpen)),
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

class TrianglePainter extends CustomPainter {
  final Color? color;

  TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color ?? Colors.grey
      ..style = PaintingStyle.fill;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, y)
      ..lineTo(x / 2, 0)
      ..lineTo(x, y)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return false;
  }
}

class DocumentFilterDialog extends StatefulWidget {
  final Map<String, dynamic>? query;
  const DocumentFilterDialog({super.key, this.query});

  @override
  State<DocumentFilterDialog> createState() => _DocumentFilterDialogState();
}

class _DocumentFilterDialogState extends State<DocumentFilterDialog> {
  late List<String> tags = widget.query?["tags"] ?? [];
  late int sort = widget.query?["sort"] ?? 0;
  late final name = TextEditingController(text: widget.query?["name"]);
  late final originalName = TextEditingController(text: widget.query?["originalName"]);

  @override
  Widget build(BuildContext context) {
    var allTags = BlocProvider.of<DocumentBloc>(context).state.allTags;
    return AlertDialog(
      title: const Text("Bộ lọc tài liệu"),
      content: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                    controller: name,
                    decoration: const InputDecoration(labelText: "Tên định danh")),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                    controller: originalName,
                    decoration: const InputDecoration(labelText: "Tên gốc")),
              ),
              const Text("Phân loại"),
              Wrap(
                runSpacing: 0,
                spacing: 1,
                children: List.generate(
                    allTags.length,
                    (index) => ChoiceChip(
                        onSelected: (value) => setState(() =>
                            value ? tags.add(allTags[index].id) : tags.remove(allTags[index].id)),
                        label: Text(allTags[index].name),
                        selected: tags.contains(allTags[index].id))),
              ),
              const Text("Sắp xếp"),
              Row(
                children: [
                  Radio<int>(
                      value: 0,
                      groupValue: sort,
                      onChanged: (value) => setState(() => sort = value ?? 0)),
                  const Text("Theo thời gian đăng tải"),
                ],
              ),
              Row(
                children: [
                  Radio<int>(
                      value: 1,
                      groupValue: sort,
                      onChanged: (value) => setState(() => sort = value ?? 1)),
                  const Text("Theo số lượt vote"),
                ],
              )
            ]),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context,
                {"sort": sort, "tags": tags, "name": name.text, "originalName": originalName.text}),
            child: const Text("Áp dụng"))
      ],
    );
  }
}
