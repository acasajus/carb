require 'carb/exceptions'
require 'carb/version'
require 'singleton'
require 'yaml'

module Carb
  class State
    include Singleton
    attr_accessor :where

    CONF_FILE = ".carb.yml"

    def initialize
      reset
    end

    def init_dir( dirpath )
      raise NoStateError, "Can't initialize a non existant dir #{dirpath}" if ! File.directory? dirpath
      @where = dirpath
      save
    end

    def load
      find_state_file if @where.nil?
      @state = YAML.load_file( @where )
    end

    def save
      find_state_file if @where.nil?
      File.open( @where, 'w') {|f| f.write @state.to_yaml } if @state
    end

    def reset
      @where = nil
      @state = { version: Carb::VERSION }
    end

    def find_state_file( here = nil )
      return if @where
      here = File.realpath( __FILE__ ) if here.nil?
      while here != "/"
        here = File.dirname here
        cfg = File.join( here, CONF_FILE )
        if File.file? cfg
          @where = cfg
          return
        end
      end 
      raise NoStateError, "No state found. Did you initialize someplace as a carb directory?"
    end


  end
end