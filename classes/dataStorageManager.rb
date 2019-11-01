require_relative '../modules/queueSetters.rb'
require_relative '../modules/sendMessage.rb'

class DataStorageManager   
    
    include QueueSetters
    
    def dispatch(message)
        if message[0] == 'init'
            self.init(message[1..-1])
        elsif message[0] == 'send_word_freqs'
            self.process_words(message[1..-1])          
        else 
            SendMessage.send(@@stop_word_manager, message)
        end

    end

    def init(message)

        path_to_file = message[0]
        @@stop_word_manager = message[1]
        file = File.open(path_to_file,"r")
            @@data = file.read.downcase.gsub(/[^a-z0-9\s]/i, '')
        file.close
    end

    def process_words(message)
        recipient = message[0]
        words = @@data.split(" ")
        words.each do |word|
            SendMessage.send(@@stop_word_manager, ['filter', word])
        end
        SendMessage.send(@@stop_word_manager, ['top25', recipient])
    end

end