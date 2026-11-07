cask "spoolwell" do
  version "1.16.8"
  sha256 "f4c61e294d2d63614e728b977cfea9884a639f216a03758631db6f2d1d23864b"

  url "https://pictureorg-keys.thepictureorg.workers.dev/release/toolbox/ThePictureOrg-Spoolwell-Mac-#{version}.zip"
  name "Spoolwell Video Finishing Toolbox"
  desc "Checks, merges, trims, splits, titles and re-dates captured VHS, Hi8 and MiniDV video while keeping picture and sound in sync"
  homepage "https://thepictureorg.com/spoolwell"

  livecheck do
    url "https://pictureorg-keys.thepictureorg.workers.dev/latest.json"
    strategy :json do |json|
      json["toolbox"]["version"]
    end
  end

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  installer script: {
    executable: "/bin/bash",
    args:       ["#{staged_path}/MediaToolbox-Mac/Install Spoolwell Video Toolbox.app/Contents/Resources/launcher.sh", "--silent"],
  }

  uninstall script: {
    executable: "/bin/bash",
    args:       ["#{staged_path}/MediaToolbox-Mac/Uninstall Spoolwell Video Toolbox.app/Contents/Resources/launcher.sh", "--silent"],
  }

  zap trash: [
    "~/Library/Application Support/ThePictureOrg/Spoolwell",
  ]

  caveats <<~EOS
    Spoolwell runs as a free 21-day trial. Buy a license key at https://thepictureorg.com/tools#buy
  EOS
end
