cask "sortwell" do
  version "1.6.25"
  sha256 "6bd7e7b3cbfd4821c13e823b3cb3191acc50249f3950a89d53c4f7c31c67a3ac"

  url "https://pictureorg-keys.thepictureorg.workers.dev/release/sortwell/ThePictureOrg-Sortwell-Mac-#{version}.zip"
  name "Sortwell Batch Sorter"
  desc "Finds the divider cards in a folder of scans, reads the date, number and subject on each, and moves every batch into its own folder"
  homepage "https://thepictureorg.com/sortwell"

  livecheck do
    url "https://pictureorg-keys.thepictureorg.workers.dev/latest.json"
    strategy :json do |json|
      json["sortwell"]["version"]
    end
  end

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  installer script: {
    executable: "/bin/bash",
    args:       ["#{staged_path}/Install Sortwell.app/Contents/Resources/launcher.sh", "--silent"],
  }

  uninstall script: {
    executable: "/bin/bash",
    args:       ["#{staged_path}/Uninstall Sortwell.app/Contents/Resources/launcher.sh", "--silent"],
  }

  zap trash: [
    "~/Library/Application Support/ThePictureOrg/Sortwell",
  ]

  caveats <<~EOS
    Sortwell runs as a free 21-day trial. Buy a license key at https://thepictureorg.com/tools#buy
  EOS
end
