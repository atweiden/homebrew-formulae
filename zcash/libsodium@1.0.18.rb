class LibsodiumAT1018 < Formula
  desc "NaCl networking and cryptography library"
  homepage "https://libsodium.org/"
  url "https://download.libsodium.org/libsodium/releases/libsodium-1.0.18.tar.gz"
  sha256 "6f504490b342a4f8a4c4a02fc9b866cbef8622d5df4e5452b46be121e46636c1"
  license "ISC"

  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  # see: zcash/zcash/depends/packages/libsodium.mk
  patch do
    url "https://github.com/zcash/zcash/raw/ba4b4791c12b7e3d97148f413dfd3c549e73c335/depends/patches/libsodium/1.0.15-pubkey-validation.diff"
    sha256 "96588b9fb1cc325d9466acd9449aeaff0ffedcfcf8a97093e0970c20bbb4d98c"
  end
  patch do
    url "https://github.com/zcash/zcash/raw/ba4b4791c12b7e3d97148f413dfd3c549e73c335/depends/patches/libsodium/1.0.15-signature-validation.diff"
    sha256 "74432876722a0ac2f1d46c8ebe4944194a77d51abb641099a1da9efa71706570"
  end

  def install
    ENV["DO_NOT_UPDATE_CONFIG_SCRIPTS"] = "1"
    system "./autogen.sh"
    args = %W[
      --disable-shared
      --enable-static
      --prefix=#{prefix}
    ]
    system "./configure", *args
    system "make", "check"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <assert.h>
      #include <sodium.h>

      int main()
      {
        assert(sodium_init() != -1);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}",
                   "-lsodium", "-o", "test"
    system "./test"
  end
end
