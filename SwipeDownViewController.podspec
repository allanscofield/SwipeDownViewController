Pod::Spec.new do |s|

    s.platform = :ios, :tvos
    s.ios.deployment_target = '10.0'
    s.tvos.deployment_target = '11.0'
    s.name = "SwipeDownViewController"
    s.summary = "SwipeDownViewController lets a user dismiss a ViewController using a swipe down gesture."
    s.requires_arc = true
    s.version = "0.1.2"
    s.license = { :type => "MIT", :file => "LICENSE" }
    s.author = { "Allan Scofield" => "appvs@icloud.com" }
    s.homepage = "https://github.com/allanscofield/SwapDownViewController"
    s.source = { :git => "https://github.com/allanscofield/SwapDownViewController.git", :tag => "#{s.version}" }
    s.framework = "UIKit"
    s.source_files = "SwipeDownViewController/Sources/*.{swift}"
    s.swift_version = "5.0"
end
