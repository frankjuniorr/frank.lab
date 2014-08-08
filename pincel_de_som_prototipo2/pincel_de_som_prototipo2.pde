import oscP5.*;
import netP5.*;

color RED = #e82126;
color GREEN = #00b87f;
color BLUE = #3666de;
color YELLOW = #ffc048;
color BRANCO = #FFFFFF;
color COR_PINCEL = YELLOW;
 
int circleX = 40;
int circle_yellow = 400;
int circle_red = 450;
int circle_green = 500;
int circle_blue = 550;
int circleSize = 40;   // Diameter of circle

int ON = 50; // abaixo de 64, liga
int OFF = 70; // acima de 64, desliga
int efeito_amarelo = ON;
int efeito_vermelho = OFF;
int efeito_verde = OFF;
int efeito_azul = OFF;
String efeito = "amarelo";
 
OscP5 oscP5;
NetAddress myRemoteLocation;
 
void setup()
{
  size(800, 600);
  background(BRANCO);
  
  // start oscP5, telling it to listen for incoming messages at port 5001 */
  oscP5 = new OscP5(this,9001);
  // set the remote location to be the localhost on port 5001
  myRemoteLocation = new NetAddress("127.0.0.1",9001);
  
  efeitoOnOFF(efeito_amarelo, efeito_vermelho, efeito_verde, efeito_azul);
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
      
      float eixo_y = map( mouseY, 0, height, 0, 127 ); //variacoes pelo eixo Y
      float eixo_x = map( mouseX, 0, width, 0, 127 ); //variacoes pelo eixo X
     
      oscP5.send(new OscMessage("/"+efeito+"/mouseX").add(int(eixo_x)), myRemoteLocation);
      oscP5.send(new OscMessage("/"+efeito+"/mouseY").add(int(eixo_y)), myRemoteLocation);
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
  fill(YELLOW);
  ellipse(circleX, circle_yellow, circleSize, circleSize);
  fill(RED);
  ellipse(circleX, circle_red, circleSize, circleSize);
  fill(GREEN);
  ellipse(circleX, circle_green, circleSize, circleSize);
  fill(BLUE);
  ellipse(circleX, circle_blue, circleSize, circleSize);
}

// metodo que altera a cor do pincel, caso o click tenha sido feito nos circulos
void update(int x, int y) {
  if (overCircle(circleX, circle_yellow, circleSize) == true) {
    COR_PINCEL = YELLOW;
    efeito = "amarelo";
    efeito_amarelo = ON;
    efeito_vermelho = OFF;
    efeito_verde = OFF;
    efeito_azul = OFF;
    efeitoOnOFF(efeito_amarelo, efeito_vermelho, efeito_verde, efeito_azul);
  } else if (overCircle(circleX, circle_red, circleSize) == true) {
    COR_PINCEL = RED;
    efeito = "vermelho";
    efeito_amarelo = OFF;
    efeito_vermelho = ON;
    efeito_verde = OFF;
    efeito_azul = OFF;
    efeitoOnOFF(efeito_amarelo, efeito_vermelho, efeito_verde, efeito_azul);
  } else if (overCircle(circleX, circle_green, circleSize) == true) {
    COR_PINCEL = GREEN;
    efeito = "verde";
    efeito_amarelo = OFF;
    efeito_vermelho = OFF;
    efeito_verde = ON;
    efeito_azul = OFF;
    efeitoOnOFF(efeito_amarelo, efeito_vermelho, efeito_verde, efeito_azul);
  } else if (overCircle(circleX, circle_blue, circleSize) == true) {
    COR_PINCEL = BLUE;
    efeito = "azul";
    efeito_amarelo = OFF;
    efeito_vermelho = OFF;
    efeito_verde = OFF;
    efeito_azul = ON;
    efeitoOnOFF(efeito_amarelo, efeito_vermelho, efeito_verde, efeito_azul);
  }
}

void efeitoOnOFF(int efeito_amarelo, int efeito_vermelho, int efeito_verde, int efeito_azul){
    oscP5.send(new OscMessage("/amarelo").add(efeito_amarelo), myRemoteLocation);
    oscP5.send(new OscMessage("/vermelho").add(efeito_vermelho), myRemoteLocation);
    oscP5.send(new OscMessage("/verde").add(efeito_verde), myRemoteLocation);
    oscP5.send(new OscMessage("/azul").add(efeito_azul), myRemoteLocation);
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

