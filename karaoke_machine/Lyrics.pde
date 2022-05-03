String[] lyricText;
float[] lyricBeatCue;

/*
* Splits lyric files into two arrays; one for lyrics, one for the beat on which they should display.
*/
void getLyrics(Song s) {
  lyricText = new String[s.lyrics.length];
  lyricBeatCue = new float[s.lyrics.length];
  
  for(int i=0; i < s.lyrics.length; i++) {
    
    String[] lyricLine = s.lyrics[i].split("/");
    
    lyricText[i] = lyricLine[0]; // Whatever comes before the "/"; the text that displays onscreen
    lyricBeatCue[i] = float(lyricLine[1]); // Whatever comes after the "/"; the specific beat on which the lyric should display.
  }
}

/*
* Displays lyrics onscreen.
*/
void drawLyrics(Song s) {
  for(int i=0; i < lyricBeatCue.length; i++) {
    float beatValue = song.melody.position()*(s.bpm/60);
    
    try {
      if(beatValue >= lyricBeatCue[i]) {
        fill(0);
        rect(0, height/1.5, width, height, 30);
        textSize(height/20);
        fill(255);
        text(lyricText[i], width/2, height/1.2);
        textSize(height/40);
        fill(175);
        text(lyricText[i+1], width/2, height/1.1);
      }
    }
     catch (Exception e) {
      if(beatValue >= lyricBeatCue[i]) {
        fill(0);
        rect(0, height/1.5, width, height, 30);
        textSize(height/20);
        fill(255);
        text(lyricText[i], width/2, height/1.2);
       }
     }
   }
}
