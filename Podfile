post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      xcconfig_path = config.base_configuration_reference.real_path
      xcconfig = File.read(xcconfig_path)
      new_xcconfig = xcconfig.gsub('-l"sqlite3"', '')
      File.open(xcconfig_path, "w") { |file| file << new_xcconfig }
    end
  end
end