# Originally from https://github.com/joshuaclayton/dotfiles/blob/master/Rakefile

class Installer
  def symlink(target, link)
    if File.symlink?(link)
      unlink(link)
    elsif File.exist?(link)
      puts "ERROR: File exists: #{link}"
      exit 1
    end
    puts "Symlinking #{link} => #{target}"
    File.symlink(target, link)
  end

  def delete_symlink(link)
    unlink(link) if File.symlink?(link)
  end

  def unlink(link)
    if File.exist?(link)
      descriptor = File.symlink?(link) ? "symlink" : "file"
      puts "Deleting #{descriptor} #{link}"
      File.unlink(link)
    end
  end
end

def pwd; File.dirname(__FILE__); end
def target_path(file)
  File.join(ENV["HOME"], ".#{file}")
end

files = File.new(File.join(pwd, "MANIFEST"), "r").read.split("\n")

task :default => 'install'

desc "Install all dotfiles"
task :install => ['submodules:init', 'submodules:update'] do
  files.each do |file|
    Installer.new.symlink(File.join(pwd, file), target_path(file))
  end
end

desc "Remove all dotfies"
task :uninstall do
  files.each do |file|
    Installer.new.unlink(target_path(file))
  end
end

namespace :submodules do
  desc "Install submodules"
  task :init do
    puts "Installing submodules"
    `git submodule init`
  end

  desc "Update submodules"
  task :update do
    puts "Updating submodules"
    `git submodule update`
  end
end

namespace :vim do

  desc "Update VIM plugins"
  task :update do
    puts "Pull vim submodules"
    system(%{
    for x in vim/bundle/*; do
      echo $x
      cd $x
      git checkout master && git pull
      cd -
    done
    })
  end
end
