// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:storysaver_app/bloc/note_event.dart';
// import 'package:storysaver_app/bloc/note_state.dart';
// import 'package:storysaver_app/models/note.dart';


// // Sự kiện cho các hoạt động quản lý ghi chú


// class NotesBloc extends Bloc<NotesEvent, NotesState> {
//    final _notes = <Note>[];

//   NotesBloc() : super(NotesLoaded([]));

//   NotesState get initialState => NotesLoaded(_notes);

//   Stream<NotesState> mapEventToState(NotesEvent event) async* {
//     if (event is AddNote) {
//       _notes.add(event.note);
//       yield NotesLoaded(_notes);
//     } else if (event is DeleteNote) {
//       _notes.remove(event.note);
//       yield NotesLoaded(_notes);
//     }
//   }
// }