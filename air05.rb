#!/usr/bin/env ruby

#programme qui affiche une chaine de caractere en evitant les caracteres identique adjacent, affiche error sinon
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

def effaceDoublet(argument)
        sortie = argument[0]
        lgArg = longueurArgument(argument)
        for arg in 1...lgArg
		present = 0
                if argument[arg] == argument[arg - 1]
                                present = 1
                end
                if present == 0
                        sortie = sortie + argument[arg]
                end
        end
        return sortie
end

#coeur du programme
if nombreArgument != 1
        puts "error"
else
        puts effaceDoublet(ARGV[0])
end
