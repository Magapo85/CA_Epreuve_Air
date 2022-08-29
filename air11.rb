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

def get_file_as_string(filename)
  data = ""
  f = File.open(filename, "r") 
  f.each_line do |line|
    data += line
  end
  f.close
  return data
end

def arrayToString(array)
	sortie = ""
	for arr in array
		sortie = sortie + arr #array[i]
	end
	return sortie
end

#coeur du programme
if nombreArgument != 1 || !File.exist?(ARGV[0])
        puts "error"
else
	file = File.open(ARGV[0])
	fileData = file.readlines() #file.read() to string VS file.readlines() ou file.readlines.map(&:chomp) to array
	file.close
	sortie = arrayToString(fileData).force_encoding("UTF-8")
	puts sortie
=begin
	test = "Troisième epreuve du CA\nAir\nhttps://docs.google.com/presentation/d/1Wh8rbIe3Ger0gugDEISctnnLfS9r4-s_PM0EpNyjitI/edit#slide=id.g10497f2623c_0_40\n" #\xC3\xA8 = \u00E8 = alt + 138 = encodign probleme
	puts test.encoding
	puts sortie.encoding
	if test == sortie
		puts array = [sortie, test].to_s
	end
	#data = get_file_as_string(ARGV[0]).force_encoding("UTF-8")
=end
end
