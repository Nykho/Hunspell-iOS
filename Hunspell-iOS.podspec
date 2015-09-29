Pod::Spec.new do |s|
  s.name             = "Hunspell-iOS"
  s.version          = "1.3.3"
  s.summary          = "Port of Hunspell library to iOS."
  s.description      = <<-DESC
                       Hunspell is the spell checker of LibreOffice, OpenOffice.org, Mozilla Firefox 3 & Thunderbird, Google Chrome, and it is also used by proprietary software packages, like Mac OS X, InDesign, memoQ, Opera and SDL Trados.
                       DESC
  s.homepage         = "https://github.com/Nykho/"
  s.license          = 'GPL/LPLG/MPL'
  s.author           = { "idk" => "idk@idk.com" }
  s.source           = { :git => "https://github.com/Nykho/Hunspell-iOS.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Hunspell/Engine/*'
  s.resources = ['Hunspell/Engine/dictionaries/*']
  s.public_header_files = "Hunspell/Engine/SpellChecker.h"

  s.frameworks = 'Foundation'
  s.library = 'c++'
end
