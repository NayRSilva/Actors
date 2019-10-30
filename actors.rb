module QueueSetters
    @@queue

    def getQueue
        @@queue.pop
    end

    def setQueue(message)
        @@queue << message
    end

end

def send (receiver, message)
    receiver.setQueue(message)
end

class DataStorageManager   
    include QueueSetters
end

