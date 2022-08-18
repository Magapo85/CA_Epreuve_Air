#!/usr/bin/env ruby

#programme qui decoupe une chaine de caracteres en tableau (separateurs : espaces, tabulations, retours a la ligne) Afficher error

#fonction utile qui trouve le nombre d'argument comme .length()
def nombreArgument
        i = 0
        while ARGV[i]
                i += 1
        end
        return i
end

#fonction utile qui mesure la longueur d'une array ou string comme .length()
def longueurArgument(mot)
        i = 0
        while mot[i]
                i += 1
        end
        return i
end

def maFonctionSeparatrice (chaine, separateur)
	debut = 0
	fin = 0
	tableau = []
	sep = -1
	for caracChaine in 0...longueurArgument(chaine)
		sep = 0
		for caracSep in 0...longueurArgument(separateur)
			if chaine[caracChaine] == separateur[caracSep]
				sep = 1 
				break
			end
		end
		if caracChaine == longueurArgument(chaine) - 1 || sep == 1
			fin = caracChaine + 1
			tableau.push(chaine[debut...fin])
			debut = fin
		end
	end
	return tableau
end

#coeur du programme
if nombreArgument != 1
	puts "error"
else
	puts maFonctionSeparatrice(ARGV[0], [' ','         ','\n'])
end
