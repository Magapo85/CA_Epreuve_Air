#!/usr/bin/env ruby

#programme qui transforme un tableau de chaines de caracteres en une seule chaine de caracteres espacee d'un separateur donne en dernier argument , afiche error sinon

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

def maFonctionConcatenation(argument)
	sortie = ""
	lgArg = longueurArgument(argument) - 1
	for arg in 0...lgArg
		sortie = sortie + argument[arg]
		if arg != lgArg - 1
			sortie = sortie + argument[lgArg]
		end
	end
	return sortie
end

#coeur du programme
if nombreArgument <= 2
        puts "error"
else
        puts maFonctionConcatenation(ARGV)
end


