Pod::Spec.new do |s|

  s.name         = "LHCarouseTools"
  s.version      = "0.0.1"
  s.summary      = "三张UIImageView实现无限轮播，可加载本地和网络图片，点击图片可触发回调"
  s.description  = <<-DESC
                    三张UIImageView实现无限轮播，可加载本地和网络图片，点击图片可触发回调
  s.homepage     = "https://github.com/LHCoder2016/LHCarouseTools"
  s.license      = "MIT"
  s.author             = { "刘虎" => "517829514@qq.com" }
  s.source       = { :git => "https://github.com/LHCoder2016/LHCarouseTools.git", :tag => "0.0.1" }
  s.source_files  = "LHCarouseTools", "LHCarouseTools/LHCarouselToolsDemo/LHCarouselToolsDemo/LHCarouselTools/LHCarouselTools{h,m}"
  s.framework  = "SDWebImage"
  s.requires_arc = true
  s.ios.deployment_target = '8.0'

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
