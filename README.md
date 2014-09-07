Distancier
==========

Création d'un distancier selon les indications de [Thimothée Geraud](http://rgeomatic.hypotheses.org/134) et [suite](http://rgeomatic.hypotheses.org/157)

Avec OpenStreetMap
===================

1. Télécharger les données source
---------------------------------

A partir de [Geofabrik](http://download.geofabrik.de/europe/france.html)on réupère les fichiers de l'Alsace et de la Lorraine (plus de 2 Go chaque une fois décompactés). Au passage on récupère également la version SHP pour une utilisation de cartographie (date de la récupération: 6/9/2014).

2. Merger les différents fichiers
---------------------------------

On utilise l'application [Osmosis]() pour cela:

- installer osmosis
- ouvrir une console et se placer dans le dossier cd ~/Documents/Resural/DISTANCIER

```{r}
cd ~/Documents/Resural/DISTANCIER

osmosis --rx lorraine-latest.osm --rx alsace-latest.osm --merge --wx alsace-lorraine.osm

ou

osmosis --rx file="lorraine-latest.osm" --rx file="alsace-latest.osm" --merge --wx file="alsace-lorraine.osm"

```
Le nombre de __merge--__ est égal au nombre de régions à merger - 1.

- rx pour read-xml
- wx pour write-xml
- INFOS: Total execution time: 103449 milliseconds.


3. Installer [Graphhopper]() pour le calcul des distances
---------------------------------------------------------

En mode console: 

```{}
git clone git://github.com/graphhopper/graphhopper.git

Clonage dans 'graphhopper'...
remote: Counting objects: 35547, done.
remote: Compressing objects: 100% (95/95), done.
remote: Total 35547 (delta 31), reused 15 (delta 4)
Réception d'objets: 100% (35547/35547), 30.53 MiB | 794.00 KiB/s, done.
Résolution des deltas: 100% (19842/19842), done.
Vérification de la connectivité... fait.
```

Installe un __dossier graphhopper__ dans le dossier _Distancier_.

Cette application indique par défaut les instructions routières de l’itinéraire (tourner à droite sur la rue Machin, rouler pendant 500m etc.). Avant d’intégrer un jeux de données OSM, nous avons désactivé cette fonctionnalité en dé-commentant la ligne 27 du fichier __config-example.properties__ à la racine du dossier graphhopper :

```{r}
osmreader.instructions=false
```

L’opération d’intégration de données dans l’appli peut nécessiter pas mal de mémoire vive, nous allons donc d’abord allouer plus de mémoire à JAVA. En fonction de notre configuration nous allons lui accorder 6 Go en lançant l’instruction suivante dans le terminal :

```{r}
export JAVA_OPTS="-Xmx6144M"
```

Après avoir placé le fichier __alsace-lorraine.osm__ à la racine du dossier _graphhopper_ nous pouvons ensuite intégrer le jeux de données de la manière suivante :

```{r}
cd graphhopper
./graphhopper.sh web alsace-lorraine.osm
```

Cette opération prend un temps non négligeable (25minutes). En réalité 10 mn sur la mienne. On obtient le dossier __alsace-lorraine-gh__ et le serveur se met en attente:

Nous avons maintenant a notre disposition une API de calcul d’itinéraire disponible en local.

Accès au client web : __http://localhost:8989__


4. Création de la matrice avec R
---------------------------------

L'API retourne un fichier [JSON](https://github.com/graphhopper/web-api/blob/master/docs-routing.md)

Ensemble des fichiers de [doc](https://github.com/graphhopper/web-api/find/master)

Api pour le [geocoding](https://github.com/graphhopper/web-api/blob/master/docs-geocode.md)

Il y a une erreur dans l'instruction de construction de la requête:
```{r}
http://localhost:8989/route?point= 
et non 
http://localhost:8989/api/route?point=
```