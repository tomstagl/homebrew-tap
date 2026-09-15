# Rendered by .github/workflows/release.yml; placeholders are filled per tag.
class Cctop < Formula
  desc "btop-style live dashboard for Claude Code internals, in a pane beside your session"
  homepage "https://github.com/tomstagl/cctop"
  version "0.3.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tomstagl/cctop/releases/download/v0.3.1/cctop-0.3.1-aarch64-apple-darwin.tar.gz"
      sha256 "87720e5b6faf3e566e1168751d850e5c6c90550197d8db11ea4d9e8b6ee85698"
    else
      url "https://github.com/tomstagl/cctop/releases/download/v0.3.1/cctop-0.3.1-x86_64-apple-darwin.tar.gz"
      sha256 "8cf16e96f45eed9d5c40f29f47f9eadd3c137d781bdd2454db0ec5dc6cb35c67"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tomstagl/cctop/releases/download/v0.3.1/cctop-0.3.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b8f8cf1f62681d105a45661c06eaa4107a5dde95ecd92e561f19ec95076a89ab"
    else
      url "https://github.com/tomstagl/cctop/releases/download/v0.3.1/cctop-0.3.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "31e68485e0437f901060fc6bd77c91855e4be70adb6621656a507d414fed7e90"
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
