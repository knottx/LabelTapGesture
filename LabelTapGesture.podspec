Pod::Spec.new do |spec|

  spec.name         = "LabelTapGesture"
  spec.version      = "0.0.1"
  spec.summary      = "An extension for setup UILabel with custom hyperlink styling, and interaction when tap on link."

  spec.homepage     = "https://knottovt.github.io"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       = { "Visarut Tippun" => "knotto.vt@gmail.com" }
  spec.source       = { :git => "https://github.com/knottovt/LabelTapGesture.git", :tag => "#{spec.version}" }
  
  spec.swift_version   = "5.1"
  spec.ios.deployment_target = "10.0"
  spec.source_files  = "LabelTapGesture/**/*.swift"
  spec.requires_arc  = true

end
