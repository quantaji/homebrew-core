class Libxv < Formula
  desc "X.Org: X Video (Xv) extension"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/lib/libXv-1.0.13.tar.xz"
  sha256 "7d34910958e1c1f8d193d828fea1b7da192297280a35437af0692f003ba03755"
  license "MIT"
  compatibility_version 1

  bottle do
    root_url "https://github.com/quantaji/homebrew-intel-bottles/releases/download/2026-10"
    rebuild 1
    sha256 cellar: :any, tahoe: "e40f6dd1ddf6ee6e6c3b8738d3949165448511a3c57bceee5224050b15fc78f0"
  end

  depends_on "pkgconf" => :build
  depends_on "util-macros" => :build
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
      #include "X11/Xlib.h"
      #include "X11/extensions/Xvlib.h"

      int main(int argc, char* argv[]) {
        XvEvent *event;
        return 0;
      }
    C
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
