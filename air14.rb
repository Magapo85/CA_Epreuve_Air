#!/usr/bin/env ruby

#programme qui verifie si les exercices de votre epreuve de l'air sont presents dans le repertoire et qu'ils fonctionnent (sauf celui la), utilise du vert et du rouge pour rendre reussites et echecs plus visibles

require 'shellwords'

#classe pour mettre la couleur
class String
def black;          "\e[30m#{self}\e[0m" end
def red;            "\e[31m#{self}\e[0m" end
def green;          "\e[32m#{self}\e[0m" end
def brown;          "\e[33m#{self}\e[0m" end
def blue;           "\e[34m#{self}\e[0m" end
def magenta;        "\e[35m#{self}\e[0m" end
def cyan;           "\e[36m#{self}\e[0m" end
def gray;           "\e[37m#{self}\e[0m" end

def bg_black;       "\e[40m#{self}\e[0m" end
def bg_red;         "\e[41m#{self}\e[0m" end
def bg_green;       "\e[42m#{self}\e[0m" end
def bg_brown;       "\e[43m#{self}\e[0m" end
def bg_blue;        "\e[44m#{self}\e[0m" end
def bg_magenta;     "\e[45m#{self}\e[0m" end
def bg_cyan;        "\e[46m#{self}\e[0m" end
def bg_gray;        "\e[47m#{self}\e[0m" end

