# Rendered by .github/workflows/release.yml; placeholders are filled per tag.
class Cctop < Formula
  desc "btop-style live dashboard for Claude Code internals, in a pane beside your session"
  homepage "https://github.com/tomstagl/cctop"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tomstagl/cctop/releases/download/v0.2.0/cctop-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "179b3b89534cee981ee295d4bdf8dc4b1a6e1178a64b6579bb3d0a542286b6ae"
    else
      url "https://github.com/tomstagl/cctop/releases/download/v0.2.0/cctop-0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "fed1d59008843c30cfb65f3bd510cc446225ca335a8312b66eabd82eebdcfce1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tomstagl/cctop/releases/download/v0.2.0/cctop-0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b44112ed2f211b58b3acd6085ad1bf3c68320ef07e40dce20e9d8e6d9b6f62fd"
    else
      url "https://github.com/tomstagl/cctop/releases/download/v0.2.0/cctop-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7d300a4ace047d4a5e720b64c470cd919b78196376a6aaf47b377382a040ecb6"
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
