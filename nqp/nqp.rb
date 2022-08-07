class Nqp < Formula
  desc "Lightweight Raku-like environment for virtual machines"
  homepage "https://github.com/Raku/nqp"
  url "https://rakudo.org/dl/nqp/nqp-2022.07.tar.gz"
  sha256 "58081c106d672a5406018fd69912c8d485fd12bf225951325c50c929a8232268"
  license "Artistic-2.0"

  livecheck do
    url "https://github.com/Raku/nqp/releases"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "libffi"
  depends_on "libtommath"
  depends_on "libuv"
  depends_on "moarvm"

  uses_from_macos "perl" => :build

  conflicts_with "rakudo-star", because: "rakudo-star currently ships with nqp included"

  def install
    # Work around Homebrew's directory structure and help find moarvm libraries
    inreplace "tools/build/gen-version.pl", "$libdir, 'MAST'", "'#{Formula["moarvm"].opt_share}/nqp/lib/MAST'"

    system "perl", "Configure.pl",
                   "--backends=moar",
                   "--prefix=#{prefix}",
                   "--with-moar=#{Formula["moarvm"].bin}/moar"
    system "make"
    system "make", "install"
  end

  test do
    out = shell_output("#{bin}/nqp -e 'for (0,1,2,3,4,5,6,7,8,9) { print($_) }'")
    assert_equal "0123456789", out
  end
end
