class HaxeLib < Rake::FileTask
  class << self
    def home
      `haxelib config`.chomp
    end

    def spec_to_path spec
      id, version = spec.split(":")
      File.join( home, id, version.gsub(".",",") )
    end

    def path_to_spec path
      id, version = path.gsub(home,"").split(File::SEPARATOR)
      return nil unless id && version && path.include?(home)
      {:id => id, :version => version.gsub(",",".")}
    end

    def lookup spec
      id, version = spec.split(":")
      task = HaxeLib.define_task( spec_to_path spec )
      task.id = id
      task.version = version
      task
    end
  end

  attr_accessor :id, :version

  def initialize(*args)
    super
    enhance do |task|
      task.enhance do
        if download_needed?
          info "Downloading #{to_spec}"
          download
        end
      end
    end
  end

  def download
    fail( "Could not download #{to_spec}") unless system "haxelib install #{id} #{version}"
  end

  def download_needed?
    !File.exists?(name)
  end

  def to_spec
    "#{id}:#{version}"
  end

  def to_spec_hash
    {:id => @id, :version => @version}
  end

end

module Buildr
  def haxelib spec
    haxelib = HaxeLib.lookup(spec)
    #haxelib.invoke
    haxelib
  end
end