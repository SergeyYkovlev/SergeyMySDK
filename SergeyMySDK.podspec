Pod::Spec.new do |s|
  s.name         = 'SergeyMySDK'
  s.version      = '0.2.1'
  s.summary      = 'A brief summary of SergeyMySDK.'
  s.description  = <<-DESC
                    A longer description of SergeyMySDK in more detail.
                    DESC
  s.homepage     = 'https://github.com/SergeyYkovlev/SergeyMySDK'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Sergey Yakovlev' => 'yakovlevserg09@gmail.com' }
  s.source       = { :git => 'https://github.com/SergeyYkovlev/SergeyMySDK.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.source_files  = 'MySDK/**/*.{swift,h,m}'
  s.frameworks    = 'UIKit'
  s.swift_versions = ['5.0']
end
