module API
  module ErrorFormatter
    def self.call message, backtrace, options, env
      if message.is_a?(Hash)
        { status: message[:code],  error: message[:message]}.to_json
      else
        { error: message }.to_json
      end
    end
  end
end
