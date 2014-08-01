import ddf.minim.*;
import ddf.minim.ugens.*;
 
Minim       minim;
AudioOutput out;
Oscil       wave;
 
void setup()
{
  size(800, 600);
  background(#000000);
  
  minim = new Minim(this);
  out = minim.getLineOut();
 
  // create a sine wave Oscil, set to 440 Hz, at 0.5 amplitude
  wave = new Oscil( 440, 0.5f, Waves.SINE );
  // patch the Oscil to the output
  wave.patch( out );
}
 
void draw()
{
  strokeWeight(5);
  stroke(#FFFFFF);
  if(mousePressed == true){
    if(mouseButton == RIGHT){
      background(0);
    }else{
      out.unmute();
      line(mouseX, mouseY, pmouseX, pmouseY);
      float amp = map( mouseY, 0, height, 1, 0 );
      wave.setAmplitude( amp );
 
      float freq = map( mouseX, 0, width, 110, 880 );
      wave.setFrequency( freq );
    }
    
  }else{
    out.mute();
  }
 
}

void stop()
{
  minim.stop();
  super.stop();
}

