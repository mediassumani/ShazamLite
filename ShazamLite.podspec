Pod::Spec.new do |spec|

  spec.name         = "ShazamLite"
  spec.version      = "1.0.0"
  spec.swift_version = "4.2"
  spec.summary      = "An asynchronous, easy-to-use, and rapid HTTP Networking framework for iOS."
  spec.description  = "ShazamLite is Networking framework built on top of URLSession that provides custom request building, response assessing, and error handling as well as custom JSON Decoding."
  spec.homepage     = "https://github.com/MediBoss/ShazamLite"
  spec.license      = "MIT"
  spec.author = { "Medi Assumani" => "mediassumani49@gmail.com" }
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/MediBoss/ShazamLite.git", :tag => "1.0.0" }
  spec.source_files  = "Shazam/Shazam/Source/**.swift"
end