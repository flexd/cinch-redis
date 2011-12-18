require "cinch/storage"
require "redis"
require "json"

module Cinch
  class Storage
    class Redis < Storage
      VERSION = "0.1"
      def initialize(options, plugin)
        # New Redis object, thread safe by default since 2.2.0
        @redis = ::Redis.new(:host => 'localhost', :port => 6379)
        @options = options
        @base = plugin.class.plugin_name.to_s
        puts "Redis object is: #{@base}" unless !@options.debug
        load_data
      end
      def serialize(object)
        puts "Serializing #{object.inspect}" unless !@options.debug
        return object.to_json
      end
      def unserialize(object)
        puts "Unserializing #{object.inspect}" unless !@options.debug
        if !object.nil? then
          return JSON.parse(object)
        else
          return {}
        end
      end
      def [](key)
        @data[key.to_s]
      end

      def []=(key, value)
        puts "Setting #{key.to_s} to: #{value}" unless !@options.debug
        @data[key.to_s] = value

        maybe_save
      end

      def has_key?(key)
        @data.has_key?(key.to_s)
      end
      alias_method :include?, :has_key?
      alias_method :key?, :has_key?
      alias_method :member?, :has_key?

      def each
        @data.each {|e| yield(e)}
      end

      def each_key
        @data.each_key {|e| yield(e)}
      end

      def each_value
        @data.each_value {|e| yield(e)}
      end

      def delete(key)
        @data.delete(key.to_s)
        maybe_save
      end

      def delete_if
        delete_keys = []
        each do |key, value|
          delete_keys << key.to_s if yield(key.to_s, value)
        end

        delete_keys.each do |key|
          delete(key.to_s)
        end
      end  
      def save
        puts "Saving data hash: #{@data.inspect}" unless !@options.debug
        result = @redis.set(@base, serialize(@data))
        puts "Saving went: #{result.inspect}" unless !@options.debug
      end
      def load_data
        puts "Loading data from redis" unless !@options.debug
        @data = unserialize(@redis.get(@base))
        puts "Data has been loaded: #{@data}" unless !@options.debug 
      end

      def unload
      end

      private
      def maybe_save
        save if @options.autosave
      end
    end
  end
end
