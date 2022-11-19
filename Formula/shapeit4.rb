class Shapeit4 < Formula
  desc "Segmented HAPlotype Estimation and Imputation Tool"
  homepage "https://odelaneau.github.io/shapeit4/"
  url "https://github.com/odelaneau/shapeit4/archive/refs/tags/v4.2.2.tar.gz"
  sha256 "9f109e307b5cc22ab68e7bf77de2429a9bbb2212d66303386e6a3dd81a5bc556"
  license "MIT"

  depends_on "boost"
  depends_on "htslib"

  def install
    system "sed -i'' -e 's/setiosflags/std::setiosflags/g' src/utils/string_utils.h"
    system "sed -i'' -e 's/setiosflags/std::setiosflags/g' tools/bingraphsample/src/utils/string_utils.h"

    system "make HTSLIB_LIB=\"-lhts\" BOOST_LIB_IO=\"-lboost_iostreams\" \
            BOOST_LIB_PO=\"-lboost_program_options\" DYN_LIBS=\"\""
    mkdir(bin)
    cp("bin/shapeit4.2", "#{bin}/shapeit4")
  end

  test do
    system "#{bin}/shapeit4", "--help"
  end
end
