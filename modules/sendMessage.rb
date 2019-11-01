module SendMessage

    def self.send (receiver, message)
        receiver.setQueue(message)
    end

end