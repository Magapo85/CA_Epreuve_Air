#!/usr/bin/env ruby

#programme qui est capable de reconnaitre et de faire une operation avec le dernier argument : addition ou soustraction, sur chaque entier d'un liste, affiche error sinon

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

#fonction pour trouver un caractere dans un array, comme .index()
def checkLastArray(array, carac)
        sortie = "ok"
        if (array[0] != "+" && array[0] != "-") || (array[1..-1] != (array[1..-1].to_i).to_s && array[1..-1] != (array[1..-1].to_f).to_s) || trouverDansArray(",", array[1..-1])[1] == "erreur"
        	sortie = "erreur"
        end
        return sortie
end

#fonction utile qui test si l'argument (nombre suppose entier) contient . ou , avant conversion et calcul
def fauxFloatEntier()
        i = nombreArgument - 2
        sortie = "ok"
        while i >= 0 && sortie == "ok"
                if trouverDansArray(",", ARGV[i])[1] == "erreur" || (ARGV[i] != (ARGV[i].to_i).to_s && ARGV[i] != (ARGV[i].to_f).to_s)
                        sortie = "erreur"
                end
                i = i - 1
        end
        return sortie
end

def operationMath(list, operand)
        sortie = ""
        lgArg = longueurArgument(list)
	calcul = 0
        for arg in 0...lgArg
		calcul = list[arg]
		if operand[0] == "+"
			calcul = calcul + operand[1..-1].to_d
		else
			calcul = calcul - operand[1..-1].to_d
		end
                sortie = sortie + (calcul.to_f).to_s + " "
        end
        return sortie[0..-1]
end

#coeur du programme
if nombreArgument <= 1 || fauxFloatEntier() == "erreur" || (checkLastArray(ARGV[longueurArgument(ARGV) - 1], "+") == "erreur" && checkLastArray(ARGV[longueurArgument(ARGV) - 1], "-") == "erreur")
        puts "error"
else
	array = []
        for i in 0...longueurArgument(ARGV) - 1
                array.push(ARGV[i].to_d)
        end
        puts operationMath(array, ARGV[longueurArgument(ARGV) - 1])
end
