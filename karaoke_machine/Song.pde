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
  * Stops playing the melody and accompaniment files.
  */
  @Override
  public void stop() {
    this.melody.stop();
    this.accompaniment.stop();
  }
  
  /*
  * Stops playing the melody and accompaniment files but keeps its position.
  */
  public void pause() {
    this.melody.pause();
    this.accompaniment.pause();
  }
  
  /*
  * Checks if the song is currently playing.
  */
  public boolean isPlaying() {
    return melody.isPlaying();
  }
  
  /*
  * Sets the volume of the song.
  */
  public void setVolume() {
    this.melody.amp(vol);
    this.accompaniment.amp(vol);
  }
}
