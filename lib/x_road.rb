require 'savon'
require 'uuidtools'
require 'x_road/version'
require 'x_road/active_x_road6'
require 'x_road/services/rr.rb'
require 'x_road/services/ehis.rb'
require 'x_road/services/kpr.rb'

module XRoad
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
    attr_accessor :host
    attr_accessor :client_cert
    attr_accessor :client_key
    attr_accessor :log_level
    attr_accessor :ssl_verify

    attr_accessor :client_path
    attr_accessor :client_x_road_instance
    attr_accessor :client_member_class
    attr_accessor :client_member_code
    attr_accessor :client_subsystem_code
    attr_accessor :x_road_instance # by default client_path defines it

    def initialize
      @log_level = :info
      @ssl_verify = :none
    end

    def client_path=(path)
      @client_path = path
      self.client_x_road_instance, 
        self.client_member_class, 
        self.client_member_code, 
        self.client_subsystem_code = path.split('/')
      self.x_road_instance = client_x_road_instance
    end
  end
end
