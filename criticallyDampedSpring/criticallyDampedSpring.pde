float pos;
float vel;
float mass;
float target;
float springK;

PImage eq;

final int LOG_N = 1200;
float[] posLog = new float[ LOG_N ];
float[] targetLog = new float[ LOG_N ];
float[] targets = { -0.5, 0.5, -0.2, 0.2, -1.0, 1.0 };

void setup() {
  size( 512, 512 );
  textFont( createFont( "WtPositionMono-Regular", 10 ) );
  textAlign( CENTER, CENTER );
  strokeJoin( ROUND );
  noStroke();
  imageMode( CENTER );
  
  pos = 0.0;
  vel = 0.0;
  mass = 1.0;
  springK = 15.0;
  target = 0.0;
  
  eq = loadImage( "eq.png" );
}

void draw() {
  target = targets[ frameCount / 50 % 6 ];
  
  //float zeta = 1.0;
  //float dampC = 2.0 * sqrt( mass * springK ) * zeta;
  //float forceS = springK * ( target - pos );
  //float forceD = dampC * -vel;
  //float acc = ( forceS + forceD ) / mass;
  float deltaTime = 1.0 / 50.0;
  float acc = -springK * ( pos - target ) - 2.0 * vel * sqrt( springK );
  vel += acc * deltaTime;
  pos += vel * deltaTime;
  
  for ( int i = LOG_N - 2; 0 <= i; i -- ) {
    posLog[ i + 1 ] = posLog[ i ];
    targetLog[ i + 1 ] = targetLog[ i ];
  }
  posLog[ 0 ] = pos;
  targetLog[ 0 ] = target;
  
  // ------
  
  background( 255 );
  
  pushMatrix();
  translate( 128, 80 );
  
  fill( 230 );
  rect( -16, 0, 256 + 32, 32 );
  rect( -16, 40, 256 + 32, 32 );
  
  fill( 180 );
  rect( target * 128 + 128 - 16, 0, 32, 32 );
  fill( 0, 100 );
  textSize( 20 );
  text( target, 128, 16 );
  
  fill( 255, 157, 0 );
  rect( pos * 128 + 128 - 16, 40, 32, 32 );
  fill( 0, 100 );
  textSize( 20 );
  text( pos, 128, 40 + 16 );
  
  popMatrix();
  
  pushMatrix();
  translate( 128, 176 );
  
  for ( int i = 0; i < 16; i ++ ) {
    int f = 10;
    float p1 = posLog[ i * f ];
    float p2 = posLog[ i * f + f ];
    float pt = targetLog[ i * f ];
    
    int y = i * 16;
    
    fill( 230 );
    rect( -16, y, 256 + 32, 8 );
    
    fill( 180 );
    rect( p2 * 128 + 128, y, ( pt - p2 ) * 128, 8 );
    
    fill( 255, 157, 0 );
    rect( p1 * 128 + 128, y, ( p2 - p1 ) * 128, 8 );
    
    fill( 0 );
    textSize( 10 );
    text( p1 - p2, 128 + 168, y + 3 );
    text( p1, 128 - 168, y + 3 );
    
    //fill( 0 );
    //rect( pt * 128 + 256 - 1, y, 2, 8 );
  }
  
  popMatrix();
  
  //if ( frameCount == 600 ) { exit(); }
  //saveFrame( "capture/####.png" );
}