/*
* Sets the current display to the main menu.
*/
public void displayMainMenu() {
  gameState = "menu";
  pause.setVisible(false);
  volume.setVisible(false);
  quit.setVisible(false);
  start.setVisible(true);
  songSelection.setVisible(true);
  exit.setVisible(true);
  backToMenu.setVisible(false);
  volumeLabel.setVisible(false);
  
  fill(255);
  textSize(40);
}

/*
* Sets the current display to the karaoke screen.
*/
public void displayKaraoke() {
  gameState = "play";
  pause.setVisible(true);
  volume.setVisible(true);
  quit.setVisible(true);
  start.setVisible(false);
  songSelection.setVisible(false);
  exit.setVisible(false);
  backToMenu.setVisible(false);
  volumeLabel.setVisible(true);
  
  movingNotes.clear();
  noteName.clear();
  accuracySum = 0;
  divisor = 0;
  mic = new Microphone(this);
  getLyrics(song);
  mic.start();
  song.start();
}

/*
* Sets the current display to the game over screen.
*/
public void displayGameOver() {
  gameState = "game over";
  pause.setVisible(false);
  volume.setVisible(false);
  quit.setVisible(false);
  start.setVisible(false);
  songSelection.setVisible(false);
  exit.setVisible(true);
  backToMenu.setVisible(true);
  volumeLabel.setVisible(false);
  
  paused = false;
  pause.setText("Pause");
  song.melody.cue(0);
  song.accompaniment.cue(0);
  song.stop();
  
  fill(255);
  textSize(15);
}
