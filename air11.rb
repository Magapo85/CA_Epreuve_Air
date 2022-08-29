#!/usr/bin/env ruby

#programme qui affiche le contenu d'un fichier donne en argument, affiche error sinon
#https://www.rubyguides.com/2015/05/working-with-files-ruby/

require 'shellwords'

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
	
	puts "file"
	puts fileData.class
	puts fileData.to_s
	puts

	new = arrayToString(fileData)
	puts "new"
	puts new.class
	puts new.encoding

	temp = Shellwords.escape("Troisième epreuve du CA\nAir\nhttps://docs.google.com/presentation/d/1Wh8rbIe3Ger0gugDEISctnnLfS9r4-s_PM0EpNyjitI/edit#slide=id.g10497f2623c_0_40\n")
	puts 
	
	test = "Troisi\xC3\xA8me epreuve du CA\nAir\nhttps://docs.google.com/presentation/d/1Wh8rbIe3Ger0gugDEISctnnLfS9r4-s_PM0EpNyjitI/edit\#slide=id.g10497f2623c_0_40\n" #\xC3\xA8 = alt + 138
	puts "test"
	puts test.class
	puts test
	puts

	if temp == test
		puts "ok"
	end

	if new.encoding == temp
                puts "yes"
        else
                puts "no"
        end

	puts	
	data2 = get_file_as_string(ARGV[0])
	puts "data"
	puts data2.class
	puts data2

	if data2 == test
                puts "yes"
        else
                puts "no"
        end
	
	puts
	puts	
	array = [new.force_encoding("ASCII-8BIT"), data2, test, temp]
	puts array
	puts 
	puts
	puts array.to_s
end
