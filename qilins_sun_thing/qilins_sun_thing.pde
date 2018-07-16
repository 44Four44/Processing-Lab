class Planet{
  float objectRadius; //km
  float mass; //kg
  float periapsis; //m
  float apoapsis; //m
  float periapsisLongitude; //degrees
  float inclination; //degrees
  float centerMass; // kg

  PVector orbit; // (angle, magnitude of length from star)


  Planet(float tempobjectRadius, float tempMass, float tempPeriapsis, float tempApoapsis, float tempPeriapsisLongitude, float tempInclination, float tempCenterMass){
    objectRadius = tempobjectRadius;
    mass = tempMass;
    periapsis = tempPeriapsis;
    apoapsis = tempApoapsis;
    periapsisLongitude = tempPeriapsisLongitude;
    inclination = tempInclination;
    centerMass = tempCenterMass;
  }

  //Vital Planetary Facts
  float eccentricity(){
    return ((apoapsis-periapsis)/2)/(apoapsis+periapsis);
  }

  float semiMajor(){
    return (apoapsis+periapsis)/2;
  }

  float semiMinor(){
    return (semiMajor()*sqrt(1-pow(eccentricity(),2)));
  }

  float period(){
    return

      //Kepler's Third Law
      (2*PI*
        sqrt(
              (pow(semiMajor(),3) //Gives the semi-major axis
              /
              (6.674e-11*centerMass)) //Gives the Standard Gravitational Parameter of the System
            )
      );
  }

  float angle(){
    return
            ((timewarp * //Speeds everything up
               (timeticker/period()) // percentage of the period completed so it can be transformed into an angle
               - differenceAngle)
               % 360
            ); //Transforms a percentage into an angle
  }

  float altitude(float angle){
    //Using an adaptation of Kepler's Equation
    //r^3=(GM*T^2)/4pi^2
    //The bottom only works for circular orbits
    /*
    return (
      pow(
        (((6.674e-11*centerMass)  //Standard Gravitational Parameter
          *
          pow(period(),2)) //Period Squared
        /
        (4*pow(PI,2))) //4pi^2
        ,
       0.3333) //Cube Rooted
    );*/

    //Using trigonometry with polar coordinates
    // To prove this, first start with the cartesian equation of ellipse
    // x^2/a^2 + y^2/b^2 = 1
    // x^2 * b^2 + y^2 * a^2 = a^2 & b^2
    // Replace x = r cos(θ) and y = r sin(θ) to move it into the polar coordinates
    // r = ab/sqrt(a^2 * sin^2(θ) + b^2 * cos^2(θ))
    return(
        (periapsis*apoapsis)
        /
        sqrt(
          pow(apoapsis,2)*pow(cos(radians(angle)),2)+pow(periapsis,2)*pow(sin(radians(angle)),2)
        )
      );
  }

  float angularvelocity(){
    //Vis-Viva Equation
    //sqrt(μ*[(2/r)-(1/a)])
    return (
      sqrt(
        (6.674e-11*centerMass) // standard gravitational Parameter
        *
        (
          (2/altitude(angle())) // 2/r
          -
          (1/(semiMajor())) // 1/a
        )
      )
      );
  }

  void periapsisLine(){
    pushMatrix();
    translate(              (cos(radians(periapsisLongitude))*(apoapsis-periapsis)/2)/orbitRadiusScaler,
              (sin(radians(periapsisLongitude))*(apoapsis-periapsis)/2)/orbitRadiusScaler);
    //fill(0);
    //ellipse(0,0,100,100);
    //noFill();
    line(0,0,(cos(radians(periapsisLongitude-90))*semiMinor())/orbitRadiusScaler,(sin(radians(periapsisLongitude-90))*semiMajor())/orbitRadiusScaler);
    popMatrix();
  }


  //Plotting Things Out
  void plotPlanet(){
    fill(153,50,204); //pinkish color

    pushMatrix(); //Begin transformation
    rotateZ(radians(periapsisLongitude)); //Matches its longitude of periapsis
    rotateX(radians(inclination)); //Matches its orbital inclination

    //Transforms the planet according to the current angle and its orbital properties
    translate(
               cos(radians(angle())-radians(periapsisLongitude))* //x-angle of planet with respect to center body
               ((semiMinor())/orbitRadiusScaler) //length magnitude of sateliite with respect to center body
               + (cos(radians(periapsisLongitude))*((apoapsis-periapsis)/2))/orbitRadiusScaler //Adjustment from foci
               ,
               sin(radians(angle())-radians(periapsisLongitude))* //y-angle of planet with respect to center body
               ((semiMajor())/orbitRadiusScaler) //Length magnitude of planet with respect to center body
               + (sin(radians(periapsisLongitude))*((apoapsis-periapsis)/2))/orbitRadiusScaler //Adjustment from foci
             );

    //stroke(0); //Gives the stroke color of the sphere details
    noStroke();
    sphereDetail(20);
    sphere(objectRadius/planetSizeScaler); //Actual planet itself
    stroke(1);
    popMatrix(); //Ends transformation
  }

  void plotOrbit(){
    stroke(255); //color of the orbit line
    noFill(); //ensures the ellipse is transparent
    strokeWeight(100*exp((3*zoom)-1.5)+0.25); //calculated with a table of values at www.desmos.com/calculator/fz1zzieuwa

    pushMatrix(); //Begin transformation

    rotateZ(radians(periapsisLongitude)); //Matches its longitude of periapsis
    rotateX(radians(inclination)); //Matches its orbital inclination
    //periapsisLine();


    //The actual orbit
    translate(    (cos(radians(periapsisLongitude))*((apoapsis-periapsis)/2))/orbitRadiusScaler,
                  (sin(radians(periapsisLongitude))*((apoapsis-periapsis)/2))/orbitRadiusScaler);

    ellipse(
              0,0,
              (semiMinor()*2)/orbitRadiusScaler,
              (semiMajor()*2)/orbitRadiusScaler
           );

    popMatrix(); //End transformation
    strokeWeight(1);
  }

  //Debugging
  void displayFacts(){
    println(angle(),altitude(angle()));
    //line(0,0,(cos(radians(180+periapsisLongitude))*periapsis)/orbitRadiusScaler,(sin(radians(180+periapsisLongitude))*periapsis)/orbitRadiusScaler);
  }


  //Time Warp
  float differenceAngle = 0;
  float savedAngle;
  float timewarp = 100000;

  void changeTimeWarp(){
    //println("works");
    savedAngle = angle();

    if(key == '.'){
      timewarp = timewarp * 1.2;
    }
    if(key == ','){
      timewarp = timewarp / 1.2;
    }

    differenceAngle = differenceAngle + angle() - savedAngle;


  }

}

