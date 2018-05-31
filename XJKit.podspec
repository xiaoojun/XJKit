#
#  Be sure to run `pod spec lint DJKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

# ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  These will help people to find your library, and whilst it
#  can feel like a chore to fill in it's definitely to your advantage. The
#  summary should be tweet-length, and the description more in depth.
#

s.name         = "XJKit"
s.version      = "0.0.2"
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
s.requires_arc = true



end
