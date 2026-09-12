# Rendered by .github/workflows/release.yml; placeholders are filled per tag.
class Cctop < Formula
  desc "btop-style live dashboard for Claude Code internals, in a pane beside your session"
  homepage "https://github.com/tomstagl/cctop"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tomstagl/cctop/releases/download/v0.1.1/cctop-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "ee3ccd00d48c60654a815d6ea60a836866ece4d698a281f1646a49742d798d61"
    else
      url "https://github.com/tomstagl/cctop/releases/download/v0.1.1/cctop-0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "2b28861f108ccdc76b8e3c1b8ef9c72b0b51117f1130e672c2ee22d3f33db4a0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tomstagl/cctop/releases/download/v0.1.1/cctop-0.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3dc6baecddb91600e26874c0c6115f2d3a3edb002a05d59190cf88a35006f242"
    else
      url "https://github.com/tomstagl/cctop/releases/download/v0.1.1/cctop-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0fe5be7f0ea669e32e43c0b6e4ed38f48dad04255c327ecdbead41310fef21bc"
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
