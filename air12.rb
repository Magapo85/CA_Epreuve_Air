#!/usr/bin/env ruby

#programme qui affiche un escalier constitue d'un caractere et d'un nombre d'etages donne en parametre, affiche error sinon

#fonction utile qui trouve le nombre ou la longueur d'argument comme .length()
def longueurArgument(argument)
        i = 0
        while argument[i]
                i += 1
        end
        return i
end

#coeur du programme
if longueurArgument(ARGV) != 2 || longueurArgument(ARGV[0]) != 1 || ARGV[1].to_i <= 0 || ARGV[1] != (ARGV[1].to_i).to_s
        puts "error"
else
	for i in 1..ARGV[1].to_i
		sortie = ""
		for a in 1..2*ARGV[1].to_i-1
			if a <= ARGV[1].to_i-i || a >= ARGV[1].to_i+i 
				sortie = sortie + " "
			else
				sortie = sortie + ARGV[0]
			end 
		end
		puts sortie
	end
end

=begin
        sortie = ""
        for i in 1..ARGV[1].to_i
                sortie = ""
                for a in 1..ARGV[1].to_i-i
                        sortie = sortie + " "
                end
                #b = 0
                #while b != i-1
                for b in 1..i-1
                        sortie = sortie + ARGV[0]
                        #b = b + 1
                end
                sortie = sortie + ARGV[0]
                #c = 0
                #while c != i-1
                for c in 1..i-1
                        sortie = sortie + ARGV[0]
                        #c = c + 1
                end
                puts sortie
        end
=end
