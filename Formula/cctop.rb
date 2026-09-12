# Rendered by .github/workflows/release.yml; placeholders are filled per tag.
class Cctop < Formula
  desc "btop-style live dashboard for Claude Code internals, in a pane beside your session"
  homepage "https://github.com/tomstagl/cctop"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tomstagl/cctop/releases/download/v0.1.0/cctop-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "2d7154d148b438061fe61eed6dba76529e8bc942cb69f4ad49bfa66eca6bb22a"
    else
      url "https://github.com/tomstagl/cctop/releases/download/v0.1.0/cctop-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "de5475e9e9416aadc8b83d9190f21f08695cd0e06add30cbb6301288dd3205c3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tomstagl/cctop/releases/download/v0.1.0/cctop-0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e0ff975b181e0e40e4062a9372949cc592e3bbf6fe5a7142a72f0d34943b6aa7"
    else
      url "https://github.com/tomstagl/cctop/releases/download/v0.1.0/cctop-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "16ba869d17fc2e31b5607cacf850ca5ed488d32f7c20fe36c205dc6cd262efaf"
    end
  end

  def install
    bin.install "cctop"
    pkgshare.install "plugin"
  end

  def caveats
    <<~EOS
      Claude Code plugin (adds /cctop and cctop-insights):
        claude plugin add #{pkgshare}/plugin
      Optional, for exact rate limits and tool timings:
        cctop install
    EOS
  end

  test do
    assert_match "cctop", shell_output("#{bin}/cctop --version")
    assert_match "cache_hit_ratio", shell_output("#{bin}/cctop query explain cache_hit_ratio")
  end
end
