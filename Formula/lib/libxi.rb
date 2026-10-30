class Libxi < Formula
  desc "X.Org: Library for the X Input Extension"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/lib/libXi-1.8.4.tar.xz"
  sha256 "ddd6057b89a91903bc2f884d55c8467440906945e482c36547260dff28661afc"
  license "MIT"
  compatibility_version 1

  bottle do
    root_url "https://github.com/quantaji/homebrew-intel-bottles/releases/download/2026-10"
    rebuild 1
    sha256 cellar: :any, tahoe: "51c607045c70b32f1d33b47233194b11ab2516bd51657cfa58087e6f73c86140"
  end

  depends_on "pkgconf" => :build
  depends_on "libx11"
  depends_on "libxext"
  depends_on "libxfixes"
  depends_on "xorgproto"

  conflicts_with "libslax", because: "both install `libxi.a`"

  def install
    args = %W[
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-silent-rules
      --enable-docs=no
      --enable-specs=no
    ]

    system "./configure", *args, *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include "X11/extensions/XInput.h"

      int main(int argc, char* argv[]) {
        XDeviceButtonEvent event;
        return 0;
      }
    C
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
