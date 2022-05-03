/*
* Shows notes on screen.
*/
void showNotes() {
  fill(0,0,255);
  int[] noteHeight = {height/14, height/7, 3*height/14, 4*height/14, 5*height/14, 6*height/14, height/2, 8*height/14, 9*height/14, 10*height/14, 11*height/14, 6*height/7};

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

/*
* Finds what note is currently playing so that it can be printed on screen.
*/
void findNote() {
  for (int i = 0; i < 12; i++) {
    if (songNote.equals(notes[i]))
      note = notes[i];
  }
}
