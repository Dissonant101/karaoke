/*
* Encapsulates the various files needed for a song in karaoke (accompaniment and melody).
*/
public class Song extends Audio {
  private SoundFile melody;
  private SoundFile accompaniment;
  private String[] lyrics;
  private float bpm;
  
  /*
  * Constructor for Song class.
  */
  public Song(PApplet p, String melody, String accompaniment, String lyrics, float bpm) {
    super(p);
    this.melody = new SoundFile(p, melody);
    this.accompaniment = new SoundFile(p, accompaniment);
    this.lyrics = loadStrings(lyrics);
    this.bpm = bpm;
    this.fft.input(this.melody);
    this.melody.loop();
    this.accompaniment.loop();
  }
  
  /*
  * Start playing the melody and accompaniment files.
  */
  @Override
  public void start() {
    this.melody.play(1, vol);
    this.accompaniment.play(1, vol);
  }
  
  /*
  * Stop playing the melody and accompaniment files.
  */
  @Override
  public void stop() {
    this.melody.stop();
    this.accompaniment.stop();
  }
  
  public void pause() {
    this.melody.pause();
    this.accompaniment.pause();
  }
  
  public boolean isPlaying() {
    return melody.isPlaying();
  }
}
