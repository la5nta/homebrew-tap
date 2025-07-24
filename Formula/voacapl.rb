class Voacapl < Formula
  desc "A port of VOACAP for Linux"
  homepage "https://github.com/jawatson/voacapl"
  url "https://github.com/jawatson/voacapl.git", tag: "v.0.7.6"
  head "https://github.com/jawatson/voacapl.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "gcc" # for gfortran

  def install
    # Build and install the main application
    ENV.deparallelize
    system "autoreconf", "-fvi"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  def caveats
    <<~EOS
      To complete the installation, you must run the setup script:
        makeitshfbc

      This will create the necessary data files in ~/itshfbc.

      After setup, you must provide the path to the data directory as the
      first argument. For example:
        voacapl --run-dir=. ~/itshfbc input.dat output.out
    EOS
  end

  test do
    system "true"
  end
end
