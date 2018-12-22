class Nqp < Formula
  desc "Lightweight Perl 6-like environment for virtual machines"
  homepage "https://github.com/perl6/nqp"
  url "https://rakudo.perl6.org/downloads/nqp/nqp-2018.12.tar.gz"
  sha256 "219db519ad5c1848e4528a56a506dd74b0839ca1d910788411f3bfedf5045d36"
  head "https://github.com/perl6/nqp.git"

  depends_on "make" => :build
  depends_on "perl" => :build
  depends_on "moarvm"

  def install
    moarvm = Formula["moarvm"]
    configure_args = [
      "--backends=moar",
      "--prefix=#{prefix}",
      "--with-moar=#{moarvm.bin}/moar",
    ]
    system "perl", "Configure.pl", *configure_args
    system "make"
    system "make", "install"
  end

  test do
    out = `#{bin}/nqp -e 'for (0,1,2,3,4,5,6,7,8,9) { print($_); }'`
    assert_equal "0123456789", out
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
