require_relative '../modules/queueSetters.rb'
require_relative '../modules/sendMessage.rb'

class WordFrequencyController
    
    include QueueSetters
    
    def dispatch(message)
        if message[0] == 'run'
            self.run(message[1..-1])
        elsif message[0]=='top25'
            self.display(message[1..-1])          
        else 
            raise "mensagem não reconhecida #{message}"
        end
    end
    
    def run(message)
        @@storage_manager = message[0]
        SendMessage.send(self, ['send_word_freqs', self])
    end
    
    def display(message)
        word_freqs = message[0].get_freqs_words
        
        cont = 25
        words_freqs.each do |key, value|
            break if cont < 0
            puts "#{key} - #{value}"
            cont = cont - 1
        end
        SendMessage.send(@@storage_manager, ['die'])
        @@stop = true
    end
end