Planet Mercury;
Planet Venus;
Planet Earth;
Planet Mars;
Planet Jupiter;
Planet Saturn;
Planet Uranus;
Planet Neptune;
Planet Halley;

Star sun;

void setup(){
  background(30);
  frameRate(100);

  sun = new Star(695700,1.989E30,213,182,10);

  //plamet radius (km), mass (kg),periapsis (m), apoapsis (m), longitude of peripasis,orbital inclination
  Mercury = new Planet(2440,0.33011E24,4.6E10,6.982E10,77.46,7,sun.mass);
  Venus = new Planet(6052,4.8675E24,1.0748E11,1.0894E11,131.533,3.3947,sun.mass);
  Earth = new Planet(6357,5.972E24,1.471E11,1.521E11,102.9,0,sun.mass);
  Mars = new Planet(3390,6.39E23,2.066E11,2.492E11,336,1.85,sun.mass);
  Jupiter = new Planet(69911,1.898E27,7.4052E11,8.1662E11,14.75,1.304,sun.mass);
  Saturn = new Planet(60268,5.6834E26,1.35255E12,1.5145E12,92.43194,2.48446,sun.mass);
  Uranus = new Planet(25559,8.6813E25,2.7413E12,3.00362E12,170.96,0.76986,sun.mass);
  Neptune = new Planet(24764,1.02413E26,4.44445E12,4.54567E12,44.9713,1.76917,sun.mass);
  Halley = new Planet(6,2.2E14,8.766E10,5.2481925E12,111.33,1,sun.mass);
}

void settings(){
  size(1500,1500,P3D);}



//Settings to adjust the dimension of the planets
int timeticker = 0;
int orbitRadiusScaler = 600000000;
int planetSizeScaler = 400;


//0=homescreen, 1=solarSystem, 2=planetSystem
int mode = 1;

