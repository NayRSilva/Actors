require_relative '../modules/queueSetters.rb'
require_relative '../modules/sendMessage.rb'

class StopWordManager

    include QueueSetters

    def getStopWords
        @@stop_words
    end

    def dispatch(message)
        if message[0] == 'init'
            self.init(message[1..-1])
        elsif message[0]=='filter'
            self.filter(message[1..-1])          
        else 
            SendMessage.send(@@word_freqs_manager, message)
        end
        
    end    
    
    def init(message)
        file = File.open("stopWords.txt","r")
        @@stop_words = file.read.downcase.split(" ")
        @@word_freqs_manager = message[0]
        file.close
    end
    
    def filter(message)
        word = message[0]
        unless @@stop_words.include? word
            SendMessage.send(@@word_freqs_manager, ['word', word])
        end
    end
end