`ls`.split("\n").select{|name| name =~ /.mp3$/}.each do |name|
  artist, _, title = name.split("-")
  File.rename(name, artist + " - " + title + ".mp3");
end
