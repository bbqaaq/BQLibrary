#
# Be sure to run `pod lib lint BQLibrary.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "BQLibrary"
  s.version          = "0.1.0"
  s.summary          = "A library provide shortcuts and easy ways of usage of IOS Libray."
  # s.description      = <<-DESC
  #                      An optional longer description of BQLibrary
  # 
  #                      * Markdown format.
  #                      * Don't worry about the indent, we strip it!
  #                      DESC
  s.homepage         = "https://github.com/bbqaaq/BQLibrary"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "CHAU WING WAI" => "bbqaaq@gmail.com" }
  s.source           = { :git => "https://github.com/bbqaaq/BQLibrary.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'Images' => ['Pod/Assets/*.png'],
    'Localization' => ['Pod/Assets/Localization/*.lproj']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation', 'AssetsLibrary'
  # s.dependency 'AFNetworking', '~> 2.3'
end
