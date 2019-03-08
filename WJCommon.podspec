Pod::Spec.new do |s|

s.name         = "WJCommon"
s.version      = "2.0.2"
s.summary      = "iOS Objective-C,公共组件开发包"

s.description  = <<-DESC
    公共组件开发包
DESC

s.homepage     = "https://github.com/yunhaiwu"

s.license      = { :type => "MIT", :file => "LICENSE" }

s.author             = { "吴云海" => "halayun@qq.com" }

s.platform     = :ios, "6.0"

s.source       = { :git => "https://github.com/yunhaiwu/ios-wj-common.git", :tag => "#{s.version}" }

s.frameworks = "Foundation", "UIKit", "CoreGraphics"
s.exclude_files = "Example"

s.requires_arc = true


s.subspec 'Core' do |core|
    core.source_files = 'Classes/*.{h,m}'
    core.public_header_files = 'Classes/*.h'
end

s.subspec 'Utils' do |utils|
    utils.source_files = 'Classes/Utils/*'
    utils.public_header_files = 'Classes/Utils/*.h'
end

s.subspec 'UI' do |ui|
    ui.source_files = 'Classes/UI/*'
    ui.public_header_files = 'Classes/UI/*.h'

    ui.dependency 'WJCommon/Core'
    ui.dependency 'WJCommon/Utils'
    ui.dependency 'Masonry', '~> 1.0'
end

s.dependency "YYKit", '~> 1.0'
s.dependency "WJLoggingAPI", '~> 2.0'

end
