# Copied from Ruby Performance Optimization by Alexander Dymo
# https://pragprog.com/book/adrpo/ruby-performance-optimization

module DevTools
  class Measure
    def self.run(*args, &block)
      new(*args, &block).run
    end

    #--------------------------------------------------------------------------
    def initialize(tag = nil, gc: :disabled, &block)
      @tag = tag
      @gc_enabled = (gc == :enabled)
      @block = block
    end

    def run
      GC.start
      GC.disable unless @gc_enabled

      @memory_before  = `ps -o rss= -p #{Process.pid}`.to_i / 1024
      @gc_stat_before = GC.stat

      @sql_requests_count = 0
      ActiveSupport::Notifications.subscribe 'sql.active_record' do |*args|
        event = ActiveSupport::Notifications::Event.new(*args)
        @sql_requests_count += 1
      end

      @time = Benchmark.realtime(&@block)

      @gc_stat_after = GC.stat
      @memory_after  = `ps -o rss= -p #{Process.pid}`.to_i / 1024
      GC.enable

      puts(
        RUBY_VERSION => {
          tag: @tag,
          gc: (@gc_enabled ? 'enabled' : 'disabled'),
          time: @time.round(2),
          gc_count: diff(:count),
          memory: "%d MB" % (@memory_after - @memory_before),
          sql_requests: @sql_requests_count,
          object_allocations: diff(:total_allocated_objects)
        }.to_json)
    end

    def diff(key)
     @gc_stat_after[key].to_i - @gc_stat_before[key].to_i
    end
  end
end
