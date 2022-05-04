/*
* Finds what note is currently playing so that it can be printed on screen.
*/
void findNote() {
  for (int i = 0; i < 12; i++) {
    if (songNote.equals(notes[i]))
      note = notes[i];
  }
}

/*
* Shows notes on screen.
*/
void showNotes() {
  fill(255);
  int[] noteHeight = {6*space/7, 11*space/14, 10*space/14, 9*space/14, 8*space/14, space/2, 6*space/14, 5*space/14, 4*space/14, 3*space/14, space/7, space/14};

  for (int i = 0; i < notes.length; i++) {
    if (note == notes[i]) {
      if (note != previousNote) {
        movingNotes.add(new PVector(width, noteHeight[i]));
        noteName.add(note);
        previousNote = note;
      }
    }
  }

  for (int j = 0; j < movingNotes.size(); j++) {
    text(noteName.get(j), movingNotes.get(j).x, movingNotes.get(j).y);
      movingNotes.get(j).x -= 2;

    if (movingNotes.get(j).x < 0) {
      movingNotes.remove(j);
      noteName.remove(j);
    }
  }
  fill(0);
}
