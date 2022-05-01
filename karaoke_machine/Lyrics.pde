String[] lyricText;
int[] lyricBeatCue;

void drawLyrics(Song s) {
  int beatsElapsed = 0;
  
  lyricText = new String[s.lyrics.length];
  lyricBeatCue = new int[s.lyrics.length];
  
  /*
  * Pulls array of lyrics from a text file 
  */
  
  for(int i=0; i < s.lyrics.length; i++) {
    String[] lyricLine = s.lyrics[i].split("/");
    
    lyricText[i] = lyricLine[0]; // Whatever comes before the "/"; the text that displays onscreen
    lyricBeatCue[i] = int(lyricLine[1]); // Whatever comes after the "/"; the specific beat on which the lyric should display.
  }
    
  for(int i=0; i < lyricBeatCue[lyricBeatCue.length-1]; i++) {
    fill(255);
    text(lyricText[i], width/2, height/4);
    println(lyricText[i]);
    while (beatsElapsed < lyricBeatCue[i]) {
      delay((s.bpm/60)*1000);
      beatsElapsed++;
    }
  }
  
  // delay(1000) = delay by one second
  // delay(60000) = delay by one minute
  // delay(s.bpm/60000); = bpm/m, or x beats in 60 seconds
}
