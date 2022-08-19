#!/usr/bin/env ruby

#programme qui decoupe une chaine de caracteres en tableau avec le separateur en 2ieme argument
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
	lgChaine = longueurArgument(chaine)
	lgSep = longueurArgument(separateur)
        for caracChaine in 0...lgChaine - lgSep + 1
                sep = 0
                if chaine[caracChaine,lgSep] == separateur
                	sep = 1
                end
                if caracChaine == lgChaine - lgSep - 1 || sep == 1
			if sep == 1
                        	fin = caracChaine
			else
				fin = lgChaine
			end
                        tableau.push(chaine[debut...fin])
                        debut = fin + lgSep
                end
        end
        return tableau
end

#coeur du programme
if nombreArgument != 2
        puts "error"
else
        puts maFonctionSeparatrice(ARGV[0], ARGV[1])
end

