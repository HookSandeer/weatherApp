JSONObject json;                                        // Création de la variable JSON avec la librairie, qui va permettre de sotcker le fichier Json
PImage[] images;                                   // Création d'un tableau qui va stocker les images

void setup() {
  size(400, 300);                                      // Définition de la taille de la fenêtre, ici 400px x 300px
  
  // CHARGEMENT DE L'API //
  
  String api = "http://api.openweathermap.org/data/2.5/weather?q=Dole,fr&lang=fr&APPID=782ff6636073c2db73402b57620d0505";    // Stockage de l'url de l'API Open Weather
  json = loadJSONObject(api);                          // Chargement du fichier Json dans la variable prévu pour
  
  // CHARGEMENT DES IMAGES : //
  
  File folder = new File(dataPath(""));               // Définition du dossier "data" comme contenant les immages
  File[] files = folder.listFiles();                  
  
  images = new PImage[files.length];

  for (int i = 0; i < files.length; i++) {
    if (files[i].isFile() && files[i].getName().endsWith(".png")) {
      images[i] = loadImage(files[i].getName());
    }
  }
}

void displayWeather() {
  String nomVille = json.getString("name");            // Récupération du nom de la ville
  JSONObject main = json.getJSONObject("main");
  // Récupération de la valeur de température, et conversion en Celsius
  float temperature = main.getFloat("temp") - 273.15;
  int pressure = main.getInt("pressure");

  String weatherDescription = json.getJSONArray("weather").getJSONObject(0).getString("description");
  

  // Afficher les informations dans la fenêtre
  fill(255);
  textSize(25);
  text("Météo à " + nomVille, 20, 30);
  textSize(15);
  text("Actuellement : " + weatherDescription, 20, 60);
  text("Température : " + nf(temperature, 0, 1) + " °C", 20, 90);
  text("Pression : " + pressure + " mbar", 20, 120);
  
   //if (weatherIcon != null) {
    //image(weatherIcon, 200, 90, 50, 50); // Position et taille de l'image
  //}
}

void draw() {
  background(0);                                       // Fond de la fenêtre en noir
  displayWeather();                                    // Affichage des informations
}
