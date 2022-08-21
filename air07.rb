#!/usr/bin/env ruby

#programme qui supprime d'un tableau tous les elements qui ne contiennent pas une autre chaine de caracteres, affiche error sinon

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

#fonction pour trouver une chaine de caracteres dans une string, comme .index() ou find()
def trouverDansString(chaine, caracs)
        sortie = "false"
        lgchaine = longueurArgument(chaine)
	lgcaracs = longueurArgument(caracs)
        i = 0
        while i <= lgchaine - lgcaracs && sortie == "false"
                if chaine[i,lgcaracs] == caracs
                        sortie = "true"
                        index = i
                end
                i = i + 1
        end
        return index, sortie
end

def scanMatch(array, carac)
	arrayNew = ""
	for arr in 0...longueurArgument(array)
		if trouverDansString(array[arr], carac)[1] == "false"
			arrayNew = arrayNew + array[arr] + ", "
		end 
	end	
	return arrayNew[0...-2]
end

#coeur du programme
if nombreArgument <= 1
        puts "error"
else
	array = []
        for i in 0...longueurArgument(ARGV) - 1
                array.push(ARGV[i])
        end
        puts scanMatch(array, ARGV[longueurArgument(ARGV) - 1])
end
