#!/usr/bin/env ruby
# -*- coding:utf-8 -*-

require 'thread'

class ThreadPool
  attr_reader :thread_num
  def initialize(thread_num)
    @thread_num = thread_num
    @task_queue = Queue.new
    @stop = false
    @threads = thread_num.times.map {
      Thread.new {
        while @stop
          task = @task_queue.pop
          task.call
        end
      }
    }
  end

  def join()
    @threads.each {|thread| thread.join}
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
