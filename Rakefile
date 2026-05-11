require 'rake'

# Files/dirs that should NOT be symlinked as ~/.<name>.
# `claude/` is handled specially below — we symlink individual entries
# into ~/.claude/ instead of clobbering the whole live directory.
SKIP = %w[Rakefile README.md README.rdoc LICENSE CLAUDE.md id_dsa.pub claude .git .gitignore .DS_Store].freeze

# Paths inside the repo's claude/ dir that get linked into ~/.claude/.
# Add new entries here as you decide to track more Claude config.
CLAUDE_LINKS = %w[
  settings.json
  commands/build-cli.md
].freeze

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  Dir['*'].each do |file|
    next if SKIP.include? file

    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      if replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file}"
        end
      end
    else
      link_file(file)
    end
  end

  install_claude
end

desc "symlink tracked claude/ entries into ~/.claude/"
task :claude do
  install_claude
end

def install_claude
  CLAUDE_LINKS.each do |rel|
    src  = File.join(Dir.pwd, 'claude', rel)
    dest = File.join(ENV['HOME'], '.claude', rel)

    unless File.exist?(src)
      puts "claude: missing source #{src}, skipping"
      next
    end

    FileUtils.mkdir_p(File.dirname(dest))

    if File.symlink?(dest) && File.readlink(dest) == src
      puts "claude: ~/.claude/#{rel} already linked"
      next
    end

    if File.exist?(dest) || File.symlink?(dest)
      print "overwrite ~/.claude/#{rel}? [yn] "
      case $stdin.gets.chomp
      when 'y'
        File.delete(dest)
      else
        puts "skipping ~/.claude/#{rel}"
        next
      end
    end

    puts "linking ~/.claude/#{rel}"
    File.symlink(src, dest)
  end
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end
