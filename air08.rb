#!/usr/bin/env ruby

#programme qui ajoute a une liste d'entiers triee un nouvel entier tout en gardant la liste triee dans l'ordre croissant, le dernier argument est l'element a ajouter, affiche error sinon

require 'bigdecimal'
require 'bigdecimal/util' #to_d

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

#fonction pour trouver un caractere dans un array, comme .index()
def trouverDansArray(array, carac)
        sortie = "ok"
        index = longueurArgument(array)
        i = 0
        while i < longueurArgument(array) && sortie == "ok"
                if array[i] == carac
                        sortie = "erreur"
                        index = i
                end
                i = i + 1
        end
        return index, sortie
end

#fonction utile qui test si l'argument (nombre suppose entier) contient . ou , avant conversion et calcul
def fauxFloatEntier()
        i = 0
        sortie = "ok"
        while ARGV[i] && sortie == "ok"
                if trouverDansArray(",", ARGV[i])[1] == "erreur" || (ARGV[i] != (ARGV[i].to_i).to_s && ARGV[i] != (ARGV[i].to_f).to_s)
                        sortie = "erreur"
                end
    		i = i + 1
        end
        return sortie
end

def checkSorted(array)
	sortie = "ok"
	for i in 1...longueurArgument(array)
		if array[i - 1] > array[i]
			sortie = "erreur"
		end
	end	
	return sortie
end

def sortedInsert(array, new)
	index = 0
	sortie = []
	for i in 0...longueurArgument(array) 
		if new <= array[i]
			break
		end
		index = i + 1
	end
	if index == 0
		sortie = [new, array]
	else	
		sortie = array[0,index]
		sortie = sortie.push(new)
		sortie = sortie + array[index,longueurArgument(array)-1]
		#array = array[0...index-1] + [new] + array[index...longueurArgument(array)-1]
	end
	return sortie
end

def arrayToString(array)
	sortie = ""
	for i in 0...longueurArgument(array)
		sortie = sortie + array[i] + " "
	end
	return sortie[0...-1]# + "f"
end

#coeur du programme
if nombreArgument <= 1 || fauxFloatEntier() == "erreur" || checkSorted(ARGV[0...-1].to_a) == "erreur"
	puts "error"
else
        array = ARGV[0...-1].to_a
	#puts ARGV[0...-1]
	#puts "test"
        puts arrayToString(sortedInsert(array, ARGV[nombreArgument - 1]))
end
