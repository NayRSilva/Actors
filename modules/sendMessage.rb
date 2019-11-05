module SendMessage

    def self.send (receiver, message)
        p "#{receiver} , #{message}"
        receiver.setQueue(message)
    end

end