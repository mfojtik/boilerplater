module BoilerPlater

  def self.config(c=nil)
    @config = c if !c.nil?
    @config || OpenStruct.new
  end

  def self.setup(&block)
    c = config
    yield c && config(c)
  end

  def self.get(gist_id)
    Gist.read(gist_id)
  end

  def self.show(gist_id)
    JSON.parse(open(Gist::GIST_URL % gist_id).read)
  end

  def self.use(gist_id)
    BoilerPlater.sections(get(gist_id)).each do |f|
      f.download_content! unless f.content?
      f.save!
    end
  end

  def self.list
    get(3266785).each_line.map { |l| l.split(';') }.inject({}) { |r, l| r[l.first.to_i] = l.last.strip; r }
  end

  def self.search(name)
    list.find { |k, v| v =~ /#{name}/ }.join(' | ')
  end

  def self.sections(content)
    sections, section = [], ''
    content.each_line do |line|
      if line =~ /^##/
        sections << Parser::Section.new(section) if !section.empty?
        section = line
      else
        section += line
      end
    end
    sections << Parser::Section.new(section)
  end

  module Parser

    def self.new(content)
      BoilerPlate.new(content)
    end

    class BoilerPlate
      attr_reader :content

      def initialize(content)
        @content = content
      end

    end

    class Section
      attr_reader :file
      attr_reader :metadata
      attr_reader :content

      def initialize(content)
        @content = content.split("\n")
        @metadata = parse_metadata(@content.shift.strip)
        @content = @content.join("\n")
        @file = @metadata[:filename]
      end

      def save!
        FileUtils.mkdir_p(File.dirname(path)) unless File.directory?(File.dirname(path))
        File.open(path, 'w') do |f|
          f.puts(content)
        end
      end

      def path
        FileUtils.mkdir_p(BoilerPlater.config.prefix) if !BoilerPlater.config.prefix.nil?
        File.join(BoilerPlater.config.prefix || '.', File.dirname(@file), File.basename(@file))
      end

      def download_content!
        @content = open(metadata[:url]).read
      end

      def content?
        !content.empty?
      end

      private

      def parse_metadata(line)
        raise 'Each section must start with ##' unless line =~ /^##/
        line.gsub!(/^##(\s+)/, '')
        line.split('->').inject({}) { |result, part|
          if part.strip =~ /^(\w+):\/\//
            result[:url] = part.strip
          elsif !part.nil?
            result[:filename] = part.strip
          end
          result
        }
      end

    end

  end

end
