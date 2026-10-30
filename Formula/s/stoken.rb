class Stoken < Formula
  desc "Tokencode generator compatible with RSA SecurID 128-bit (AES)"
  homepage "https://github.com/stoken-dev/stoken"
  url "https://github.com/stoken-dev/stoken/archive/refs/tags/v0.93.tar.gz"
  sha256 "102e2d112b275efcdc20ef438670e4f24f08870b9072a81fda316efcc38aef9c"
  license "LGPL-2.1-or-later"
  revision 2

  bottle do
    root_url "https://github.com/quantaji/homebrew-intel-bottles/releases/download/2026-10"
    rebuild 1
    sha256 cellar: :any, tahoe: "0a73ee02a44593b13db807b1a3b9119fd6f20243f7c3e4f3fc15abe33a06ff5a"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build
  depends_on "libtomcrypt"

  uses_from_macos "libxml2"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "check"
    system "make", "install"
  end

  test do
    system bin/"stoken", "show", "--random"
  end
end
