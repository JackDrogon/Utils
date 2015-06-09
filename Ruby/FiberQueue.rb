#!/usr/bin/env ruby
# -*- coding:utf-8 -*-
  
# TODO: open Array and add empty? method

class FiberQueue
  # Logging severity.
  module Severity
    # Low-level information, mostly for developers.
    DEBUG = 0
    # Generic (useful) information about system operation.
    INFO = 1
    # A warning.
    WARN = 2
    # A handleable error condition.
    ERROR = 3
    # An unhandleable error that results in a program crash.
    FATAL = 4
    # An unknown message that should always be logged.
    UNKNOWN = 5
  end
  include Severity

  def initialize(*args)
    @stop = false
    @queue = Array.new(UNKNOWN, Array.new)
  end

  def add(fiber)
    @queue[fiber.priority] << fiber
  end

  def run()
    while @stop
      run_queue = @queue.select {|arr| arr[0]}
      fiber = run_queue.shift
      fiber.resume
      if fiber.alive?
        @queue[fiber.priority] << fiber
      end
    end
  end

  def stop()
    @stop = true
  end
end
