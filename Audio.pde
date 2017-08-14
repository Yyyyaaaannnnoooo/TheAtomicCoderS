import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
Minim minim;
Minim backGround;
AudioOutput out;
AudioPlayer BG;
class Audio {
  Audio() {
    minim = new Minim(this);
    out = minim.getLineOut();
  }

  void playNotes(int note) {
    out.setTempo( 180 );
    out.pauseNotes();
    float amp = 0.3;
    float duration = 0.2;
    if (note == 1) {
      out.playNote( 0.0, duration, new CrushInstrument(27.5, amp, 4.0));
      out.playNote( 0.2, duration, new CrushInstrument(275, amp, 4.0));
      out.playNote( 0.4, duration, new CrushInstrument(55, amp, 4.0));
      //out.playNote( 0.0, duration, 27.5);//new CrushInstrument(27.5, amp, 12.0));
      //out.playNote( 0.5, duration, 275);// new CrushInstrument(275, amp, 2.0));
      //out.playNote( 0.1, duration, 55);//new CrushInstrument(55, amp, 12.0));
    }
    //middle octave
    if (note == 2) {
      out.playNote( 0.0, duration, new CrushInstrument(220, 0.5, 2.0));
      out.playNote( 0.2, duration, new CrushInstrument(165, 0.5, 2.0));
      out.playNote( 0.4, duration, new CrushInstrument(110, 0.5, 2.0));
    }
    //high octave
    if (note == 3)out.playNote( 0.0, duration, new CrushInstrument(880, 0.5, 1.0) );
    out.setNoteOffset( 0.1 );
    out.resumeNotes();
  }
}

// this CrushInstrument will play a sine wave bit crushed
// to a certain bit resolution. this results in the audio sounding
// "crunchier".
class CrushInstrument implements Instrument {
  Oscil sineOsc;
  BitCrush bitCrush;

  CrushInstrument(float frequency, float amplitude, float bitRes) {
    sineOsc = new Oscil(frequency, amplitude, Waves.SINE);

    // BitCrush takes the bit resolution for an argument
    bitCrush = new BitCrush(bitRes, out.sampleRate());

    sineOsc.patch(bitCrush);
  }

  // every instrument must have a noteOn( float ) method
  void noteOn(float dur) {
    bitCrush.patch(out);
  }

  // every instrument must have a noteOff() method
  void noteOff() {
    bitCrush.unpatch(out);
  }
}