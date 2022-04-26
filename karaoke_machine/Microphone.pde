class Microphone extends Audio {
  AudioIn in;
  
  Microphone(PApplet p) {
    super(p);
    this.in = new AudioIn(p, 0);
    this.fft.input(this.in);
  }
}
