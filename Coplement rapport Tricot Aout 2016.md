Commentaires UNV & USIC
=======================

En complément du rapport de Claire Tricot (2/8/2016).

Dans le cadre du réseau j'avais calculé un distancier de l'ensemble des communes d'Alsace à l'UNV la plus proche. Mon lieu de villégiature actuel (!) ne me permet pas d'accéder à mes outils usuels de travail, aussi ce que je vous adresse est un document de travail que j'améliorerai dès que possible.

Le travail de départ concerne les UNV mais dans un premier temps il est assez facile de l'étendre aux USIC dans la mesure où USIC et UNV siègent dans les mêmes villes (sauf le cas particulier et temporaire (?) de Haguenau où l'USIC totalement fonctionelle.

Les coordonées géographiques exactes des UNV d'Alsace, de Lorraine, Vosges et territoire de Belfort ont été répertoriées (malheureusement pas de base nationale accessible). Pour les communes c'est le centroÏde géographique qui a été utilisé (voir annexe technique).

A partir de ces informations le distancier est calculé sous forme de temps en minutes séparant une commune de chacune des UNV répertoriées, ce qui permet de sélectionner la plus intéressante ou les suivantes si l'UNV de référence n'est pas disponible.

Je vous transfère deux documents de travail:

__usic_et_unv.pdf__:

ce sont mes notes de travail et essais divers. La partie intéressante est la dernière page où vous trouverez une cartogaphie de ce que cela donne. Les points intéressants sont les zones auxquelles on ne pense pas car le raisonnement du régulateur est bridé par un schéma administratif (généralement le département ou la région Alsace):
- la zone bleue: toutes ces communes sont plus proches de l'UNV de FORBACH
- la zone violette crorrespond à la situation actuelle du secteur  1-2: UNV HTP
- la zone verte sont les communes (y compris du 67) relevant de l'UNV COLMAR
- la zone bleue sont les communes relevant de l'UNV MULHOUSE
- la zone rouge sont les communes du 68 plus proches de l'UNV BELFORT

_Cette carte à une visée pédagogique mais n'est pas opérationelle. Sera mise à jour (notamment la légende dès que possible)_.


__distancier_unv_alsace_meilleur_choix.csv__:

C'est un fichier plus opérationnel au format _CSV (séparateur = virgule, format = UTF8)_.
Il comporte en ligne la liste des communes d'Alsace et en colonne la distance en minutes (les chiffres sernt arrondis dans la prochaine version...) vers les UNV de la grande région (sauf CA). Les 3 dernières colonnes correspondent au meilleur choix:
- choix 1 : distance la plus courte. Choix idéal. Cette colonne suppose que l'UNV HAGUENAU est opérationnelle
- choix 2 : idem mais avec UNV Haguenau NON OPERATIONELLE. Correspond à la situation actuelle.
- choix 3 : deuxième choix si le choix 1 ou 2 n'est pas possible.

Annexe technique
================

Le distancier est calculé uniquement à partir de données libres (OpenStreetMap, données libre IGN, language R).

Les coordonnées des communes proviennent des données en data acces de l'IGN. Il s'agit des coordonnées du centre de la commune calculé par l'IGN).  Le format cartographique de l'IGN (officiel) est la projection Lambert93 (utilisation de la version Shapefile). La plupart des autres données utilisent le format cartographique WSG84 (OSM, Google map par ex.). Les calculs nécessitent une transformation de toutes les coordonnées en l'espèce au format WSG84. Cette transformation est réalisée par le système de conversion du language R.

Le distancier calcule le délai en minutes pour le trajet par voie routière le plus rapide dans des conditions idéales de circulation. La vitesse moyenne de transport moyenne d'une ambulance est assimilable à celui d'un véhicule normal, le gain (?) de temps apporté par les dispositifs prioritaires sont perdus par les délais de prise en charge et d'admission.