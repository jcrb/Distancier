
# fonction de parsage des réponses 
decode.temps<-function(x){
    if (class(x)=="character"){
        # décodage du résultat de la requête
        if (length(fromJSON(x)$paths[[1]]>0)){
            fromJSON(x)$paths[[1]][1] # pour le temps
            # fromJSON(x)$paths[[1]][2] # pour la distance (mètres)
        } else {
            NA
        }
    } else {
        NA
    }
}

# fonction de parsage des réponses 
decode.distance<-function(x){
    if (class(x)=="character"){
        # décodage du résultat de la requête
        if (length(fromJSON(x)$paths[[1]]>0)){
            fromJSON(x)$paths[[1]][2] # pour la distance (mètres)
        } else {
            NA
        }
    } else {
        NA
    }
}