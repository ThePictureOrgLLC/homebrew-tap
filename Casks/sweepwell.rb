cask "sweepwell" do
  version "1.1.9"
  sha256 "92ae4970cec8594387549a75575c711bb40cc693ffa996330dad16ddfa3691b3"

  url "https://pictureorg-keys.thepictureorg.workers.dev/release/sweepwright/ThePictureOrg-Sweepwell-Mac-#{version}.zip"
  name "Sweepwell Empty Folder Cleaner"
  desc "Finds and removes empty folders on photo drives, with a preview and a log"
  homepage "https://thepictureorg.com/sweepwell"

  livecheck do
    url "https://pictureorg-keys.thepictureorg.workers.dev/latest.json"
    strategy :json do |json|
      json["sweepwright"]["version"]
    end
  end

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "Sweepwell/Sweepwell.app", target: "ThePictureOrg/Sweepwell.app"
  artifact "Sweepwell/Lightroom Plug-in/PictureOrgEmptyFolderCleaner.lrplugin",
           target: "~/Library/Application Support/Adobe/Lightroom/Modules/PictureOrgEmptyFolderCleaner.lrplugin"

  zap trash: [
    "~/Library/Application Support/ThePictureOrg/Sweepwell",
  ]
end
