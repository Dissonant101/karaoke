/*
* Encapsulates the audio input from the microphone.
*/
public class Microphone extends Audio {
  private AudioIn in;
  
  /*
  * Constructor for Microphone class.
  */
  public Microphone(PApplet p) {
    super(p);
    this.in = new AudioIn(p, 0);
    this.fft.input(this.in);
  }
  
  /*
  * Start receiving microphone input.
  */
  @Override
  public void start() {
    this.in.start();
  }
  
  /*
  * Stop receiving microphone input.
  */
  @Override
  public void stop() {
    this.in.stop();
  }
}
