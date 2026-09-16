# Rendered by .github/workflows/release.yml; placeholders are filled per tag.
class Cctop < Formula
  desc "btop-style live dashboard for Claude Code internals, in a pane beside your session"
  homepage "https://github.com/tomstagl/cctop"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tomstagl/cctop/releases/download/v0.5.0/cctop-0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "f2937ce1fa3ac8398cba22a8ed6f6836836b7991b008d9cc4c03c1bf92c00e74"
    else
      url "https://github.com/tomstagl/cctop/releases/download/v0.5.0/cctop-0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "095480768abd03c8954179dd858ce90de60bf8c5a5d7ef8b4a94b45db2a8ac8a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tomstagl/cctop/releases/download/v0.5.0/cctop-0.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3c565ab323848147f577905a3dd75351acb3cf88348e7b31a09b03d80edfed2b"
    else
      url "https://github.com/tomstagl/cctop/releases/download/v0.5.0/cctop-0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dac4db271468272e893c5a9720c8bf7935ffc7e43322a46e2b073e4e529a3e5a"
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
