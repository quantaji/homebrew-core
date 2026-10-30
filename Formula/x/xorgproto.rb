class Xorgproto < Formula
  desc "X.Org: Protocol Headers"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2026.1.tar.gz"
  sha256 "7fa90e48cbaca6bc4c99d176e88c5c147ab0ed42358e14a0869ee9c8a610ae7e"
  license "MIT"
  compatibility_version 1

  livecheck do
    url :stable
    regex(/href=.*?xorgproto[._-]v?(\d+\.\d+(?:\.([0-8]\d*?)?\d(?:\.\d+)*)?)\.t/i)
  end

  bottle do
    root_url "https://github.com/quantaji/homebrew-intel-bottles/releases/download/2026-10"
    rebuild 1
    sha256 cellar: :any_skip_relocation, tahoe: "046808d2b6a6566f97c10eed44001b0bfc8e57247693be9a7d68216a1ad9f3a7"
  end

  depends_on "pkgconf" => [:build, :test]
  depends_on "util-macros" => :build

  def install
    args = %W[
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-silent-rules
    ]

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    assert_equal "-I#{include}", shell_output("pkg-config --cflags xproto").chomp
    assert_equal "-I#{include}/X11/dri", shell_output("pkg-config --cflags xf86driproto").chomp
  end
end
