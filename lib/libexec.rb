# frozen_string_literal: true

def spawn(exec, *argv)
  libexec_dir = File.realpath(File.join(__dir__, "..", "libexec", "quran-audio"))
  Process.spawn File.join(libexec_dir, exec), *argv
end

def wait(pid)
  Process.wait(pid)
rescue Interrupt
  retry
end
