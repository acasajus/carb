require "carb/version"
require "carb/state"
require "thor"

module Carb 
  class CLI < Thor

    package_name "ca"

    desc "create", "Create a certification authority"
    def create
      p "HELLO CA"
    end

    desc "show", "Show information about the certification authority"
    def show
      p "SHOW CA"
    end


    package_name "cert"

    desc "create_user", "create a user certificate"
    def create_user
      p "HELLO USER"
    end

  end
end
