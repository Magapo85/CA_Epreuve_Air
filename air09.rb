#!/usr/bin/env ruby

#programme qui fusionne deux listes d'entiers triee en les gardant triees,les deux listes seront separees par un argument "fusion", affiche error sinon

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
def fauxFloatEntier(array)
        i = 0
        sortie = "ok"
        while array[i] && sortie == "ok"
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
		if array[i - 1] > array[i]
			sortie = "erreur"
		end
	end	
	return sortie
end

def sortedFusion(array1, array2)
	index = 0
	sortie = array1
	sortietemp = array1
	for b in 0...longueurArgument(array2)
		new = array2[b].to_d
		for i in 0...longueurArgument(sortie) 
			if new <= sortie[i].to_d
				break
			end
			index = i + 1
		end
		if index == 0
			sortie = [new, sortie]
		else	
			sortietemp = sortie
			sortie = sortie[0,index]
			sortie = sortie.push(new)
			sortie = sortie + sortietemp[index,longueurArgument(sortietemp)-1]
			#array = array[0...index-1] + [new] + array[index...longueurArgument(array)-1]
		end
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

def checkFusionStructure
	sortie = "erreur"
	index = -1
	for arr in 0...nombreArgument
		#puts arr
		if ARGV[arr] == "fusion"
			sortie = "ok"
			index = arr
			break
		end
	end
	#puts "debut"
	#puts ARGV[0...index].to_a
	#puts "fin"
	#puts ARGV[index + 1...nombreArgument].to_a
	#puts "milieu"
	#puts ARGV[index]
	if sortie == "ok" && fauxFloatEntier(ARGV[0...index].to_a) == "ok" && fauxFloatEntier(ARGV[index + 1...nombreArgument].to_a) == "ok"
		if checkSorted(ARGV[0...index].to_a) == "erreur" || checkSorted(ARGV[index + 1...nombreArgument].to_a) == "erreur"
			sortie = "erreur"
		end
	end
	#puts index
	return sortie, index
end
#coeur du programme
if nombreArgument <= 2 || checkFusionStructure[0] == "erreur"
	puts "error"
else
	puts "array1"
        puts array1 = ARGV[0...checkFusionStructure[1]].to_a
	puts "array2"
	puts array2 = ARGV[checkFusionStructure[1] + 1...nombreArgument].to_a
        puts arrayToString(sortedFusion(array1, array2))
end
