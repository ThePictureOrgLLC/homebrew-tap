cask "datewell" do
  version "1.6.34"
  sha256 "fad0ac265f6a83a3074ca8efc11a61e36e16abd9f1f2f89dadae078e421a3a44"

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
