class Jansson < Formula
  desc "C library for encoding, decoding, and manipulating JSON"
  homepage "https://digip.org/jansson/"
  url "https://github.com/akheron/jansson/releases/download/v2.15.1/jansson-2.15.1.tar.gz"
  sha256 "0c7114dc0b2d22a670724a1f95922029d7077c19dbf79a584cb8084d2f267f2f"
  license "MIT"
  compatibility_version 1

  bottle do
    root_url "https://github.com/quantaji/homebrew-intel-bottles/releases/download/2026-10"
    rebuild 1
    sha256 cellar: :any, tahoe: "22312bde075886aeebf4afa41c758f7ee1bcb0c609f3b4162f685528d74ff4c2"
  end

  deny_network_access!

  def install
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <jansson.h>
      #include <assert.h>

      int main()
      {
        json_t *json;
        json_error_t error;
        json = json_loads("\\"foo\\"", JSON_DECODE_ANY, &error);
        assert(json && json_is_string(json));
        json_decref(json);
        return 0;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-ljansson", "-o", "test"
    system "./test"
  end
end
