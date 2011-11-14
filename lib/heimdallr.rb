require "heimdallr/version"
require "open3"

module Heimdallr
  class Monitor
    RTP_REGEX = /^\s+([.\d]+)\s+(\d+)\s+([.\d]+)\s+(\d+)\s+(0x[0-9A-F]+)\s+(.*)\s+(\d+)\s+(\d+)\s+\(([.\d]+)%\)\s+([.\d]+)\s+([.\d]+)\s+([.\d]+)/
    RTP_CMD = "tshark -qp -o rtp.heuristic_rtp:TRUE -z rtp,streams -l"

    def initialize(opts)
      @tmp_file = "/tmp/heimdallr_dump"
      @opts     = opts
    end

    def run_dumper
      cmd = command
      puts "Running '#{cmd}'..."
      r, w = IO.pipe
      @dumper_pid = spawn(cmd, :err => w)
      w.close
      r.each("\n\r") do |line|
        res = line.scan(/File: (\S+)/)
        raise line unless res.length == 1
        rtp_analysis(res.first.first) 
      end
    end

    def rtp_analysis(filename)
      puts "RTP analyis of: #{filename}"
      r, w = IO.pipe
      @dumper_pid = spawn("#{RTP_CMD} -r '#{filename}'", :out => w)
      w.close
      r.each do |line|
        res = line.scan(RTP_REGEX).flatten
        next unless res.length == 12
        puts res.inspect  
      end
    end

    def kill_dumper
      Process.kill("KILL", @dumper_pid) if @dumper_pid
    end

    private 

    def spawn(*args)
      Process.spawn(*args)
    end

    def command
      cmd = "dumpcap -b duration:#{@opts[:d]} -b files:5 -f '#{@opts[:f]}' " +
        "-s 0 -w '#{@tmp_file}'"
      cmd += " -i #{@opts[:i]}" if @opts[:i]
    end
  end
end
