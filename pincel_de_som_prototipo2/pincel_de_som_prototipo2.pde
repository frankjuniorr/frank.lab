import oscP5.*;
import netP5.*;

color BRANCO = #FFFFFF;
color RED = #FF0000;
color GREEN = #00FF00;
color BLUE = #0000FF;
color COR_PINCEL = #000000;
 
int circleX = 40;
int circle_red = 450;
int circle_green = 500;
int circle_blue = 550;
int circleSize = 40;   // Diameter of circle
 
 OscP5 oscP5;
 NetAddress myRemoteLocation;
 
void setup()
{
  size(800, 600);
  background(BRANCO);
  
  // start oscP5, telling it to listen for incoming messages at port 5001 */
  oscP5 = new OscP5(this,5001);
  // set the remote location to be the localhost on port 5001
  myRemoteLocation = new NetAddress("127.0.0.1",9001);
}
 
void draw(){
  update(mouseX, mouseY);
  desenha_circulos();
  strokeWeight(5);
  stroke(COR_PINCEL);
  if(mousePressed == true){
    if(mouseButton == RIGHT){  // botão direito do mouse é a borracha
        borracha();
    }else{
      line(mouseX, mouseY, pmouseX, pmouseY);
      
      // create an osc message
      OscMessage myMessage = new OscMessage("/test");
      
      // variaveis NAO USADAS POR ENQUANTO
      float amp = map( mouseY, 0, height, 0, 127 ); //variacoes pelo eixo Y
      float freq = map( mouseX, 0, width, 0, 127 ); //variacoes pelo eixo X
      
     
      myMessage.add(int(freq));
      myMessage.add(int(amp));
      oscP5.send(myMessage, myRemoteLocation);
    }    
  }
}

// limpa a tela
void borracha(){
  background(BRANCO);
  desenha_circulos(); 
}

// metodo para desenhar os circulos
void desenha_circulos(){
  strokeWeight(0);
  noStroke();
  fill(RED);
  ellipse(circleX, circle_red, circleSize, circleSize);
  fill(GREEN);
  ellipse(circleX, circle_green, circleSize, circleSize);
  fill(BLUE);
  ellipse(circleX, circle_blue, circleSize, circleSize);
}

// metodo que altera a cor do pincel, caso o click tenha sido feito nos circulos
void update(int x, int y) {
  if (overCircle(circleX, circle_red, circleSize) == true) {
    COR_PINCEL = RED;
  } else if (overCircle(circleX, circle_green, circleSize) == true) {
    COR_PINCEL = GREEN;
  } else if (overCircle(circleX, circle_blue, circleSize) == true) {
    COR_PINCEL = BLUE;
  }
}

// metodo mutherfucker que verifica se o click foi na area do circulo
boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if ((sqrt(sq(disX) + sq(disY)) < diameter/2) && mousePressed == true) {
    return true;
  } else {
    return false;
  }
}

