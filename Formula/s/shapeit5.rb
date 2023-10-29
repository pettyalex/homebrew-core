class Shapeit5 < Formula
  desc "Segmented HAPlotype Estimation and Imputation Tool"
  homepage "https://odelaneau.github.io/shapeit5/"
  # url "https://github.com/odelaneau/shapeit5/archive/refs/tags/v5.1.1.tar.gz"
  # sha256 "ccd250c5ddcab002f7551b6d4bf4135fc7375fea2c9646dd91e51afd97039555"
  url "https://github.com/belowlab/shapeit5.git",
      revision: "0f36fab9f2fbd126ca1ee39616df8311a87083a7"
  version "v5.1.1"
  head "https://github.com/odelaneau/shapeit5.git", branch: "master"
  license "MIT"

  depends_on "boost"
  depends_on "htslib"

  # Patch to enable Mac OS and ARM support
  # Has been submitted upstream: https://github.com/odelaneau/shapeit5/pull/68
  # patch do
  #   url "https://patch-diff.githubusercontent.com/raw/odelaneau/shapeit5/pull/68.patch"
  #   sha256 "d0099897271065d6a6a95f3775cdde4a7337e0138601bde41c4745d0d8f93b4a"
  # end

  def install

    # inreplace "xcftools/src/utils/xcf.h", 
    #   "#include <iomanip>\n", "#include <iomanip>\n#include <map>\n"

    # Missing include for <map> in xcftools/src/utils/xcf.h
    system "sed -i '' '32 a\\
#include <map>' xcftools/common/src/utils/xcf.h "


    chdir "phase_common" do
      system "make mac_apple_silicon"
    end

    chdir "phase_rare" do
      system "make mac_apple_silicon"
    end

    chdir "switch" do
      system "make mac_apple_silicon"
    end

    chdir "ligate" do
      system "make mac_apple_silicon"
    end

    chdir "simulate" do
      system "make mac_apple_silicon"
    end

    mkdir(bin)
    cp("phase_common/bin/phase_common_mac", "#{bin}/SHAPEIT5_phase_common")
    cp("phase_rare/bin/phase_rare_mac", "#{bin}/SHAPEIT5_phase_rare")
    cp("switch/bin/switch_mac", "#{bin}/SHAPEIT5_switch")
    cp("ligate/bin/ligate_mac", "#{bin}/SHAPEIT5_ligate")
    cp("simulate/bin/simulate_mac", "#{bin}/SHAPEIT5_simulate")

  end

  test do
    system "#{bin}/SHAPEIT5_phase_common", "--help"
    system "#{bin}/SHAPEIT5_phase_rare", "--help"
    system "#{bin}/SHAPEIT5_switch", "--help"
    system "#{bin}/SHAPEIT5_ligate", "--help"
    system "#{bin}/SHAPEIT5_simulate", "--help"
  end
end
