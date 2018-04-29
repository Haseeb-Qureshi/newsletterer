require 'faraday'
require 'pry'
require 'yaml'

raise "Must add a filename as an argument" unless ARGV[0]
yaml = YAML.load(File.read(ARGV[0]))
output = []

output.push("<h2>#{yaml["title"]}</h2>")
output.push("<br />")

yaml["links"].each do |link|
  title = Faraday.get(link["link"]).body.scan(/<title>(.+)<\/title>/)[0][0]

  output.push("<a href=\"#{link["link"]}\" target=\"_blank\"><u><strong>#{title}</strong></u></a><br />")
  output.push(link["subtitle"] + "<br />")
  output.push("<br />")
end

File.write("output#{Time.now}.html", output.join("\n"))
