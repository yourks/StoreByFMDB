Pod::Spec.new do |s|

  s.name         = 'YKStroreFMDB'
  s.version      = '1.0.0'
  s.summary      = 'A text for iOS.'

  s.homepage     = 'http://blog.csdn.net/codingfire/article/details/52470802'



  s.license      = "Apache License, Version 2.0"

  s.author       = { 'codeliu6572' => 'codeliu6572@163.com' }

  s.source       = { :git => 'https://github.com/yourks/StoreByFMDB.git', :tag => '1.0.0' }



  s.source_files  = 'YKStroreFMDB/YKStroreFMDB/*.{h,m}'


  s.framework  = 'UIKit'
  s.requires_arc = true

  s.public_header_files = 'YKStroreFMDB/YKStroreFMDB/Header.h'
  s.source_files = 'YKStroreFMDB/YKStroreFMDB/Header.h' 

  s.dependency 'FMDB'
end

