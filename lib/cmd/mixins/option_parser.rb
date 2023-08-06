# frozen_string_literal: true

require "optparse"
require "ryo"

module Cmd::OptionParser
  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods
    def set_banner(usage:, description:)
      banner.usage = usage
      banner.description = description
    end

    def set_option(short, long, desc, *rest)
      option_parser.on(short, long, desc, *rest)
    end

    def set_default(defaults)
      @defaults = Ryo.from(defaults)
    end

    def option_parser
      @option_parser ||= ::OptionParser.new(nil, 26, " " * 2).tap { _1.banner = "" }
    end

    def banner
      @banner ||= Ryo({})
    end

    def defaults
      @defaults || {}
    end
  end

  def parse!(argv)
    options = Ryo.from(self.class.defaults)
    option_parser.on("-h", "--help", "Show help") { options.h = options.help = true }
    option_parser.parse(argv, into: options)
    options
  end

  def show_help(io = $stdout)
    banner = self.class.banner
    io.puts "Usage: #{banner.usage}\n\n" \
            "Description:\n  #{banner.description}\n\n" \
            "Options: #{option_parser.help}\n"
  end

  def option_parser
    self.class.option_parser
  end
end
