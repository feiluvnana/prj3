import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prj3_app/models/document.model.dart';
import 'package:prj3_app/services/apis/api.dart';

part "document.bloc.freezed.dart";

abstract class DocumentEvent {}

class DocumentFetch extends DocumentEvent {
  final int? offset, sort, limit;
  final List<String>? tags;
  final String? name, originalName;

  DocumentFetch({this.name, this.originalName, this.offset, this.sort, this.limit, this.tags});
}

class DocumentFetchMine extends DocumentEvent {}

class DocumentRefresh extends DocumentEvent {}

class DocumentAdd extends DocumentEvent {}

class DocumentDelete extends DocumentEvent {}

class DocumentReset extends DocumentEvent {}

class DocumentInit extends DocumentEvent {}

class DocumentVote extends DocumentEvent {
  final String id, author;
  final int vote, oldVote;

  DocumentVote(this.id, this.vote, this.author, this.oldVote);
}

@freezed
class DocumentState with _$DocumentState {
  factory DocumentState({
    @Default([]) List<Document> documents,
    @Default([]) List<Document> myDocuments,
    @Default([]) List<Tag> allTags,
  }) = _DocumentState;
}

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  DocumentBloc() : super(DocumentState()) {
    on<DocumentFetch>((event, emit) async {
      await Api()
          .getDocuments(
              limit: event.limit ?? 10,
              offset: event.offset ?? -1,
              sort: event.sort ?? 0,
              tags: event.tags ?? [],
              name: event.name ?? "",
              originalName: event.originalName ?? "")
          .then((value) {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi xảy ra với máy chủ.");
          return;
        }
        if (value["code"].toString().startsWith("403")) {
          Fluttertoast.showToast(msg: "Bạn đã bị đăng xuất.");
          return;
        }
        if (value["code"] == "200 - OK") {
          emit(state.copyWith(documents: [
            ...state.documents,
            ...(value["data"]["documents"] as List).map((e) => Document.fromJson(e))
          ]));
        }
      });
    });
    on<DocumentRefresh>((event, emit) {
      emit(state.copyWith(documents: []));
    });
    on<DocumentVote>((event, emit) async {
      await Api().voteDocument(event.id, event.vote, event.oldVote).then((value) {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi xảy ra với máy chủ.");
          return;
        }
        if (value["code"].toString().startsWith("403")) {
          Fluttertoast.showToast(msg: "Bạn đã bị đăng xuất.");
          return;
        }
        if (value["code"] == "200 - OK") {
          var document = state.documents.firstWhere((element) => element.id == event.id);
          if (event.vote == 0) {
            emit(state.copyWith(
                documents: state.documents
                    .map((e) => (e.id == event.id)
                        ? e.copyWith.vote.call(
                            detail: e.vote.detail
                                .where((element) => element.author != event.author)
                                .toList(),
                            count: e.vote.count -
                                e.vote.detail
                                    .firstWhere((element) => element.author == event.author)
                                    .vote)
                        : e)
                    .toList()));
            return;
          }

          if (document.vote.detail.where((element) => element.author == event.author).isNotEmpty) {
            emit(state.copyWith(
                documents: state.documents
                    .map((e) => (e.id == event.id)
                        ? e.copyWith.vote.call(
                            detail: e.vote.detail
                                .map((e) => e.author == event.author
                                    ? VoteDetail(author: event.author, vote: event.vote)
                                    : e)
                                .toList(),
                            count: e.vote.count + 2 * event.vote)
                        : e)
                    .toList()));
          } else {
            emit(state.copyWith(
                documents: state.documents
                    .map((e) => (e.id == event.id)
                        ? e.copyWith.vote.call(detail: [
                            ...e.vote.detail,
                            VoteDetail(author: event.author, vote: event.vote)
                          ], count: e.vote.count + event.vote)
                        : e)
                    .toList()));
          }
        }
      });
    });

    on<DocumentReset>((event, emit) {
      emit(state.copyWith(documents: [], myDocuments: [], allTags: []));
    });
    on<DocumentInit>((event, emit) async {
      await Api().getTags().then((value) async {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi xảy ra với máy chủ.");
          return;
        }
        if (value["code"].toString().startsWith("403")) {
          Fluttertoast.showToast(msg: "Bạn đã bị đăng xuất.");
          add(DocumentReset());
          return;
        }
        if (value["code"] == "200 - OK") {
          emit(state.copyWith(
              allTags: (value["data"]["tags"] as List).map((e) => Tag.fromJson(e)).toList()));
        }
      });
      add(DocumentFetch());
    });
  }
}
