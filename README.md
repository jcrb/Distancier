Distancier
==========

Création d'un distancier selon les indications de [Thimothée Geraud](http://rgeomatic.hypotheses.org/134) et [suite](http://rgeomatic.hypotheses.org/157)

Avec OpenStreetMap
===================

1. Télécharger les données source
---------------------------------

A partir de [Geofabrik](http://download.geofabrik.de/europe/france.html)on réupère les fichiers de l'Alsace et de la Lorraine (plus de 2 Go chaque une fois décompactés). Au passage on récupère également la version SHP pour une utilisation de cartographie (date de la récupération: 6/9/2014).
Le fichier compacté à récupérer est __alsace-latest.osm.bz2__

2. Merger les différents fichiers
---------------------------------

On utilise l'application [Osmosis](http://wiki.openstreetmap.org/wiki/FR:Osmosis) pour cela:

- installer osmosis. Le dossier Osmosis est téléchargé et installé (par moi) dans le dossier Application. Le binaire actif est osmosis/bin/osmosis. 
- intaller un [JDK sur Mac](http://www.oracle.com/technetwork/java/javase/downloads/index.html), sinon Osmosis plante. Le 2/7/2016 j'installe a version __Mac OS X	227.29 MB  	jdk-8u91-macosx-x64.dmg__.
- ouvrir une console et se placer dans le dossier cd ~/Documents/Resural/DISTANCIER

```{r}
cd ~/Documents/Resural/DISTANCIER

# osmosis --rx lorraine-latest.osm --rx alsace-latest.osm --merge --wx alsace-lorraine.osm # old

~/Documents/Resural/DISTANCIER » /Applications/osmosis/bin/osmosis --rx lorraine-latest.osm --rx alsace-latest.osm --rx champagne-ardenne-latest.osm --merge  --merge --wx RGE2016.osm

```
Le nombre de __merge--__ est égal au nombre de régions à merger - 1. La fusion des 3 régions pour créer RGE2016.osm demande Total execution time: 203737 milliseconds ou 204 secondes (3,4 mn) sur mac.

- rx pour read-xml
- wx pour write-xml
- INFOS: Total execution time: 103449 milliseconds.


3. Installer [Graphhopper]() pour le calcul des distances
---------------------------------------------------------

En mode console: 

On sauvegarde l'ancienne version sous le nom de graphhopper_old, puis:

```
git clone git://github.com/graphhopper/graphhopper.git

Cloning into 'graphhopper'...
remote: Counting objects: 48341, done.
remote: Compressing objects: 100% (34/34), done.
remote: Total 48341 (delta 7), reused 0 (delta 0), pack-reused 48298
Receiving objects: 100% (48341/48341), 36.65 MiB | 295.00 KiB/s, done.
Resolving deltas: 100% (27066/27066), done.
Checking connectivity... done.
```

Installe un __dossier graphhopper__ dans le dossier _Distancier_.

Cette application indique par défaut les instructions routières de l’itinéraire (tourner à droite sur la rue Machin, rouler pendant 500m etc.). Avant d’intégrer un jeux de données OSM, nous avons désactivé cette fonctionnalité en dé-commentant la ligne 71 du fichier __config-example.properties__ à la racine du dossier graphhopper :

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
Au départ, le programme plante avec le message: _Error: JAVA_HOME is not defined correctly_. Une [page](https://github.com/graphhopper/graphhopper-ios/blob/master/graphhopper-ios-sample/README.md) indique pour cette erreur qu'il faut installer Maven avec l'instruction _brew install maven_. Après le programme s'exécute.

Cette opération prend un temps non négligeable (25minutes). En réalité 10 mn sur la mienne. On obtient le dossier __RGE2016-gh__ et le serveur se met en attente:

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

5. Utiisation pratique
-----------------------

1. se placer dans le répertoire de graphhoper   
2. lancer le serveur  

```{}
cd ~/Documents/Resural/DISTANCIER/graphhopper
./graphhopper.sh web alsace-lorraine.osm
```

3. lancer le programme demo.rmd

Autre utilisations de Osmosis
=============================

Hôpitaux du Grand Est
---------------------
A partir du fichier RGE2016.osm on peut extraire les neouds comportant le tag __amenity=hospital__. On obtient de fichier __RGE2016_Hospital.osm__ qui est du te XML.

```{}
~/Documents/Resural/DISTANCIER » /Applications/osmosis/bin/osmosis --read-xml RGE2016.osm --tf reject-ways --tf reject-relations --tag-filter accept-nodes amenity=hospital --write-xml RGE2016_Hospital.osm
```