void draw(){
  scale(0.5);
  //time ticker (100 fps)
  timeticker++; //global increment that increases each frame
  background(30);

  switch(mode){
    //case 0: homescreen(); break;
    case 1: solarSystem(); break;
    //case 2: planetsystem(); break;
  }
  fill(255);
  //ellipse(width/2,height/2,200,500);
  //ellipse(width/2,height/2,500,200);

}

void solarSystem(){
  sphereDetail(10);
  //pointLight(213,182,10, width/2, height/2, 0);

  pushMatrix(); //Begin Transformation
  translate(width/2,height/2); //Sets the center to the middle of the screen
  scale(zoom);

  enableRotation();

  //Planet Orbit Lines
  Mercury.plotOrbit();
  Venus.plotOrbit();
  Earth.plotOrbit();
  Mars.plotOrbit();
  Jupiter.plotOrbit();
  Saturn.plotOrbit();
  Uranus.plotOrbit();
  Neptune.plotOrbit();
  Halley.plotOrbit();

  //Star
  sun.plotBody();

  //Plane of Reference
  //noStroke();
  //ellipse(0,0,147,147);
  //stroke(200);
  //strokeWeight(1);

  //Planets
  Mercury.plotPlanet();
  Venus.plotPlanet();
  Earth.plotPlanet();
  Mars.plotPlanet();
  Jupiter.plotPlanet();
  Saturn.plotPlanet();
  Uranus.plotPlanet();
  Neptune.plotPlanet();
  Halley.plotPlanet();

  popMatrix(); //End Transformation. Anything put beyond this line will not be affected by rotation
}


boolean noClick = true; //The mouse is not being clicked down
float[] savedPositions = {0,0,0,0}; //{x-position,y-position,x-angle,y-angle}

//Function that allows everything to be rotated
void enableRotation(){
  //Conditions:
    //A translate function setting the origin to 500,500
    //Must be wrapped in pushMatrix() and popMatrix()

  if(mousePressed){

    //Since there are no booleans that differentiates between mouseClicked and mousePressed, here is a workaround with the global variable noClick
    if(noClick){ //Checks if the mouse is clicking (and not being held down)
      noClick = false; //the mouse is no longer clicking, it's being held down

      //Gives reference point to original position of mouse
      savedPositions[0] = mouseX;
      savedPositions[1] = -mouseY;
    }

    //Rotates EVERYTHING around the x and y axis by the current x and y position of the mouse
    rotateY(savedPositions[2]+radians((mouseX-savedPositions[0])/10.8)); //the 10.8 ensures it takes longer to rotate along y-axis
    rotateX(savedPositions[3]+radians((-mouseY-savedPositions[1])/5.4)); //the 5.4 ensures it's easier to rotate along x-axis to see orbital inclination

  } else{

    //Rotates EVERYTHING according to the last saved angle
    rotateY(savedPositions[2]);
    rotateX(savedPositions[3]);
  }
}

void mouseReleased(){
  //Saves positions when rotation is enabled
  if(noClick == false){ //Ensures this will only be called after rotation
    savedPositions[2] = savedPositions[2]+radians((mouseX-savedPositions[0])/10.8);
    savedPositions[3] = savedPositions[3]+radians((-mouseY-savedPositions[1])/5.4);

    noClick = true;
  }
}

float zoom = -1;
float isScroll;
void mouseWheel(MouseEvent event) {
  if(mode==1){
    isScroll = event.getCount();
    zoom = zoom + (isScroll/20);
    if(zoom>0){
      zoom = zoom - (isScroll/20);
    }
    //println(zoom);
  }
}
void keyPressed(){
  Mercury.changeTimeWarp();
  Venus.changeTimeWarp();
  Earth.changeTimeWarp();
  Mars.changeTimeWarp();
  Jupiter.changeTimeWarp();
  Saturn.changeTimeWarp();
  Uranus.changeTimeWarp();
  Neptune.changeTimeWarp();
  Halley.changeTimeWarp();
}

class Star{
  float objectRadius; //km
  float mass; //kg
  float objectColorR;
  float objectColorG;
  float objectColorB;

  Star(int tempObjectRadius, float tempMass, int tempObjectColorR, int tempObjectColorG, int tempObjectColorB){
    objectRadius = tempObjectRadius;
    mass = tempMass;
    objectColorR = tempObjectColorR;
    objectColorG = tempObjectColorG;
    objectColorB = tempObjectColorB;
  }

  void plotBody(){
    fill(objectColorR,objectColorG,objectColorB);
    sphere(objectRadius/15000);
  }
}