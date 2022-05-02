String[] lyricText;
float[] lyricBeatCue;
int beatsElapsed = 0;
Stopwatch stopwatch = new Stopwatch(this);

/*
* Splits lyric files into two arrays; one for lyrics, one for the beat on which they should display
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
    // 1 second every 1000 milliseconds
    // stopwatch.time()*1000 = number of seconds that have passed
    // one second = stopwatch.time()*1000
    // beats per second = bpm/60
    // number of beats elapsed = (stopwatch.time/1000)*(bpm/60)
    float beatValue = (stopwatch.time()/1000)*(s.bpm/60);
    println(beatValue);
    
    if(beatValue >= lyricBeatCue[i]) {
      background(255);
      fill(0);
      text(lyricText[i], width/2, height/1.3);
      fill(150);
      text(lyricText[i+1], width/2, height/1.2);
    }
  }
}
