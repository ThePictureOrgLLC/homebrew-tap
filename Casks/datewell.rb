cask "datewell" do
  version "1.6.39"
  sha256 "7ae5268fde7b69c3d2c354ca09cb11b4c2c2f274d3a2658a4fd0903a770da9d6"

  url "https://pictureorg-keys.thepictureorg.workers.dev/release/datewell/ThePictureOrg-Datewell-Mac-#{version}.zip"
  name "Datewell"
  desc "Sets each photo's Date Taken from the date in its file name, a camera date stamp or a date printed on the border"
  homepage "https://thepictureorg.com/datewell"

  livecheck do
    url "https://pictureorg-keys.thepictureorg.workers.dev/latest.json"
    strategy :json do |json|
      json["datewell"]["version"]
    end
  end

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  installer script: {
    executable: "/bin/bash",
    args:       ["#{staged_path}/Install Datewell.app/Contents/Resources/launcher.sh", "--silent"],
  }

  uninstall script: {
    executable: "/bin/bash",
    args:       ["#{staged_path}/Uninstall Datewell.app/Contents/Resources/launcher.sh", "--silent"],
  }

  zap trash: [
    "~/Library/Application Support/ThePictureOrg/Datewell",
  ]

  caveats <<~EOS
    Datewell runs as a free 21-day trial. Buy a license key at https://thepictureorg.com/tools#buy
  EOS
end
