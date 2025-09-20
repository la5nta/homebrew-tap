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

  test do
    system "#{bin}/voacapl", "--version"
  end
end
