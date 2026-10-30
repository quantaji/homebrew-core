class Ripgrep < Formula
  desc "Search tool like grep and The Silver Searcher"
  homepage "https://github.com/BurntSushi/ripgrep"
  url "https://github.com/BurntSushi/ripgrep/archive/refs/tags/15.2.0.tar.gz"
  sha256 "7605249d3eb0d5f170e3414498e3344e26b1e7a147aec518b57090b80036a562"
  license "Unlicense"
  compatibility_version 1
  head "https://github.com/BurntSushi/ripgrep.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/quantaji/homebrew-intel-bottles/releases/download/2026-10"
    rebuild 2
    sha256 cellar: :any, tahoe: "374c3e4285173c301cd2fa49f17dc8a904066130d3994a7a6e5b377a11cc7484"
  end

  depends_on "asciidoctor" => :build
  depends_on "pkgconf" => :build
  depends_on "rust" => :build
  depends_on "pcre2"

  deny_network_access!

  def fetch
    system "cargo", "fetch", *std_cargo_fetch_args
  end

  def install
    system "cargo", "install", *std_cargo_args(features: "pcre2")

    generate_completions_from_executable(bin/"rg", "--generate", shell_parameter_format: "complete-")
    (man1/"rg.1").write Utils.safe_popen_read(bin/"rg", "--generate", "man")
  end

  test do
    (testpath/"Hello.txt").write("Hello World!")
    system bin/"rg", "Hello World!", testpath
  end
end
