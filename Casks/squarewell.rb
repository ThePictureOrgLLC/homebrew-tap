cask "squarewell" do
  version "1.6.74"
  sha256 "13f6f2466bc46d5fbe73a9c25bcff60286863e0f4f61e03d68446942ac998a04"

  url "https://pictureorg-keys.thepictureorg.workers.dev/release/autocrop/ThePictureOrg-Squarewell-Mac-#{version}.zip"
  name "Squarewell Auto Crop & Straighten"
  desc "Finds every photo on a scan, straightens it and sets a clean crop"
  homepage "https://thepictureorg.com/squarewell"

  livecheck do
    url "https://pictureorg-keys.thepictureorg.workers.dev/latest.json"
    strategy :json do |json|
      json["autocrop"]["version"]
    end
  end

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  installer script: {
    executable: "/bin/bash",
    args:       ["#{staged_path}/Install Squarewell.app/Contents/Resources/launcher.sh", "--silent"],
  }

  uninstall script: {
    executable: "/bin/bash",
    args:       ["#{staged_path}/Uninstall Squarewell.app/Contents/Resources/launcher.sh", "--silent"],
  }

  zap trash: [
    "~/Library/Application Support/ThePictureOrg/Squarewell",
  ]

  caveats <<~EOS
    Squarewell runs as a free 21-day trial. Buy a license key at https://thepictureorg.com/tools#buy
  EOS
end
