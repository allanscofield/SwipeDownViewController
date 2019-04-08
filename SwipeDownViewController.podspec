Pod::Spec.new do |s|

    s.platform = :ios
    s.ios.deployment_target = '10.0'
    s.name = "SwipeDownViewController"
    s.summary = "SwipeDownViewController lets a user dismiss a ViewController using a swipe down gesture."
    s.requires_arc = true
    s.version = "0.1.0"
    s.license = { :type => "MIT", :file => "LICENSE" }
    s.author = { "Allan Scofield" => "appvs@icloud.com" }
    s.homepage = "https://github.com/allanscofield/SwapDownViewController"
    s.source = { :git => "https://github.com/allanscofield/SwapDownViewController.git", :tag => "#{s.version}" }
    s.framework = "UIKit"
    s.source_files = "SwipeDownViewController/Sources/*.{swift}"
    s.swift_version = "4.2"
end
