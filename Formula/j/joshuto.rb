class Joshuto < Formula
  desc "Ranger-like terminal file manager written in Rust"
  homepage "https://github.com/kamiyaa/joshuto"
  url "https://github.com/kamiyaa/joshuto/archive/refs/tags/v0.9.9.tar.gz"
  sha256 "85a230183f7478dee7c29229d78313ee07b759e596e19292acf024d2e5735efa"
  license "LGPL-3.0-or-later"
  head "https://github.com/kamiyaa/joshuto.git", branch: "main"

  bottle do
    root_url "https://github.com/quantaji/homebrew-intel-bottles/releases/download/2026-10"
    rebuild 1
    sha256 cellar: :any_skip_relocation, tahoe: "4bc454741b330bb20caa7e8072ae3bbe2eda19ff6d3f7b92c748191c013e1beb"
  end

  depends_on "rust" => :build

  deny_network_access!

  def fetch
    system "cargo", "fetch", *std_cargo_fetch_args
  end

  def install
    system "cargo", "install", *std_cargo_args
    pkgetc.install Dir["config/*.toml"]

    generate_completions_from_executable(bin/"joshuto", "completions")
  end

  test do
    (testpath/"test.txt").write("Hello World!")
    spawn bin/"joshuto", "--path", testpath

    assert_match "joshuto-#{version}", shell_output("#{bin}/joshuto --version")
  end
end
