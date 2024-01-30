// Code by Antonin MICHON
// https://github.com/HookSandeer

JSONObject json;   // Création de la variable json avec la librairie, qui va permettre de sotcker le fichier Json
PImage icon;       // Création de la variable icon qui va stocker l'icon à afficher

void setup() {
  size(400, 300);   // Définition de la taille de la fenêtre, ici 400px x 300px
  
  // CHARGEMENT DE L'API //
  String api = "http://api.openweathermap.org/data/2.5/weather?q=Dole,fr&lang=fr&APPID=782ff6636073c2db73402b57620d0505";    // Stockage de l'url de l'API Open Weather, avec ma clé d'API
  json = loadJSONObject(api);                          // Chargement du fichier Json dans la variable prévu pour
  
  // CHARGEMENT DE L'ICON : //
  String iconID = json.getJSONArray("weather").getJSONObject(0).getString("icon");    // Récupération de l'identifiant de l'icon qu'il faudra afficher
  String iconFile = iconID + ".png";     // Création du nom de fichier de l'image qui sera affiché
  icon = loadImage(iconFile);            // Chargement de la bonne image dans le programme
}

// Fonction qui va récupérer puis afficher dans une fenêtre toute les informations nécessaire
void displayWeather() {
  String cityName = json.getString("name");              // Récupération du nom de la ville
  JSONObject main = json.getJSONObject("main");          // Récupération de l'objet main du fichier json, qui contient la témprature ainsi que la pression
  float temperature = main.getFloat("temp") - 273.15;    // Récupération de la valeur de température à partir de main, et conversion en Celsius
  int pressure = main.getInt("pressure");                // Récupération de la valeur de la pression à partir de main
  // Récupération de la description contenu dans l'objet 0 lui même contenu dans la liste d'objet weather
  String weatherDescription = json.getJSONArray("weather").getJSONObject(0).getString("description");

  // Afficher les informations dans la fenêtre
  fill(255);                                                          // Couleur du texte en blanc
  textSize(25);                                                       // Taille du texte à 25 px
  text("Météo à " + cityName, 40, 30);                                // Nom de la ville à la position x=40, y=30
  textSize(20);                                                       // Taille du texte à 20 px 
  text("Actuellement : " + weatherDescription, 40, 80);               // Description de la météo à la position x=40, y=80
  image(icon, 300, 50);                                               // Affichage de la bonne icône à la postion x=300, y=50
  text("Température : " + temperature + " °C", 40, 140);              // Affichage de la température à la position x=40, y=140
  text("Pression : " + pressure + " mbar", 40, 190);                  // Affichage de la pression à la position x=40, y=190
}

void draw() {
  background(0);                                       // Fond de la fenêtre en noir
  displayWeather();                                    // Affichage des informations avec la fonction displayWeather
}