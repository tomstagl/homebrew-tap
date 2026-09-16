# Rendered by .github/workflows/release.yml; placeholders are filled per tag.
class Cctop < Formula
  desc "btop-style live dashboard for Claude Code internals, in a pane beside your session"
  homepage "https://github.com/tomstagl/cctop"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tomstagl/cctop/releases/download/v0.4.0/cctop-0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "f977b471476b77b1e488b172c40f11c91ff0c3c1822e7b93b02c1bb45f662656"
    else
      url "https://github.com/tomstagl/cctop/releases/download/v0.4.0/cctop-0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "b778330b3483071d69d0530bc96ceaf270fc2a28ab17382e63ba2365e4f03aa5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tomstagl/cctop/releases/download/v0.4.0/cctop-0.4.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c477b5dc8df47b13fade6fd6c138acdbcbb93ed21b6faee109d77eca88da59de"
    else
      url "https://github.com/tomstagl/cctop/releases/download/v0.4.0/cctop-0.4.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a884f8b5ef2ef6a60817501e98398a5b7aaa78b2a28b5b66b3238566ae500db1"
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
