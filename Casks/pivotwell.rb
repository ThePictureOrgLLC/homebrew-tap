cask "pivotwell" do
  version "1.0.22"
  sha256 "2a76fa83a136a6ae27815334acbd622110ff1d9d2317391bc4ad1aa8ad3c9fc1"

  url "https://pictureorg-keys.thepictureorg.workers.dev/release/rotationcheck/ThePictureOrg-Pivotwell-Mac-#{version}.zip"
  name "Pivotwell Photo Rotation Check"
  desc "Finds sideways and upside-down photos and turns copies, never your originals"
  homepage "https://thepictureorg.com/pivotwell"

  livecheck do
    url "https://pictureorg-keys.thepictureorg.workers.dev/latest.json"
    strategy :json do |json|
      json["rotationcheck"]["version"]
    end
  end

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  installer script: {
    executable: "/bin/bash",
    args:       ["#{staged_path}/Install Pivotwell.app/Contents/Resources/launcher.sh", "--silent"],
  }

  uninstall script: {
    executable: "/bin/bash",
    args:       ["#{staged_path}/Uninstall Pivotwell.app/Contents/Resources/launcher.sh", "--silent"],
  }

  zap trash: [
    "~/Library/Application Support/ThePictureOrg/Pivotwell",
  ]

  caveats <<~EOS
    Pivotwell runs as a free 21-day trial. Buy a license key at https://thepictureorg.com/tools#buy
  EOS
end
