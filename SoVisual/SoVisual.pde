import ddf.minim.*;
PImage Hexagon;
float rot = 0;
int sqx = 0;
int sqy = 0;
float[] SQXs = new float [50];
float[] SQYs = new float [50];
String[] idekwhat = new String [5];

Minim minim;
AudioPlayer soundofwhatever;

void setup()
{
  size(600, 600, P3D);
  minim = new Minim(this);
  soundofwhatever = minim.loadFile("Wir Fliegen.mp3");
  imageMode(CENTER);
  Hexagon = loadImage("OrangeHex.png");
  for(int i=0; i < 50; i++)
   {
   SQXs[i] = random(width);
   SQYs[i] = random(height);
   }
}

void draw()
{
  background(0,255,0);
  stroke(235,0,235);
  for(int i = 0; i < soundofwhatever.bufferSize() - 1; i++)
  {
    float x1 = map( i, 0, soundofwhatever.bufferSize(), 0, width );
    float x2 = map( i+1, 0, soundofwhatever.bufferSize(), 0, width );
    line( x1, 100 + soundofwhatever.left.get(i)*50, x2, 100 + soundofwhatever.left.get(i+1)*70 );
    line( x1, 500 + soundofwhatever.right.get(i)*50, x2, 500 + soundofwhatever.right.get(i+1)*70 );
  }
  float posx = map(soundofwhatever.position(), 0, soundofwhatever.length(), 0, width);
  stroke(0,255,255);
  line(posx, 0, posx, height);
  
  if ( soundofwhatever.isPlaying() )
  {
    text("Press whatever to pause playback.", 10, 580 );
    pushMatrix();
    translate(300,300);
    rotate(rot); 
    image(Hexagon, 0, 0, 150, 132);
    popMatrix();
    
    rot+=PI/25;
    
    for(int i=0; i < 50; i++)
    {
      rect(SQXs[i], SQYs[i], 20, 20);
      SQXs[i] +=20;
     if(SQXs[i] > width)
     {
       SQXs[i] = 0;
       SQYs[i] = random(height);
     }
    }
  }
  else
  {
    text("Press whatever to start playback.", 10, 20 );
    image(Hexagon, 300, 300, 150, 132);
    for(int i=0; i < 50; i++)
    {
      SQXs[i]+=0;
    }
  }
}


void keyPressed()
{
  if ( soundofwhatever.isPlaying() )
  {
    soundofwhatever.pause();
  }
  else if ( soundofwhatever.position() == soundofwhatever.length() )
  {
    soundofwhatever.rewind();
    soundofwhatever.play();
  }
  else
  {
    soundofwhatever.play();
  }
}