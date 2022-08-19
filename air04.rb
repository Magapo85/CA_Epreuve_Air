#!/usr/bin/env ruby

#programme qui retourne la valeur d'une liste qui n'a pas de paire, affiche error sinon
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

def doublet(argument)
        sortie = []
        lgArg = longueurArgument(argument)
        for arg in 0...lgArg
		present = 0
                for arg2 in 0...lgArg
			if argument[arg] == argument[arg2] && arg != arg2
				present = 1
			end
		end
                if present == 0
                        sortie.push(argument[arg])
                end
        end
        return sortie
end

#coeur du programme
if nombreArgument <= 2
        puts "error"
else
        puts doublet(ARGV)
end


