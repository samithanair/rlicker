module Given
  def given(name_and_value)
    File.open(File.expand_path(name_and_value.keys.first),"w+") do |file|
      file.puts name_and_value[name_and_value.keys.first]
    end
  end
end
