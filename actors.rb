require_relative './classes/dataStorageManager.rb'
require_relative './classes/stopWordManager.rb'
require_relative './classes/wordFrequencyController.rb'
require_relative './classes/wordFrequencyManager.rb'
require_relative './modules/queueSetters.rb'
require_relative './modules/sendMessage.rb'




threads = []
word_freqs_manager = WordFrequencyManager.new

threads<< Thread.new do 
    word_freqs_manager.inicializa
end

stop_word_manager = StopWordManager.new

threads << Thread.new do 
     SendMessage.send(stop_word_manager, ['init', word_freqs_manager])
     stop_word_manager.inicializa
end

storage_manager = DataStorageManager.new

threads << Thread.new do
    SendMessage.send(storage_manager, ['init', 'dracula.txt', stop_word_manager])
    storage_manager.inicializa
end

wfcontroller = WordFrequencyController.new
threads << Thread.new do
    SendMessage.send(wfcontroller, ['run', storage_manager])
    wfcontroller.inicializa
end

threads.each do |t|
    t.join
end    







