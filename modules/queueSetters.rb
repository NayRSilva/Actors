module QueueSetters
    @@queue = Queue.new
    @@stop = false

    def getQueue
        @@queue.pop
    end
    def setQueue(message)
        @@queue << message
    end

    def inicializa
        while !@@stop
            while !@@queue.empty?
                message = self.getQueue
                self.dispatch(message)
                if message == 'die'
                    @@stop = true
                end
            end
        end
    end
    
   
end

