# Rendered by .github/workflows/release.yml; placeholders are filled per tag.
class Cctop < Formula
  desc "btop-style live dashboard for Claude Code internals, in a pane beside your session"
  homepage "https://github.com/tomstagl/cctop"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tomstagl/cctop/releases/download/v0.3.0/cctop-0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "b7f428aa1fb5c7e25f68427017280e1141c61affe1f8bef5939db24f3813bef0"
    else
      url "https://github.com/tomstagl/cctop/releases/download/v0.3.0/cctop-0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "8070248d3ca3a114293c2e655c778bf7934165c80ee4d8f773d5c72efbb63dc9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tomstagl/cctop/releases/download/v0.3.0/cctop-0.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ad4b440e711a337ee048a6adc1d5a226d1eb5e68fb9ebfeabb06930398486f5c"
    else
      url "https://github.com/tomstagl/cctop/releases/download/v0.3.0/cctop-0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "10cc4516661271be03f110ad43ef1e249b00e71837e678561f3169bbc099f37f"
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
