class Libxrandr < Formula
  desc "X.Org: X Resize, Rotate and Reflection extension library"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/lib/libXrandr-1.5.5.tar.xz"
  sha256 "72b922c2e765434e9e9f0960148070bd4504b288263e2868a4ccce1b7cf2767a"
  license "MIT"
  compatibility_version 1

  bottle do
    root_url "https://github.com/quantaji/homebrew-intel-bottles/releases/download/2026-10"
    rebuild 1
    sha256 cellar: :any, tahoe: "fa3361421a0d83922e69808ed1dcf83bf3f33d36d0f607df5d8790936baccfcc"
  end

  depends_on "pkgconf" => :build
  depends_on "libx11"
  depends_on "libxext"
  depends_on "libxrender"
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
      #include "X11/extensions/Xrandr.h"

      int main(int argc, char* argv[]) {
        XRRScreenSize size;
        return 0;
      }
    C
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
