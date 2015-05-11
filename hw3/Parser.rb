class Parser
  def parse(file, separator = nil)
    lines = []
    File.open(file, "r") do |file_handle|
      file_handle.each_line do |server|
        if /#.*/.match(server) or /$^/.match(server) #skip comments and empty lines
          next
        end
        if (!separator.nil?)
          server =  server.split(';')
        end
        lines.push(server)
      end
    end
    lines
  end
end
