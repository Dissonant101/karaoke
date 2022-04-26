/*
* Encapsulates the audio input from the microphone.
*/
class Microphone extends Audio {
  AudioIn in;
  
  /*
  * Constructor for Microphone class.
  */
  Microphone(PApplet p) {
    super(p);
    this.in = new AudioIn(p, 0);
    this.fft.input(this.in);
  }
}
