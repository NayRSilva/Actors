require 'thread'
def send(receiver, message)
    puts "*" * 100
    puts receiver.to_s
    puts message
    puts "*" * 100
end
class DataStorageManager

    attr_accessor :data, :stop_word_manager

    def self.dispatch(message)
        if message[0] == 'init'
            self.init(message[1])
        elsif message[0] == 'send_word_freqs' 
            self.process_words(message[1])
        else
            send(self.stop_word_manager, message)
        end
    end

    def self.init(message)
        path_to_file = message[0]
        self.stop_word_manager = message[1]
        self.data = File.open(path_to_file,"r").read
    end

    def self.process_words(message)
        recipient = message[0]
        data_str = ''.join(self.data)
        words = data_str.split()
        
        for w in words
            send(self.stop_word_manager, ['filter',w])
            send(self.stop_word_manager, ['top25', recipient])
            
        end
    end
end

class StopWordManager 
    attr_accessor :stop_words, :word_fres_manager
    
    def self.dispatch(message)
        if message[0] == 'init'
            self.init(message[1])
        elsif message[0]=='filter'
            self.filter(message[1])
            
        else 
            send(self.word_fres_manager, message)
        end

    end

    def self.init(message)

        self.stop_words = File.open(path_to_file,"r").read
        self.stop_words.downcase
        self.word_fres_manager = message[0]
      end

      def self.filter(message)
        word = message[0]
        if !self.stop_word.include(word)?
            send(self.word_fres_manager, ['word', word])
        end 
      end
end

class WordFrequencyManager
    
    attr_accessor :word_freqs
    
    def initializer
        @word_freqs = []
    end

    def self.dispatch(message)
        if message[0] == ’word’
            self.increment_count(message[1])
        elsif message[0] == ’top25’
            self.top25(message[1])
        end
    end

    def self.increment_count(message)
        word = message[0]
        if @word_freqs.include? word
            self.word_freqs[word] =+ 1
        else
            self.word_freqs[word] =    1
        end
    end

    def self.top25(message)
        recipient = message[0]
        freqs_sorted = self.word_freqs.sort 
        send(recipient, [’top25’, freqs_sorted])

end

class WordFrequencyController 
    attr_accessor :storage_manager, :word_freqs, :stop
    def self.dispatch(message)
        if message[0] =='run'
            self.run(message[1])
        elsif message[0] =='display'
            self.display(message1)
        else puts("message not understood. Nao sei fazer exception")            
        end
    end
    
    def self.run(message)
        self.storage_manager = message[0]
        send(self.storage_manager, ["send_word_freqs", self])
    end 
    def self.display(message)
        word_freqs = message[0]
        for (w, f) in word_freqs[0:25]
        print  w, "- ", f
        send(self.storage_manager, ["die"])
        self.stop = True
    end
    
end