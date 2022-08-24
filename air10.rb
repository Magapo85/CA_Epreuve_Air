#!/usr/bin/env ruby

#programme qui decale tous les elements d'un tableau vers la gauche. Le premier element devient le dernier a chaque rotation, affiche error sinon
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

def maRotation(argument)
        sortie = []
        lgArg = longueurArgument(argument)
        for arg in 1...lgArg
		sortie = sortie.push(argument[arg])
        end
	sortie = sortie.push(argument[0])
        return sortie
end

def arrayToString(array)
	sortie = ""
	for i in 0...longueurArgument(array)
		sortie = sortie + array[i] + ", "
	end
	return sortie[0...-2]
end

#coeur du programme
if nombreArgument <= 1
        puts "error"
else
        puts arrayToString(maRotation(ARGV))
end

