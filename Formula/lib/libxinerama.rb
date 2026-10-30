class Libxinerama < Formula
  desc "X.Org: API for Xinerama extension to X11 Protocol"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/lib/libXinerama-1.1.6.tar.xz"
  sha256 "d00fc1599c303dc5cbc122b8068bdc7405d6fcb19060f4597fc51bd3a8be51d7"
  license "MIT"
  compatibility_version 1

  bottle do
    root_url "https://github.com/quantaji/homebrew-intel-bottles/releases/download/2026-10"
    rebuild 1
    sha256 cellar: :any, tahoe: "c0a2784d18596204938c0f2b20b8ae3f49ab6943e748db3debcaa1f983e8921e"
  end

  depends_on "pkgconf" => :build
  depends_on "libx11"
  depends_on "libxext"
  depends_on "xorgproto"

  def install
    args = %W[
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-silent-rules
    ]

    system "./configure", *args, *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include "X11/extensions/Xinerama.h"

      int main(int argc, char* argv[]) {
        XineramaScreenInfo info;
        return 0;
      }
    C
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
