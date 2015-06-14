#!/usr/bin/env ruby
# -*- coding:utf-8 -*-

require 'thread'

class ThreadPool
  attr_reader :thread_num
  def initialize(thread_num = 3)
    @thread_num = thread_num
    @task_queue = Queue.new
    @stop = false
    @threads = thread_num.times.map {
      Thread.new {
        until @stop
          task = @task_queue.pop
          task.call
        end
        sleep 10
      }
    }
  end

  def join()
    # @threads.each {|thread| thread.join}
    # puts @threads
    @threads.each { |thread|
      puts thread.join
      # if thread.alive?
        # begin
        #   thread.join
          # puts e.message
          # puts e.backtrace.inspect
          # Rescue
        # end
      # else
        # puts "Thread: #{thread}, dead!"
      # end
    }
  end

  def add_task(task)
    @task_queue << task
  end

  def stop()
    @stop = true
  end

  def stop!()
    @stop = true
    @threads.each {|thread| thread.raise}
  end
end

if __FILE__ == $0
  puts "Haha"
  t = ThreadPool.new
  10.times {
    t.add_task Proc.new {
      # for i in 1..10000
      #   puts i
      # end
      puts "Hahah"
    }
  }
  t.add_task Proc.new {
    puts "Nimei"
  }
  t.join
end
