# Rendered by .github/workflows/release.yml; placeholders are filled per tag.
class Cctop < Formula
  desc "btop-style live dashboard for Claude Code internals, in a pane beside your session"
  homepage "https://github.com/tomstagl/cctop"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tomstagl/cctop/releases/download/v0.6.0/cctop-0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "73de447d82ea3859031e243c41c66812dbd110f81b06ef4cfab3f5d3888501c3"
    else
      url "https://github.com/tomstagl/cctop/releases/download/v0.6.0/cctop-0.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "20e41c9561d23454ed63887488cc018994189a4997cc78cbe35f86fa52d89134"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tomstagl/cctop/releases/download/v0.6.0/cctop-0.6.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8535cb09b143e0b69cf55c0521eb01aa830a47f9108c7f6d00897f16b97f0a58"
    else
      url "https://github.com/tomstagl/cctop/releases/download/v0.6.0/cctop-0.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d66a90aad981cf2293a8d3d19e708c54dc653869c1b0dd0027a1c41e9d0b9ecc"
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
