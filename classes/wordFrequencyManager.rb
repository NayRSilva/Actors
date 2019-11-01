require_relative '../modules/queueSetters.rb'
require_relative '../modules/sendMessage.rb'

class WordFrequencyManager

    include QueueSetters
    
    def dispatch(message)
        if message[0] == 'word'
            self.increment_count(message[1..-1])
        elsif message[0]=='top25'
            self.top25(message[1..-1])          
        end
    end

    def increment_count(message)
        word = message[0]
        if @@word_freqs.include? word
            @@word_freqs[word] += 1
        else
            @@word_freqs[word] = 1
        end
    end

    def top25(message)
        recipient = message[0]
        freqs_sorted = @@word_freqs.sort_by{ |k,v| v}.reverse.to_h
        SendMessage.send(recipient, ['top25', freqs_sorted])
    end
end