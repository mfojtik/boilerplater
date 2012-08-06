require 'yaml'

module BoilerPlater

  module Cmd

    def self.search(keyword)
      BoilerPlater.search(keyword)
    end

    def self.list
      BoilerPlater.list.map { |k, v| "#{v}: #{k}" }.join("\n")
    end

    def self.show(id)
      data = BoilerPlater.show(find_alias(id))
      "\nDescription:   #{data['description']}\n" +
      "Author:        #{data['user']['login']}\n" +
      "URL:           #{data['url']}\n" +
      "\n"
    end

    def self.use(id, opts)
      BoilerPlater.setup do |bp|
        bp.prefix = opts[:prefix]
      end
      id = find_alias(id)
      puts
      puts "Setting up new project using %s" % BoilerPlater.show(id)['description']
      BoilerPlater.sections(BoilerPlater.get(id)).each do |part|
        puts '[%-8s] %s' % [(part.content? ? 'create' : 'download'), part.file]
        part.download_content! unless part.content?
        f.save!
      end
      "done.\n"
    end

    def self.alias(action, gist_id, name)
      result = case action
        when 'create' then alias_create(gist_id, name)
        when 'delete' then alias_delete(name=gist_id)
        when 'list' then return aliases.map { |gist, n| "#{n}: #{gist}" }.join("\n")
      end
      "Alias '#{name}' was #{!result ? 'not' : ''}#{action}d."
    end

    def self.alias_create(gist_id, name)
      return if find_alias(name) == gist_id
      update_aliases(aliases << [gist_id, name])
    end

    def self.find_alias(name)
      res = aliases.find { |k, v| v == name.strip }
      res ? res.first : name
    end

    def self.alias_delete(name)
      update_aliases(aliases.delete_if { |k, v| v == name })
    end

    def self.aliases
      File.exists?(alias_file) ? YAML::load_file(alias_file) : []
    end

    def self.alias_file
      File.join(ENV['HOME'], '.bp_aliases.yaml')
    end

    def self.update_aliases(arr)
      File.open(alias_file, 'w') { |f| YAML::dump(arr, f) }
    end

  end

end
