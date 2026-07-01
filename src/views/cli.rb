# frozen_string_literal: true

class Cli
  def ask(msg = '')
    puts "VIKTOR: #{msg}" unless msg.empty?
    print '>>> '
    gets.chomp.strip
  end

  def say(msg)
    puts "VIKTOR: #{msg}"
  end

  def yes?(msg)
    %w[y yes].include?(ask(msg).downcase)
  end

  def menu(options, actions)
    options.each_with_index { |opt, i| puts "[#{i}] #{opt}" }
    actions[ask.to_i]&.call || say('Invalid option.')
  end
end
