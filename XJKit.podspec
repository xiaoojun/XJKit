

Pod::Spec.new do |s|



s.name         = "XJKit"
s.version      = "1.0.1"
s.summary      = "a simple development tools"

s.description  = <<-DESC
a simple development tools for iOS
DESC

s.homepage     = "https://github.com/xiaoojun/XJKit"

s.license      = "MIT"


s.author             = { "汤小军" => "961721716@qq.com" }
s.platform     = :ios, "8.0"


s.source       = { :git => "https://github.com/xiaoojun/XJKit.git", :tag => "#{s.version}" }


s.source_files  = "XJKit/*.{h,m}"

s.framework  = "UIKit"
s.dependency  'Masonry'
s.requires_arc = true



end
