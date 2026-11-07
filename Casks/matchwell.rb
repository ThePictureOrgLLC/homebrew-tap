cask "matchwell" do
  version "1.6.28"
  sha256 "bf7554c4adabbc0b421c7a98b4f37e1a83cbb7595f44884c3d96c4a464ce143b"

  url "https://pictureorg-keys.thepictureorg.workers.dev/release/matchwell/ThePictureOrg-Matchwell-Mac-#{version}.zip"
  name "Matchwell Photo Deduplicator"
  desc "Finds duplicate photos, keeps the best copy and merges keywords, people, captions and ratings from the others"
  homepage "https://thepictureorg.com/matchwell"

  livecheck do
    url "https://pictureorg-keys.thepictureorg.workers.dev/latest.json"
    strategy :json do |json|
      json["matchwell"]["version"]
    end
  end

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  installer script: {
    executable: "/bin/bash",
    args:       ["#{staged_path}/Install Matchwell.app/Contents/Resources/launcher.sh", "--silent"],
  }

  uninstall script: {
    executable: "/bin/bash",
    args:       ["#{staged_path}/Uninstall Matchwell.app/Contents/Resources/launcher.sh", "--silent"],
  }

  zap trash: [
    "~/Library/Application Support/ThePictureOrg/Matchwell",
  ]

  caveats <<~EOS
    Matchwell runs as a free 21-day trial. Buy a license key at https://thepictureorg.com/tools#buy
  EOS
end
