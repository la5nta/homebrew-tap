class Pat < Formula
  desc "Send and receive email over Winlink"
  homepage "https://github.com/la5nta/pat"
  url "https://github.com/la5nta/pat.git", tag: "v0.19.1"
  license "MIT"
  head "https://github.com/la5nta/pat.git", branch: "develop"

  livecheck do
    strategy :github_latest
  end

  depends_on "go" => ">=1.24"

  def install
    git_rev = Utils.git_short_head

    ldflags = %W[
      -X github.com/la5nta/pat/internal/buildinfo.GitRev=#{git_rev}
    ]

    system "go", "build", *std_go_args(ldflags: ldflags)
  end

  test do
    assert_match "Pat v#{version}", shell_output("#{bin}/pat version")
  end

  service do
    run [opt_bin/"pat", "http"]
    keep_alive true
    log_path var/"log/pat.log"
    error_log_path var/"log/pat.log"
  end
end
