#!/usr/bin/env ruby

#programme qui affiche le contenu d'un fichier donne en argument, affiche error sinon
#https://www.rubyguides.com/2015/05/working-with-files-ruby/

#fonction utile qui trouve le nombre d'argument comme .length()
def nombreArgument
        i = 0
        while ARGV[i]
                i += 1
        end
        return i
end

#coeur du programme
if nombreArgument != 1 || !File.exist?(ARGV[0])
        puts "error"
else
	file = File.open(ARGV[0])
	fileData = file.readlines.map(&:chomp)
	file.close
        puts fileData
end
