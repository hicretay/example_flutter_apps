import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:note_app/database/dbNotes.dart';
import 'package:note_app/model/note.dart';

class NotePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotePageState();
  }
}

class _NotePageState extends State {
  var dbNotes = DbNotes();
  List<Note> notes; //Note sınıfı türünde bir not listesi
  int noteCount = 0;
  TextEditingController txtTitle =
      TextEditingController(); // textfield in controllerına verilebilir
  TextEditingController txtDescription = TextEditingController();

  void getNotes() async {
    var notesFuture = dbNotes
        .getNotes(); // sayfa acıldıgında urunler gelene kadar async yapı calısır
    notesFuture.then((data) {
      // then: ileride data geldiginde
      setState(() {
        this.notes = data; //notlar data ya esit
        noteCount = data.length; //notlar data uzunlugu kadar
      });
    });
  }

  @override
  void initState() {
    setState(() {
      getNotes();
      super
          .initState(); // base classtaki state in initstate' ini çalıstır demek
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "NOTLAR",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 30),
        tooltip: "Not Ekle",
        onPressed: () {
          setState(() {
            noteAddPopUp(context);
          });
        },
      ),
      body: buildNoteList(),
    );
  }

  ListView buildNoteList() {
    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      itemCount: noteCount,
      itemBuilder: (BuildContext context, int position) {
        return Slidable(
            child: Card(
              child: ListTile(
                title: Text(
                  notes[position].title,
                  style: TextStyle(fontSize: 21),
                ),
                subtitle: Text(notes[position].description),
              ),
            ),
            actionPane: SlidableScrollActionPane(),
            actions: [
              IconSlideAction(
                caption: "Düzenle",
                icon: Icons.edit,
                color: Colors.blue[900],
                onTap: () {
                  setState(() {
                    noteEditPopUp(context, notes[position]);
                    getNotes();
                  });
                },
              )
            ],
            secondaryActions: [
              IconSlideAction(
                closeOnTap: true,
                caption: "Sil",
                icon: Icons.highlight_remove,
                color: Colors.red,
                onTap: () {
                  setState(() {
                    deleteNote(notes[position].id);
                    getNotes();
                  });
                },
              ),
            ]);
      },
    );
  }

  noteEditPopUp(BuildContext context, Note note) {
    txtTitle.text = note.title;
    txtDescription.text = note.description;

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: TextField(
              decoration: InputDecoration(labelText: "Başlık"),
              controller: txtTitle,
              autofocus: true,
            ),
            content: TextField(
              decoration: InputDecoration(labelText: "Açıklama"),
              controller: txtDescription,
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Düzenle"),
                onPressed: () {
                  setState(() {
                    note.title = txtTitle.text;
                    note.description = txtDescription.text;
                    updateNote(note.id, note);
                    getNotes();
                  });
                  txtTitle.text = "";
                  txtDescription.text = "";
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("İptal"),
                onPressed: () {
                  txtTitle.text = "";
                  txtDescription.text = "";
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  noteAddPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: TextField(
            decoration: InputDecoration(labelText: "Başlık"),
            controller: txtTitle,
            autofocus: true,
          ),
          content: TextField(
            decoration: InputDecoration(labelText: "Açıklama"),
            controller: txtDescription,
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Ekle"),
              onPressed: () {
                setState(() {
                  addNote();
                  getNotes();
                });
                txtTitle.text = "";
                txtDescription.text = "";
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("İptal"),
              onPressed: () {
                txtTitle.text = "";
                txtDescription.text = "";
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<int> deleteNote(int id) async {
    final result = await dbNotes.delete(id);
    return result;
  }

  Future<int> addNote() async {
    var result = await dbNotes
        .insert(Note(title: txtTitle.text, description: txtDescription.text));
    return result;
  }

  Future<int> updateNote(int id, Note note) async {
    var result = await dbNotes.update(id, note);
    return result;
  }
}