def bold;           "\e[1m#{self}\e[22m" end
def italic;         "\e[3m#{self}\e[23m" end
def underline;      "\e[4m#{self}\e[24m" end
def blink;          "\e[5m#{self}\e[25m" end
def reverse_color;  "\e[7m#{self}\e[27m" end
def no_colors;      self.gsub /\e\[\d+m/, "" end
end

=begin
#outputs color table to console, regular and bold modes
def colortable
  names = %w(black red green yellow blue pink cyan white default)
  fgcodes = (30..39).to_a - [38]

  s = ''
  reg  = "\e[%d;%dm%s\e[0m"
  bold = "\e[1;%d;%dm%s\e[0m"
  puts '                       color table with these background codes:'
  puts '          40       41       42       43       44       45       46       47       49'
  names.zip(fgcodes).each {|name,fg|
    s = "#{fg}"
    puts "%7s "%name + "#{reg}  #{bold}   "*9 % [fg,40,s,fg,40,s,  fg,41,s,fg,41,s,  fg,42,s,fg,42,s,  fg,43,s,fg,43,s,  
      fg,44,s,fg,44,s,  fg,45,s,fg,45,s,  fg,46,s,fg,46,s,  fg,47,s,fg,47,s,  fg,49,s,fg,49,s ]
  }
end
=end

#fonction qui execute le test du fichier par son nom l'entree et la sortie attendue
def test(nom, numero, total, entree, sortie, totalSuccess)
	success = totalSuccess
	numerosortie = numero + 1
	debut = " " + nom[0...-3] + " "
        milieu = "(" + numerosortie.to_s + "/" + total.to_s + ") : "
	output = `ruby #{nom} #{entree}`#appel de la fonction pour executer dans le terminal automatiquement
	#puts output.to_s
	#puts output.encoding
	#puts sortie
	#puts sortie.encoding
	if output == sortie
        	puts "  " + debut.magenta.bg_gray.bold.underline + milieu.blue.bg_gray.bold.underline + " success".green
        	success += 1
	else
        	puts "  " + debut.magenta.bg_gray.bold.underline + milieu.blue.bg_gray.bold.underline + " failure".red
	end
	return success, numerosortie
end

#fonction qui synthetise le resultat d'un fichier et dit son etat de fonctionnement
def fin(nom, nombreTestSuccess, total, nombreTestSuccessTotal, nombreTest)
	puts "  -----------------------"
	ratio = (nombreTestSuccess.to_f/total.to_f).to_f
	if ratio > 0.75
        	puts "     " + nom.bg_green + " : " + "AVAILABLE ".bold.green
	elsif ratio >= 0.5
        	puts "     " + nom.bg_blue  + " : " + "TOLERABLE ".bold.blue
	elsif ratio >= 0.25
                puts "     " + nom.bg_brown + " : " + "INCORRECT ".bold.brown
	else 
                puts "      " + nom.bg_red   + " : " + "INVALID ".bold.red
	end
	puts "  ======================="
	nombreTestSuccessTotalsortie = nombreTestSuccessTotal + nombreTestSuccess
	nombreTestsortie = nombreTest + total
	return nombreTestSuccessTotalsortie, nombreTestsortie
end

#fonction qui affiche que le fichier n'existe pas
def noExist(nom)
	puts "       " + nom[0...-3].bold.red.bg_gray   + " : " + " NULL ".bold.red
        puts "  ======================="
end

#coeur du programme
nombreTest = 0
nombreTestSuccessTotal = 0
system("clear") || system("cls")
puts
puts "  _______________________"
puts " |                       |"
puts " |      TEST PROCESS     |"
puts " |_______________________|"
puts
puts "  ======================="

#le processus de test a ete concu et pense pour qu'il soit possiblement automatiser en ajout de test car on peut mettre une liste de nom et de test en argument par exemple car il ne faut changer que sa
nom = "airXX.rb"
if File.exist?(nom)
        #debut des tests avec airXX (qui n'existe pas)
        numero = 0
        nombreTestSuccess = 0

        total = 1# faire +1 si on rajoute un test
        nombreTestSuccess, numero = test(nom, numero, total, "\n", "Hello", nombreTestSuccess)#copier cette ligne et modifier les deux arguments string seulement pour un nouveau test, automatisable en boucle for ou while

        nombreTestSuccessTotal, nombreTest = fin(nom[0...-3], nombreTestSuccess, total, nombreTestSuccessTotal, nombreTest)
else
        noExist(nom)
end

nom = "air01.rb"
if File.exist?(nom)
	#debut des tests avec air01
	numero = 0
	nombreTestSuccess = 0

	total = 4
	nombreTestSuccess, numero = test(nom, numero, total, Shellwords.escape("je\sm\'appelle\sguillaume"), "je\nm\'appelle\nguillaume\n", nombreTestSuccess)#Shellword qui sert considerer une chaine de caractere avec des espaces comme un seul argument unique
	nombreTestSuccess, numero = test(nom, numero, total, "\n", "error\n", nombreTestSuccess)
	nombreTestSuccess, numero = test(nom, numero, total, "5555", "5555\n", nombreTestSuccess)
	nombreTestSuccess, numero = test(nom, numero, total, "je\ssuis\sle\snumero\s2012", "error\n", nombreTestSuccess)

	nombreTestSuccessTotal, nombreTest = fin(nom[0...-3], nombreTestSuccess, total, nombreTestSuccessTotal, nombreTest)
else 
	noExist(nom)
end

nom = "air02.rb"
if File.exist?(nom)
        #debut des tests avec air02
        numero = 0
        nombreTestSuccess = 0

        total = 5
        nombreTestSuccess, numero = test(nom, numero, total, Shellwords.escape("Crevette magique dans la mer des etoiles") + " la", "Crevette magique dans \n mer des etoiles\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "\n", "error\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "5555", "error\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "je\ssuis\sle\snumero\s781227", "error\n", nombreTestSuccess)
	nombreTestSuccess, numero = test(nom, numero, total, Shellwords.escape("Crevette magique dans la mer des etoiles") + " " + Shellwords.escape("\s"), "Crevette\nmagique\ndans\nla\nmer\ndes\netoiles\n", nombreTestSuccess)

        nombreTestSuccessTotal, nombreTest = fin(nom[0...-3], nombreTestSuccess, total, nombreTestSuccessTotal, nombreTest)
else
        noExist(nom)
end

nom = "air03.rb"
if File.exist?(nom)
        #debut des tests avec air03
        numero = 0
        nombreTestSuccess = 0

        total = 3
        nombreTestSuccess, numero = test(nom, numero, total, "je\stest\sdes\strucs" + " " + Shellwords.escape("\s"), "je test des trucs\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "\n", "error\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "5555\s2", "error\n", nombreTestSuccess)

        nombreTestSuccessTotal, nombreTest = fin(nom[0...-3], nombreTestSuccess, total, nombreTestSuccessTotal, nombreTest)
else
        noExist(nom)
end

nom = "air04.rb"
if File.exist?(nom)
        #debut des tests avec air04
        numero = 0
        nombreTestSuccess = 0

        total = 4
        nombreTestSuccess, numero = test(nom, numero, total, "1 2 3 4 5 4 3 2 1", "5\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "\n", "error\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "5555", "error\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "bonjour monsieur bonjour madame", "monsieur\nmadame\n", nombreTestSuccess)

        nombreTestSuccessTotal, nombreTest = fin(nom[0...-3], nombreTestSuccess, total, nombreTestSuccessTotal, nombreTest)
else
        noExist(nom)
end

nom = "air05.rb"
if File.exist?(nom)
        #debut des tests avec air05
        numero = 0
        nombreTestSuccess = 0

        total = 2
        nombreTestSuccess, numero = test(nom, numero, total, Shellwords.escape("Hello my lady,  bien ou quoi ??"), "Helo my lady, bien ou quoi ?\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "\n", "error\n", nombreTestSuccess)

        nombreTestSuccessTotal, nombreTest = fin(nom[0...-3], nombreTestSuccess, total, nombreTestSuccessTotal, nombreTest)
else
        noExist(nom)
end

nom = "air06.rb"
if File.exist?(nom)
        #debut des tests avec air06
        numero = 0
        nombreTestSuccess = 0

        total = 3
        nombreTestSuccess, numero = test(nom, numero, total, "1 2 3 4 5 +2", "3.0 4.0 5.0 6.0 7.0\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "\n", "error\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "10 11 12 20 -5", "5.0 6.0 7.0 15.0\n", nombreTestSuccess)

        nombreTestSuccessTotal, nombreTest = fin(nom[0...-3], nombreTestSuccess, total, nombreTestSuccessTotal, nombreTest)
else
        noExist(nom)
end

nom = "air07.rb"
if File.exist?(nom)
        #debut des tests avec air07
        numero = 0
        nombreTestSuccess = 0

        total = 3
        nombreTestSuccess, numero = test(nom, numero, total, "\n", "error\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "Michel Albert Therese Benoit t", "Michel, Therese\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "Michel Albert Therese Benoit a", "Michel, Albert, Therese, Benoit\n", nombreTestSuccess)

        nombreTestSuccessTotal, nombreTest = fin(nom[0...-3], nombreTestSuccess, total, nombreTestSuccessTotal, nombreTest)
else
        noExist(nom)
end

nom = "air08.rb"
if File.exist?(nom)
        #debut des tests avec air08
        numero = 0
        nombreTestSuccess = 0

        total = 3
        nombreTestSuccess, numero = test(nom, numero, total, "\n", "error\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "1 3 4 2", "1 2 3 4\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "10 20 30 40 50 60 70 90 33", "10 20 30 33 40 50 60 70 90\n", nombreTestSuccess)

        nombreTestSuccessTotal, nombreTest = fin(nom[0...-3], nombreTestSuccess, total, nombreTestSuccessTotal, nombreTest)
else
        noExist(nom)
end

nom = "air09.rb"
if File.exist?(nom)
        #debut des tests avec air09
        numero = 0
        nombreTestSuccess = 0

        total = 2
        nombreTestSuccess, numero = test(nom, numero, total, "\n", "error\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "10 20 30 fusion 15 25 35", "10 15 20 25 30 35\n", nombreTestSuccess)

        nombreTestSuccessTotal, nombreTest = fin(nom[0...-3], nombreTestSuccess, total, nombreTestSuccessTotal, nombreTest)
else
        noExist(nom)
end

nom = "air10.rb"
if File.exist?(nom)
        #debut des tests avec air10
        numero = 0
        nombreTestSuccess = 0

        total = 2
        nombreTestSuccess, numero = test(nom, numero, total, "\n", "error\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "Michel Albert Therese Benoit", "Albert, Therese, Benoit, Michel\n", nombreTestSuccess)
        
        nombreTestSuccessTotal, nombreTest = fin(nom[0...-3], nombreTestSuccess, total, nombreTestSuccessTotal, nombreTest)
else
        noExist(nom)
end

nom = "air11.rb"
if File.exist?(nom)
        #debut des tests avec air11
        numero = 0
        nombreTestSuccess = 0

        total = 4
        nombreTestSuccess, numero = test(nom, numero, total, "\n", "error\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "README.txt", "Troisième epreuve du CA\nAir\nhttps://docs.google.com/presentation/d/1Wh8rbIe3Ger0gugDEISctnnLfS9r4-s_PM0EpNyjitI/edit#slide=id.g10497f2623c_0_40\n".force_encoding("US-ASCII"), nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "README", "error\n", nombreTestSuccess)
	nombreTestSuccess, numero = test(nom, numero, total, "a.txt", "je danse le mia\nok \npl\n", nombreTestSuccess)

        nombreTestSuccessTotal, nombreTest = fin(nom[0...-3], nombreTestSuccess, total, nombreTestSuccessTotal, nombreTest)
else
        noExist(nom)
end

nom = "air12.rb"
if File.exist?(nom)
        #debut des tests avec air12
        numero = 0
        nombreTestSuccess = 0

        total = 3
        nombreTestSuccess, numero = test(nom, numero, total, "\n", "error\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "ox 5", "error\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "O 5", "    O    \n   OOO   \n  OOOOO  \n OOOOOOO \nOOOOOOOOO\n", nombreTestSuccess)

        nombreTestSuccessTotal, nombreTest = fin(nom[0...-3], nombreTestSuccess, total, nombreTestSuccessTotal, nombreTest)
else
        noExist(nom)
end

nom = "air13.rb"
if File.exist?(nom)
        #debut des tests avec air13
        numero = 0
        nombreTestSuccess = 0

        total = 2
        nombreTestSuccess, numero = test(nom, numero, total, "\n", "error\n", nombreTestSuccess)
        nombreTestSuccess, numero = test(nom, numero, total, "6 5 4 3 2 1", "1.0 2.0 3.0 4.0 5.0 6.0\n", nombreTestSuccess)

        nombreTestSuccessTotal, nombreTest = fin(nom[0...-3], nombreTestSuccess, total, nombreTestSuccessTotal, nombreTest)
else
        noExist(nom)
end

puts "..........................."
puts "  Total success : (%d/%d)".bold % [nombreTestSuccessTotal,nombreTest] #afficher le nombre de succes final par rapport au nombre de tests
