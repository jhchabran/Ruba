module Bytes
    def self.read(string)
      string.match(/(\d+)(\w\w?)/)
    end
    
    UNITS = {
      'B'  => :byte,
      'KB' => :kilobyte,
      'MB' => :megabyte,
      'GB' => :gigabyte,
      'TB' => :terabyte
    }
    
  class Parser
    def self.read(input)
      units = UNITS.collect { |k,v| "(#{k})"}.join("|")
      input.match(/^(\d+)(#{units})$/)
      $1.to_i.send(UNITS[$2])
    rescue 
      nil
    end
  end  
  
  module InstanceMethods
    def byte
      self
    end
    alias :bytes :byte
    
    def kilobyte
      self * 1024
    end
    alias :kilobytes :kilobyte
    
    def megabyte
      kilobyte * 1024
    end
    alias :megabytes :megabyte
    
    def gigabyte
      megabyte * 1024
    end
    alias :gigabytes :gigabyte
    
    def terabyte
      gigabyte * 1024
    end
    alias :terabytes :terabyte
  end
  
  def self.included(receiver)
    receiver.send :include, InstanceMethods
  end
end

Fixnum.send(:include, Bytes)
