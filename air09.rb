#!/usr/bin/env ruby

#programme qui fusionne deux listes d'entiers triee en les gardant triees,les deux listes seront separees par un argument "fusion", affiche error sinon
#https://www.jdoodle.com/execute-ruby-online/

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
def trouverDansArray(carac, array)
        sortie = "ok"
        index = longueurArgument(array)
        i = 0
        while array[i] && sortie == "ok"
                if array[i] == carac
                        sortie = "erreur"
                        index = i
                end
                i = i + 1
        end
        return index, sortie
end

#fonction utile qui test si l'argument (nombre suppose entier) contient . ou , avant conversion et calcul
def fauxFloatEntier(array)
        i = 0
        sortie = "ok"
        while array[i]
                if trouverDansArray(",", array[i])[1] == "erreur" || (array[i] != (array[i].to_i).to_s && array[i] != (array[i].to_f).to_s)
                        sortie = "erreur"
                end
    		i = i + 1
        end
        return sortie
end

def checkSorted(array)
	sortie = "ok"
	for i in 1...longueurArgument(array)
		if array[i-1].to_d > array[i].to_d
			sortie = "erreur"
			break
		end
	end	
	return sortie
end

def sortedFusion(array1, array2)
	sortie = array1
	sortietemp = array1
	b = 0
	for b in 0...longueurArgument(array2)
		index = -1
		i = 0
		new = array2[b]
		for i in 0...longueurArgument(sortie) 
			if new.to_d < sortie[i].to_d
				index = i
				break
			end
		end
		if index == 0
			sortie = [new, sortie]
		elsif index == - 1
			sortie = sortie.push(new)
		else	
			sortietemp = sortie
			sortie = sortie[0...index]
			sortie = sortie.push(new)
			sortie = sortie + sortietemp[index...longueurArgument(sortietemp)]
		end
	end
	return sortie
end

def arrayToString(array)
	sortie = ""
	for i in 0...longueurArgument(array)
		sortie = sortie + array[i] + " "
	end
	return sortie[0...-1]
end

def checkFusionStructure
	para = "erreur"
	index = -1
	sortie = "ok"
	for arr in 0...nombreArgument
		if ARGV[arr] == "fusion"
			para = "ok"
			index = arr
			break
		end
	end
	if index+1 == nombreArgument
		para = "erreur"
	end
	if para == "ok" && fauxFloatEntier(ARGV[0...index]) == "ok" && fauxFloatEntier(ARGV[index+1...nombreArgument]) == "ok"
		if checkSorted(ARGV[0...index]) == "erreur" || checkSorted(ARGV[index+1...nombreArgument]) == "erreur"
			sortie = "erreur"
		else 
			sortie = "ok"
		end
	else
		sortie = "erreur"
	end
	return sortie, index
end
#coeur du programme
if nombreArgument <= 2 || checkFusionStructure[0] == "erreur"
	puts "error"
else
        array1 = ARGV[0...checkFusionStructure[1]]
	array2 = ARGV[checkFusionStructure[1]+1...nombreArgument]
        puts arrayToString(sortedFusion(array1, array2))
end
