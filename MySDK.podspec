Pod::Spec.new do |s|
  s.name         = 'MySDK'
  s.version      = '0.1.0'
  s.summary      = 'A brief summary of MySDK.'
  s.description  = <<-DESC
                    A longer description of MySDK in more detail.
                    DESC
  s.homepage     = 'https://github.com/SergeyYkovlev/MySDK'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Sergey Yakovlev' => 'yakovlevserg09@gmail.com' }
  s.source       = { :git => 'https://github.com/SergeyYkovlev/MySDK.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.source_files  = 'MySDK/**/*.{swift,h,m}'
  s.frameworks    = 'UIKit'
  s.swift_versions = ['5.0']
end
