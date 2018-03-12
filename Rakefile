# Originally from https://github.com/joshuaclayton/dotfiles/blob/master/Rakefile
require 'rbconfig'

module Installer
  class << self
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

    def mac_or_unix(mac_cmd, unix_cmd)
      case RbConfig::CONFIG['host_os']
      when /darwin/i
        mac_cmd
      when /linux/i
        unix_cmd
      end
    end
  end
end

def pwd; File.dirname(__FILE__); end
def target_path(file)
  File.join(ENV["HOME"], ".#{file}")
end

files = File.new(File.join(pwd, "MANIFEST"), "r").read.split("\n")

task :default => ['submodules:init', 'submodules:update', 'dotfiles:install', 'vim:install', 'install:tmux']

namespace :dotfiles do
  desc "Install all dotfiles"
  task :install => ['submodules:init', 'submodules:update'] do
    files.each do |file|
      Installer.symlink(File.join(pwd, file), target_path(file))
    end
  end

  desc "Remove all dotfies"
  task :uninstall do
    files.each do |file|
      Installer.unlink(target_path(file))
    end
  end
end

namespace :submodules do
  desc "Install submodules"
  task :init do
    puts "Installing submodules"
    system 'git submodule init'
  end

  desc "Update submodules"
  task :update do
    puts "Updating submodules"
    system 'git submodule update'
  end
end

namespace :vim do

  desc "Install NeoVim"
  task :install do
    Rake::Task['install:python'].invoke
    system 'pip3 install neovim psutil'
    system 'pip2 install neovim'
    system 'npm install -g neovim'
    system 'gem install neovim'
    system Installer.mac_or_unix(
      "brew install neovim --env-std --override-system-vim",
      "sudo apt-get install neovim"
    )

  end
end

namespace :install do
  desc 'Install Python'
  task :python do
    system Installer.mac_or_unix "brew install python3", "sudo apt-get install python3"
  end

  desc "Install tmux"
  task :tmux do
    system Installer.mac_or_unix(
      "brew install reattach-to-user-namespace; brew install tmux",
      ""
    )
  end
end
