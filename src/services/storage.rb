# frozen_string_literal: true

class Storage
  def save(path, data)
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, JSON.pretty_generate(data))
  end

  def load(path)
    return {} unless File.exist?(path)

    JSON.parse(File.read(path))
  end
end
