module QueueSetters
    @@queue

    def getQueue
        @@queue.pop
    end

    def setQueue(message)
        @@queue << message
    end

end

class StopWordManager

    include QueueSetters

    def getStopWords
        @@stop_words
    end

    def self.dispatch(message)
        if message[0] == 'init'
            self.init(message[1..-1])
        elsif message[0]=='filter'
            self.filter(message[1..-1])          
        else 
            send(@@word_freqs_manager, message)
        end

    end    

    def self.init(message)
        file = File.open("fileStopWords.txt","r")
        @@stop_words = file.read.downcase.split(" ")
        @@word_freqs_manager = message[0]
        file.close
    end

    def self.filter(message)
        word = message[0]
        unless @@stop_words.include? word
            send(@@word_freqs_manager, ['word', word])
        end
    end
end


def send (receiver, message)
    receiver.setQueue(message)
end

class WordFrequencyConttoller

    def self.dispatch(message)
        if message[0] == 'run'
            self.run(message[1..-1])
        elsif message[0]=='top25'
            self.display(message[1..-1])          
        else 
            raise "Mensagem não correspondente #{message[0]}"
        end
    end

    def self.run(message)
        @@storage_manager = message[0]
        send(@@storage_manager, ['send_word_freqs', self])
    end

    def self.display(message)
        word_freqs = message[0].get_freqs_words
        
        cont = 25
        words_freqs.each do |key, value|
            break if cont < 0
            puts "#{key} - #{value}"
            cont = cont - 1
        end
        send(@@storage_manager, ['die'])
        @@stop = true
    end
end
class DataStorageManager   

    include QueueSetters

    def self.dispatch(message)
        if message[0] == 'init'
            self.init(message[1..-1])
        elsif message[0]=='send_word_freqs'
            self.process_words(message[1..-1])          
        else 
            send(@@stop_word_manager, message)
        end

    end

    def self.init(message)
        path_to_file = message[0]
        @@stop_word_manager = message[1]
        file = File.open(path_to_file,"r")
            @@data = file.read.downcase.gsub(/[^a-z0-9\s]/i, '')
        file.close        
    end

    def self.process_words(message)
        recipient = message[0]
        words = @@data.split(" ")
        words.each do |word|
            send(@@stop_word_manager, ['filter', word])
        end
        send(stop_word_manager, ['top25', recipient])
    end

end

class WordFrequencyManager
    
    def self.dispatch(message)
        if message[0] == 'word'
            self.increment_count(message[1..-1])
        elsif message[0]=='top25'
            self.top25(message[1..-1])          
        end
    end

    def self.increment_count(message)
        word = message[0]
        if @@word_freqs.include? word
            @@word_freqs[word] += 1
        else
            @@word_freqs[word] = 1
        end
    end

    def self.top25(message)
        recipient = message[0]
        freqs_sorted = @@word_freqs.sort_by{|k,v| v}.reverse.to_h
        send(recipient, ['top25', freqs_sorted])
    end
end









